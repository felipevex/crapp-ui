package crapp.ui.display.input;

import helper.kits.StringKit;
import crapp.ui.composite.builtin.ButtonableComposite;
import crapp.ui.composite.builtin.OverEffectComposite;
import crapp.ui.composite.builtin.DisabledEffectComposite;
import crapp.ui.display.text.CrappUIText;
import crapp.ui.display.icon.CrappUIIcon;
import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import priori.event.PriTapEvent;
import crapp.ui.style.CrappUIStyle;
import crapp.ui.display.CrappUIDisplay;

/**
    A classe `CrappUICheckInput` tem como finalidade fornecer um componente de interface gráfica para entrada de dados do tipo checkbox, permitindo ao usuário selecionar ou desselecionar uma opção através de interação visual e por teclado. O componente apresenta um ícone de checkbox acompanhado opcionalmente de um rótulo descritivo, oferecendo feedback visual de estado e efeitos de interação.

    #### Responsabilidades:
    - **Gerenciamento de Estado de Seleção**: Controla e mantém o estado selecionado/não selecionado do checkbox
    - **Renderização Visual**: Exibe o ícone do checkbox e o rótulo de forma apropriada conforme o estado atual
    - **Interação do Usuário**: Responde a eventos de toque/clique e navegação por teclado para alternar o estado
    - **Feedback Visual**: Fornece efeitos visuais como hover e foco para melhorar a experiência do usuário
    - **Layout Responsivo**: Calcula e ajusta automaticamente o posicionamento e dimensões dos elementos internos
**/
@priori('
<priori>
    <view tag:L="CrappUIStyleDefaultTagType.CHECK" >
        <private:CrappUIDisplay id="bg" />
        <private:CrappUIIcon id="iconDisplay" tag:L="null" size="EXTRA" icon="" />

        <private:CrappUIText id="labelDisplay" tag:L="null" text="LABEL" />
        <private:CrappUIText id="reference" tag:L="null" alpha="0" mouseEnabled=":false" text="test" />
    </view>
</priori>
')
class CrappUICheckInput<T> extends CrappUIInput<T> {

    /**
        Propriedade que indica se o checkbox está atualmente selecionado ou não.
        Quando alterada, automaticamente atualiza a representação visual do ícone do checkbox.
    **/
    @:isVar public var isSelected(get, set):Bool = false;

    /**
        Propriedade que controla o dimensionamento automático do componente.

        Quando definida como `true` (padrão), o componente ajusta automaticamente sua largura
        para acomodar o conteúdo do rótulo (label), permitindo que o texto seja exibido em uma
        única linha. Quando definida como `false`, o componente mantém a largura definida
        manualmente e o texto do rótulo pode quebrar em múltiplas linhas se necessário.
    **/
    @:isVar public var autoSize(default, set):Bool = true;

    private var currentValue:T;

    override function setup():Void {
        this.composite.add(OverEffectComposite);
        this.composite.add(ButtonableComposite);
        this.composite.add(DisabledEffectComposite);

        this.composite.get(OverEffectComposite).target = this.bg;
        this.composite.get(OverEffectComposite).mixFocusColor = true;
        this.composite.get(OverEffectComposite).isAlphaEffect = true;

        super.setup();

        this.addEventListener(PriTapEvent.TAP, this.onTap);
        this.updateSelectedIcon();
    }

    override function get_value():T return this.currentValue;
    override function set_value(value:T):T return this.currentValue = value;

    private function set_autoSize(value:Bool):Bool {
        if (value == null) return value;

        this.autoSize = value;

        this.labelDisplay.autoSize = value;
        this.labelDisplay.multiLine = !value;

        this.updateDisplay();

        return value;
    }

    override function set_label(value:String):String {
        super.set_label(value);
        this.labelDisplay.text = value;
        this.updateDisplay();
        return value;
    }

    override function paint():Void {
        super.paint();

        var style:CrappUIStyle = CrappUIStyle.fromData(this.style);

        var space:Float = style.space;
        var padding:Float = Math.floor(style.space / 3);

        var textHeight:Float = this.reference.height + (padding * 2);
        var iconHeight:Float = this.iconDisplay.height + (padding * 2);
        var referenceHeight:Float = Math.max(textHeight, iconHeight);

        if (StringKit.isEmpty(this.label)) {
            this.width = this.height = referenceHeight;

            this.iconDisplay.centerX = this.width / 2;
            this.iconDisplay.centerY = this.height / 2;

            this.bg.width = this.width;
            this.bg.height = this.height;
            this.bg.corners = [100];

            return;
        }

        this.iconDisplay.x = padding;
        this.iconDisplay.centerY = referenceHeight / 2;

        this.labelDisplay.x = this.iconDisplay.maxX + space;
        this.labelDisplay.y = referenceHeight/2 - textHeight/2 + padding;

        if (this.autoSize) {
            this.width = this.labelDisplay.maxX + padding * 2;
        } else {
            this.labelDisplay.width = this.width - this.labelDisplay.x;
        }

        this.height = Math.max(referenceHeight, this.labelDisplay.maxY + padding);

        this.bg.width = this.width;
        this.bg.height = this.height;
        this.bg.corners = [Math.floor(this.iconDisplay.height / 2 + padding)];
    }

    private function onTap(e:PriTapEvent):Void {
        this.isSelected = !this.isSelected;
        this.executeChangeAction();
    }

    private function get_isSelected():Bool return this.isSelected;
    private function set_isSelected(value:Bool):Bool {
        if (value == null) return value;

        this.isSelected = value;
        this.updateSelectedIcon();

        return value;
    }

    private function updateSelectedIcon():Void {
        this.iconDisplay.icon = this.isSelected
            ? CHECK_SQUARE_REGULAR
            : SQUARE_REGULAR;
    }

    override private function onKeyboardActionable():Void {
        this.isSelected = !this.isSelected;
    }


}
