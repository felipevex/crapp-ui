package crapp.ui.display.button;

import crapp.ui.composite.builtin.DisabledEffectComposite;
import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import crapp.ui.composite.builtin.ButtonableComposite;
import crapp.ui.composite.builtin.OverEffectComposite;
import tricks.layout.LayoutSize;
import tricks.layout.LayoutElement;
import priori.style.font.PriFontStyleAlign;
import priori.style.border.PriBorderStyle;
import crapp.ui.style.CrappUISizeReference;
import crapp.ui.style.CrappUIStyle;
import crapp.ui.display.text.CrappUIText;

/**
    A classe `CrappUIButton` representa um botão interativo na interface do usuário, permitindo a execução de ações ao ser clicado.
    #### Responsabilidades:
    - **Renderização de Botão**: Gerencia a exibição visual do botão, incluindo rótulo, tamanho e estilo.
    - **Interatividade**: Permite a interação do usuário através de efeitos visuais de hover, clique e estado desabilitado.
    - **Gerenciamento de Layout**: Ajusta automaticamente o tamanho e a posição do rótulo conforme o layout e as propriedades do botão.
    #### Eventos Emitidos:
    - Nenhum evento definido
    #### Ações Acionadas:
    - **actions.onClick**: Acionada quando o botão é clicado pelo usuário.
**/
@priori('
<priori>
    <view tag:L="CrappUIStyleDefaultTagType.BUTTON" >
        <private:CrappUIText id="displayLabel" text="BUTTON" />
    </view>
</priori>
')
class CrappUIButton extends CrappUIDisplay {

    /**
        Define se o botão deve ajustar automaticamente seu tamanho com base no conteúdo do rótulo.
        @default true
    **/
    @:isVar public var autoSize(default, set):Bool = true;

    /**
        Define o texto exibido como rótulo do botão.
        @return O texto atual do rótulo.
        @param value Novo texto a ser exibido no botão.
    **/
    public var label(get, set):String;

    override function get_layout():LayoutElement<CrappUIDisplay> {
        var layout = super.get_layout();

        layout.horizontal = {
            size : this.hLayoutSize,
        }

        if (this.autoSize) layout.children = [{x : 0, y : 0, width : this.width, height : this.height}];
        else layout.children = [];

        return layout;
    }

    override function set_layout(value:LayoutElement<CrappUIDisplay>):LayoutElement<CrappUIDisplay> {
        var layout = super.set_layout(value);

        if (layout.horizontal == null) this.autoSize = true;
        else {
            switch (layout.horizontal.size) {
                case null | LayoutSize.FIT: {
                    this.autoSize = true;
                }
                case LayoutSize.FLEX: {
                    this.autoSize = false;
                    this.width = layout.width;
                }
                case LayoutSize.FIXED: {
                    this.width = layout.width;
                }
            }
        }

        return layout;
    }

    override function setup() {
        this.composite.add(OverEffectComposite);
        this.composite.add(ButtonableComposite);
        this.composite.add(DisabledEffectComposite);

        this.displayLabel.actions.onResize = this.updateDisplay;
        this.displayLabel.tag = null;
        this.displayLabel.align = PriFontStyleAlign.CENTER;
    }

    private function set_autoSize(value:Bool):Bool {
        this.autoSize = value;
        this.displayLabel.autoSize = value;
        this.updateDisplay();
        return value;
    }

    private function get_label():String return this.displayLabel.text;
    private function set_label(value:String):String {
        if (this.displayLabel == null || value == this.displayLabel.text || value == null) return value;

        this.displayLabel.text = value;
        this.updateDisplay();

        return value;
    }

    private function paint_drawThisSize(autoSize:Bool, space:Float):Void {
        this.height = this.displayLabel.height + space * 2;

        if (autoSize) this.width = this.displayLabel.width + space * 3.5;
        else this.displayLabel.width = this.width - space * 3.5;
    }

    private function paint_drawLabelPosition(autoSize:Bool, space:Float):Void {
        this.displayLabel.startBatchUpdate();
        this.displayLabel.centerY = this.height/2 + 1;
        this.displayLabel.centerX = this.width/2;
        this.displayLabel.endBatchUpdate();
    }

    override private function paint():Void {
        this.composite.get(OverEffectComposite).updateDisplay();
        this.composite.get(DisabledEffectComposite).updateDisplay();

        var style:CrappUIStyle = this.composite.get(OverEffectComposite).style;

        this.corners = [Math.round(CrappUISizeReference.TINY * style.corners)];
        this.border = style.preventBorder || style.onColor.brightness >= style.color.brightness
            ? null
            : new PriBorderStyle(2, style.onColor.color);

        this.paint_drawThisSize(this.autoSize, style.space);
        this.paint_drawLabelPosition(this.autoSize, style.space);
    }

}