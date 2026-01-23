package crapp.ui.display;

import priori.geom.PriColor;
import priori.event.PriEvent;
import crapp.ui.style.data.CrappUIStyleData;
import crapp.ui.style.CrappUIStyleManager;
import priori.app.PriApp;
import priori.style.shadow.PriShadowStyle;
import priori.style.border.PriBorderStyle;
import priori.view.builder.PriBuilder;
import tricks.layout.LayoutElement;
import tricks.layout.LayoutSize;
import crapp.ui.resource.CrappUIActionsResource;
import crapp.ui.style.CrappUIStyle;
import crapp.ui.style.CrappUISizeReference;
import crapp.ui.composite.CrappUICompositeManager;
import crapp.ui.interfaces.ICrappUIStyleObject;

/**
   A classe CrappUIDisplay tem como finalidade renderizar um componente visual na aplicação.

   #### Responsabilidades:
   - **Gerenciamento de Estilo**: Aplicar e atualizar temas, cores, bordas, sombras e demais configurações visuais.
   - **Manipulação de Composição**: Agregar e propagar mudanças entre os elementos visuais através de um gerenciador composto.
   - **Interação com Eventos**: Responder a eventos de redimensionamento e atualização para manter a exibição atualizada.
   #### Eventos Emitidos:
   - **PriEvent.RESIZE**: Disparado quando o componente detecta uma alteração de tamanho.
**/
class CrappUIDisplay extends PriBuilder implements ICrappUIStyleObject {

    /**
       Variável que define a profundidade do componente na árvore de exibição e projeta uma sombra obre os outros componentes.
       @default 0
    **/
    @:isVar public var z(default, set):Float = 0;

    /**
       Define se o componente deve exibir sombra com base no valor de profundidade (z).
       Quando verdadeiro, uma sombra será projetada de acordo com o valor de z.
       @default true
    **/
    @:isVar public var zShadow(default, set):Bool = true;

    public var isScreenSmall(get, never):Bool;
    public var isScreenPortrait(get, never):Bool;
    public var isScreenBig(get, never):Bool;
    public var isScreenLandscape(get, never):Bool;

    /**
       Define a cor da sombra projetada pelo componente quando zShadow é verdadeiro.
       A opacidade e intensidade da sombra são calculadas com base no valor de z.
       @default 0x000000 (preto)
    **/
    @:isVar public var zShadowColor(default, set):PriColor = 0x000000;

    private var styleManager:CrappUIStyleManager;

    /**
       Propriedade que define o tema utilizado pelo componente.
    **/
    public var theme(get, set):String;

    /**
       Propriedade que define a tag identificadora do componente para aplicação de estilos.
    **/
    public var tag(get, set):String;

    /**
       Propriedade que define a variante de estilo utilizada pelo componente.
    **/
    public var variant(get, set):String;

    /**
       Propriedade que armazena os dados de estilo do componente. É possível também aplicar uma sobreposição dos estilos ao aplicar um valor.
       Defina style `null` para remover a sobreposição.
    **/
    public var style(get, set):CrappUIStyleData;

    /**
       Indica se o componente possui restrição horizontal definida.
    **/
    public var hasHorizontalConstraint(get, null):Bool;

    /**
       Indica se o componente possui restrição vertical definida.
    **/
    public var hasVerticalConstraint(get, null):Bool;

    /**
       Agrupa as ações associadas ao componente.
    **/
    @:isVar public var actions(get, null):CrappUIActionsResource;

    /**
       Propriedade que representa o layout do componente, definindo posição, dimensões e filhos.
    **/
    public var layout(get, set):LayoutElement<CrappUIDisplay>;

    /**
       Propriedade que define o tamanho horizontal do layout.
       @default LayoutSize.FIXED
    **/
    @:isVar public var hLayoutSize(default, set):LayoutSize = LayoutSize.FIXED;

    /**
       Propriedade que define o tamanho vertical do layout.
       @default LayoutSize.FIXED
    **/
    @:isVar public var vLayoutSize(default, set):LayoutSize = LayoutSize.FIXED;

    /**
       Gerencia a composição dos elementos visuais e as transições aplicadas ao componente.
    **/
    public var composite:CrappUICompositeManager;

    public function new() {
        this.composite = new CrappUICompositeManager(this);
        this.styleManager = new CrappUIStyleManager();

        super();

        this.styleManager.start(this);
    }

    override private function ___onResize(e:PriEvent):Void {
        this.updateDisplay();
        if (this.actions.onResize != null) this.actions.onResize();
    }

    /**
       Retorna true se o componente estiver em modo retrato.
       @returns Booleano indicando se a exibição está em modo retrato.
    **/
    @:deprecated("Use isScreenPortrait instead.")
    public function isPortraitDisplay():Bool {
        if (PriApp.g().width >= PriApp.g().height) return false;
        return true;
    }

    /**
       Retorna true se o componente estiver em modo paisagem.
       @returns Booleano indicando se a exibição está em modo paisagem.
    **/
    @:deprecated("Use isScreenLandscape instead.")
    public function isLandscapeDisplay():Bool {
        return !this.isPortraitDisplay();
    }

    inline private function get_isScreenSmall():Bool return (PriApp.g().width <= 768);
    inline private function get_isScreenPortrait():Bool return (PriApp.g().width < PriApp.g().height);
    inline private function get_isScreenBig():Bool return !this.isScreenSmall;
    inline private function get_isScreenLandscape():Bool return !this.isScreenPortrait;

