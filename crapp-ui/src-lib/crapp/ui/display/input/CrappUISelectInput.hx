package crapp.ui.display.input;

import crapp.ui.display.icon.types.CrappUIIconType;
import priori.fontawesome.FixedIcon;
import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import priori.types.PriTransitionType;
import js.Browser;
import priori.view.form.PriFormSelect;
import priori.event.PriKeyboardEvent;
import priori.system.PriKey;
import priori.style.font.PriFontStyle;
import priori.event.PriFocusEvent;
import priori.event.PriEvent;
import priori.view.text.PriText;
import priori.event.PriTapEvent;
import crapp.ui.style.CrappUISizeReference;
import crapp.ui.style.CrappUIStyle;

/**
    Componente de entrada de formulário do tipo seleção (dropdown). Fornece uma interface para seleção de um valor
    a partir de uma lista de opções.

    #### Responsabilidades:
    - **Entrada de dados por seleção**: Permite ao usuário escolher um valor entre várias opções predefinidas em um menu dropdown.
    - **Apresentação visual adaptativa**: Ajusta a exibição do componente conforme o estado (com foco, com valor selecionado).
    - **Validação de dados**: Realiza a validação automática dos dados quando configurado.
    - **Notificação de mudanças**: Notifica sobre alterações no valor selecionado.

    #### Eventos Emitidos:
    - **PriEvent.CHANGE**: Emitido quando o valor do campo de seleção é alterado pelo usuário.

    #### Ações Acionadas:
    - **actions.onChange**: Acionada quando o valor do campo de seleção é alterado.
    - **actions.onDelayedChange**: Acionada após um breve atraso quando o valor é alterado ou quando o campo perde o foco.
    - **actions.onSubmit**: Acionada quando a tecla ENTER é pressionada enquanto o campo está em foco.
**/
@:access(crapp.ui.display.icon)
@priori('
<priori>
    <view
        tag:L="CrappUIStyleDefaultTagType.SELECT_INPUT"
        width="300"
    />
</priori>
')
class CrappUISelectInput<T> extends CrappUIInput<T> {

    private var labelDisplay:PriText;
    private var input:PriFormSelect;
    private var arrow:FixedIcon;

    /**
        Define se o componente deve permitir a não seleção de nenhum item.
        Quando `true`, uma opção vazia será adicionada ao início da lista.

        @default true
    **/
    @:isVar public var allowNoSelection(default, set):Bool = true;

    /**
        Conjunto de dados que serão exibidos como opções para seleção.

        @default []
    **/
    @:isVar public var data(default, set):Array<T>;

    /**
        Nome do campo nos objetos de `data` que será usado como texto de exibição.

        @see labelFieldFunction
    **/
    public var labelField(get, set):String;

    /**
        Função que determina como o texto de uma opção será exibido no componente.
        Recebe um objeto do tipo `T` e deve retornar uma string que o representa.

        Se não for definida pelo usuário, o componente tentará converter diretamente
        o objeto para string usando a conversão padrão do Haxe. Para objetos complexos,
        é recomendável definir esta função para garantir uma representação adequada.

        @see labelField
    **/
    public var labelFieldFunction(get, set):(value:T)->String;

    /**
        Cria uma nova instância do componente de entrada do tipo seleção.
        Inicializa com uma largura padrão de 300 pixels e define o estilo base.
    **/
    public function new() {
        super();
        haxe.Timer.delay(this.allowTransition.bind(PriTransitionType.BACKGROUND_COLOR, 0.2), 1);
    }

    private function set_allowNoSelection(value:Bool):Bool {
        if (value == null || this.allowNoSelection == value) return value;

        this.allowNoSelection = value;
        var data = this.data;
        this.data = data;

        return value;
    }

    private function get_labelField():String return this.input.labelField;
    private function set_labelField(value:String):String {
        if (value == null) return value;
        this.input.labelField = value;
        return value;
    }

    private function get_labelFieldFunction():(value:T)->String return this.input.labelFieldFunction;
    private function set_labelFieldFunction(value:(value:T)->String):(value:T)->String {
        if (value == null) return value;

        this.input.labelFieldFunction = (v:T) -> {
            if (Std.isOfType(v, String) && Std.string(v) == '') return '';
            return value(v);
        };

        return value;
    }

    private function set_data(value:Array<T>):Array<T> {
        if (value == null) return value;
        this.data = value;

        var content:Array<Dynamic> = [];
        if (this.allowNoSelection) content.push("");
        if (this.data != null) for (item in this.data) content.push(item);

        this.input.data = content;

        return value;
    }

    override private function get_value():T {
        return this.input.selectedIndex == 0 && this.allowNoSelection
            ? null :
            this.input.selected;
    }

	override private function set_value(value:T):T {
        if (!this.allowNoSelection && value == null) return value;

        if (value == null) this.input.selectedIndex = 0;
		else this.input.selected = value;

        this.updateDisplay();
        return value;
	}

    override function setup() {
        super.setup();

        this.addEventListener(PriTapEvent.TAP, this.onTap);
        this.pointer = false;

        this.labelDisplay = new PriText();
        this.labelDisplay.mouseEnabled = false;
        this.labelDisplay.alpha = 0.8;
        this.labelDisplay.autoSize = false;
        this.labelDisplay.multiLine = false;
        this.labelDisplay.text = this.label;

        this.input = this.createInputSelect();

        this.arrow = new FixedIcon(CrappUIIconType.CARET_DOWN);

        this.addChildList([
            this.input,
            this.labelDisplay,
            this.arrow
        ]);
    }

    override function paint() {
        super.paint();

        var style:CrappUIStyle = CrappUIStyle.fromData(this.style);
        var font:PriFontStyle = style.font;

        this.labelDisplay.fontStyle = font;

        this.input.fontStyle = font;
        this.input.fontSize = style.size;

        this.paintBackground(style);
        this.paintBorder(style);
        this.paintCorners(style, CrappUISizeReference.SMALL);

        this.height = this.calculateNormalHeight();

        this.input.x = (style.space * 3.5) / 2;
        this.input.width = this.width - this.input.x;
        this.input.y = this.height - style.size * 1.485 - style.space;

        this.arrow.size = style.size;
        this.arrow.color = style.onColor.color;
        this.arrow.maxX = this.input.maxX - style.space;

        if (this.hasFocus()) this.bgColor = style.onFocusColor();

        if (this.hasContentOrSelection()) {
            this.labelDisplay.fontSize = CrappUISizeReference.UNDER * style.size;

            this.labelDisplay.y = style.space;
            this.labelDisplay.width = this.width - (style.space * 3.5);
            this.labelDisplay.centerX = this.width/2;

            this.arrow.centerY = this.input.centerY;
        } else {
            this.labelDisplay.fontSize = style.size;

            this.labelDisplay.width = this.width - (style.space * 3.5);
            this.labelDisplay.centerX = this.width/2;
            this.labelDisplay.centerY = this.height/2;

            this.arrow.centerY = this.labelDisplay.centerY;
        }

    }

    inline private function hasContentOrSelection():Bool {
        if (this.input.selected != null && (!this.allowNoSelection || this.input.selectedIndex > 0)) return true;
        else return false;
    }

    private function createInputSelect():PriFormSelect {
        var input:PriFormSelect = new PriFormSelect();

        (cast input)._baseElement.css('apearance', 'none');
        (cast input)._baseElement.css('-moz-appearance', 'none');
        (cast input)._baseElement.css('-webkit-appearance', 'none');

        input.addEventListener(PriEvent.CHANGE, this.onFieldChange);
        input.addEventListener(PriFocusEvent.FOCUS_IN, this.onFocus);
        input.addEventListener(PriFocusEvent.FOCUS_OUT, this.onFocus);

        return input;
    }

    override private function onKeyDown(e:PriKeyboardEvent):Void {
        if (e.keycode != PriKey.ENTER) return;
        if (this.actions.onSubmit != null) this.actions.onSubmit();
    }

    private function onFieldChange(e:PriEvent):Void {
        this.updateDisplay();

        this.executeChangeAction();
        this.dispatchEvent(new PriEvent(PriEvent.CHANGE));

        if (this.autoValidation) this.validateAndDisplayError();
    }

    private function onFocus(e:PriFocusEvent):Void {
        this.updateDisplay();

        if (e.type == PriFocusEvent.FOCUS_OUT) this.runPendingDelayedChange();
    }

    private function runPendingDelayedChange():Void {
        if (this.delayedChangeTimer == null) return;

        this.executeDelayedChangeAction(0);
        if (this.autoValidation) this.validateAndDisplayError();
    }

    override function setFocus() {
        this.input.setFocus();

        var el:Dynamic = Browser.document.getElementById(this.input.fieldId);
        if (el.showPicker != null) el.showPicker();
    }

    private function onTap(e:PriTapEvent):Void this.setFocus();

	override function set_label(value:String):String {
        if (value == null) return value;
        super.set_label(value);

        this.labelDisplay.text = this.label;
        this.updateDisplay();
        return value;
	}

}