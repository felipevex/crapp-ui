package crapp.ui.display.input;

import priori.view.form.PriFormTextArea;
import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import priori.types.PriTransitionType;
import haxe.Timer;
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
   A classe `CrappUITextAreaInput` tem como finalidade gerenciar a entrada de texto multi-linha no componente de UI.
   #### Responsabilidades:
   - **Gerenciar Entrada de Texto Multi-linha**: controla e valida a entrada de dados utilizando `PriFormTextArea` e atualiza a exibição do rótulo.
   - **Atualização Visual**: renderiza o fundo, borda e cantos conforme o estilo definido em `CrappUIStyle` e ajusta o layout dos elementos.
   #### Eventos Emitidos:
   - **PriEvent.CHANGE**: emitido quando o valor da entrada é alterado.
   - **PriEvent.RESIZE**: emitido quando há alteração no tamanho do componente após a renderização.
   #### Ações Acionadas:
   - **actions.onSubmit**: acionada quando a tecla `ENTER` é pressionada.
   - **actions.onChange**: acionada quando ocorre uma alteração instantânea no valor.
   - **actions.onDelayedChange**: acionada após um atraso na alteração do valor, permitindo validações automáticas.
**/
@priori('
<priori>
    <view 
        tag:L="CrappUIStyleDefaultTagType.TEXT_AREA_INPUT" 
        width="300" 
    />
</priori>
')
class CrappUITextAreaInput extends CrappUIInput<String> {
    
    private var labelDisplay:PriText;
    private var input:PriFormTextArea;
    private var delayedChangeTimer:Timer;
    
    /**
       Construtor da classe `CrappUITextAreaInput` que inicializa o componente de área de texto.
       Define o `tag` como `TEXT_AREA_INPUT` e configura a largura padrão para 300.
       @default width = 300
    **/
    public function new() {
        super();
        haxe.Timer.delay(this.allowTransition.bind(PriTransitionType.BACKGROUND_COLOR, 0.2), 1);
    }

    override private function get_value():String return this.input.value;
	override private function set_value(value:String):String {
        if (value == null) return value;
		this.input.value = value;
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

        this.input = this.createForm();

        this.addChildList([
            this.input,
            this.labelDisplay
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
        
        var normalHeight:Float = this.calculateNormalHeight();
        var space:Float = style.space * 3.5/2;
        
        @:privateAccess this.input._baseElement.css('padding-right', '15px');
        this.input.width = this.width - space - 15;
        this.input.x = space;
        this.input.y = normalHeight - style.size * 1.485 - style.space;
        this.input.height = this.height - this.input.y;

        if (this.hasFocus()) this.bgColor = style.onFocusColor();
        
        if (this.hasContentOrSelection()) {
            this.labelDisplay.fontSize = CrappUISizeReference.UNDER * style.size;

            this.labelDisplay.y = style.space;
            this.labelDisplay.width = this.width - (style.space * 3.5);
            this.labelDisplay.centerX = this.width/2;
        } else {
            this.labelDisplay.fontSize = style.size;

            this.labelDisplay.width = this.width - (style.space * 3.5);
            this.labelDisplay.centerX = this.width/2;
            this.labelDisplay.centerY = normalHeight/2;
        }
        
    }

    inline private function hasContentOrSelection():Bool {
        if (this.input.hasFocus()) return true;
        else if (this.input.value.length > 0) return true;
        else return false;
    }

    private function createForm():PriFormTextArea {
        var input:PriFormTextArea = new PriFormTextArea();
        input.addEventListener(PriKeyboardEvent.KEY_DOWN, this.onKeyDown);
        input.addEventListener(PriEvent.CHANGE, this.onFieldChange);
        input.addEventListener(PriFocusEvent.FOCUS_IN, this.onFocus);
        input.addEventListener(PriFocusEvent.FOCUS_OUT, this.onFocus);

        @:privateAccess input._baseElement.css('overflow', 'auto');

        return input;
    }

    private function onKeyDown(e:PriKeyboardEvent):Void {
        if (e.keycode != PriKey.ENTER) return;
        if (this.delayedChangeTimer != null) this.runDelayedChangeEvent();
        if (this.actions.onSubmit != null) this.actions.onSubmit();
    }

    private function onFieldChange(e:PriEvent):Void {
        this.killTimer();

        this.delayedChangeTimer = Timer.delay(this.runDelayedChangeEvent, 600);
        
        if (this.actions.onChange != null) this.actions.onChange();

        this.dispatchEvent(new PriEvent(PriEvent.CHANGE));
    }

    private function onFocus(e:PriFocusEvent):Void {
        this.updateDisplay();

        if (e.type == PriFocusEvent.FOCUS_OUT && this.delayedChangeTimer != null) this.runDelayedChangeEvent();
    }

    inline private function runDelayedChangeEvent():Void {
        this.killTimer();
        if (this.actions.onDelayedChange != null) this.actions.onDelayedChange();
        
        if (this.autoValidation) this.validateAndDisplayError();
    }

    private function killTimer():Void {
        if (this.delayedChangeTimer == null) return;
        
        this.delayedChangeTimer.stop();
        this.delayedChangeTimer.run = null;
        this.delayedChangeTimer = null;
    }

    override function setFocus() {
        this.input.setFocus();
    }

    private function onTap(e:PriTapEvent):Void this.setFocus();
    
	override function set_label(value:String):String {
        if (value == null) return value;
        super.set_label(value);
        
        this.labelDisplay.text = this.label;
        this.updateDisplay();

        return value;
	}

    override function kill() {
        this.killTimer();
        super.kill();
    }
}