    override private function updateDepth():Void {
        if (this.dh.parent == null) return;

        this.dh.depth = this.dh.parent.dh.depth - 1;
        this.dh.styles.set("z-index", Std.string(this.dh.depth + Math.floor(this.z)));

        if (this.dh.elementBorder != null) this.dh.elementBorder.style.zIndex = Std.string(this.dh.depth + Math.floor(this.z));

        this.__updateStyle();
    }

    private function updateZShadow():Void {
        if (!this.zShadow || this.z <= 0) {
            this.shadow = null;
            return;
        }

        var val:Float = this.z;

        // hard shadow
        var keyLight:PriShadowStyle = new PriShadowStyle()
        .setColor(this.zShadowColor)
        .setVerticalOffset(0.2 + val * 0.9)
        .setBlur(0.2 + val * 0.8 + (val*val) * 0.04)
        .setOpacity((val + 14 + val * 0.4 - (val*val*0.05)) / 100)
        .setSpread(0.3 - val * 0.1);

        // soft shadow
        var ambientLight:PriShadowStyle = new PriShadowStyle()
        .setColor(this.zShadowColor)
        .setVerticalOffset(0)
        .setBlur(val * 2)
        .setOpacity((val + 5 + val * 0.11 - (val*val*0.03)) / 100)
        .setSpread(0);

        this.shadow = [keyLight, ambientLight];
    }

    private function set_zShadow(value:Bool):Bool {
        this.zShadow = value;
        this.updateZShadow();
        return value;
    }

    private function set_zShadowColor(value:PriColor):PriColor {
        this.zShadowColor = value;
        this.updateZShadow();
        return value;
    }

    private function set_z(value:Float):Float {
        var val:Float = value;

        if (value == null || value < 0.1) val = 0;
        else val = value;

        if (val == this.z) return value;
        else this.z = val;

        this.updateDepth();
        this.updateZShadow();

        return value;
    }

    private function get_actions():CrappUIActionsResource {
        if (this.actions == null) this.actions = {};
        return this.actions;
    }

    function get_style():CrappUIStyleData return this.styleManager.getStyle();

    /**
       Define os dados de estilo do componente e atualiza o gerenciador de estilo.
       @param value Novos dados de estilo a serem aplicados.
       @returns CrappUIStyleData com os dados de estilo atualizados.
    **/
	function set_style(value:CrappUIStyleData):CrappUIStyleData return this.styleManager.setStyle(value);

    function get_theme():String return this.styleManager.getTheme();

    function set_theme(value:String):String return this.styleManager.setTheme(value);

    function get_tag():String return this.styleManager.getTag();

    function set_tag(value:String):String return this.styleManager.setTag(value);

    function get_variant():String return this.styleManager.getVariant();

    function set_variant(value:String):String return this.styleManager.setVariant(value);

    override public function addChildList(childList:Array<Dynamic>):Void {
        super.addChildList(childList);
        this.styleManager.doPropagateChanges();
    }

    override public function removeChildList(childList:Array<Dynamic>):Void {
        super.removeChildList(childList);
        this.updateDisplay();
    }

    override function set_disabled(value:Bool):Bool {
        this.mouseEnabled = !value;
        var result:Bool = super.set_disabled(value);
        this.updateDisplay();
        return result;
    }

    function get_layout():LayoutElement<CrappUIDisplay> {
		var layout:LayoutElement<CrappUIDisplay> = {
            ref : this,

            x : this.x,
            y : this.y,
            width : this.width,
            height : this.height,

            children : [],
            isContainer : false
        }

        layout.horizontal = {
            gap : 0,
            size : this.hLayoutSize,
            alignment : MIN,
            distribution : NONE
        }

        layout.vertical = {
            gap : 0,
            size : this.vLayoutSize,
            alignment : MIN,
            distribution : NONE
        }

        return layout;
	}

    function set_layout(value:LayoutElement<CrappUIDisplay>):LayoutElement<CrappUIDisplay> {

        this.startBatchUpdate();
        if (!this.hasHorizontalConstraint) this.x = value.x;
        if (!this.hasVerticalConstraint) this.y = value.y;

        if (!this.hasHorizontalConstraint) this.width = value.width;
        if (!this.hasVerticalConstraint) this.height = value.height;
        this.endBatchUpdate();

        return value;
    }

    function get_hasHorizontalConstraint():Bool {
        if (this.left != null || this.right != null) return true;
        return false;
	}

	function get_hasVerticalConstraint():Bool {
        if (this.top != null || this.bottom != null) return true;
        return false;
	}

	function set_hLayoutSize(value:LayoutSize):LayoutSize {
		this.hLayoutSize = value;
        this.updateDisplay();
        return value;
	}

	function set_vLayoutSize(value:LayoutSize):LayoutSize {
		this.vLayoutSize = value;
        this.updateDisplay();
        return value;
	}

    private function paintBackground(style:CrappUIStyle):Void {
        this.bgColor = style.color.color;
    }

    private function paintBorder(style:CrappUIStyle):Void {
        this.border = style.preventBorder
            ? null
            : new PriBorderStyle(2, style.onColor.color.mix(style.color.color, 0.5));
    }

    private function paintCorners(style:CrappUIStyle, size:CrappUISizeReference):Void {
        this.corners = [Math.round(style.corners * size.toFloat())];
    }

    override function kill() {
        this.composite.reset();
        for (c in this.composite) c.kill();

        this.actions = null;

        super.kill();
    }
}