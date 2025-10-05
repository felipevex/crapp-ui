package crapp.ui.display.input;

import priori.style.shadow.PriShadowStyle;
import crapp.ui.style.CrappUISizeReference;
import helper.kits.StringKit;
import crapp.ui.composite.builtin.ButtonableComposite;
import crapp.ui.composite.builtin.OverEffectComposite;
import crapp.ui.composite.builtin.DisabledEffectComposite;
import crapp.ui.display.text.CrappUIText;
import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import priori.event.PriTapEvent;
import crapp.ui.style.CrappUIStyle;
import crapp.ui.display.CrappUIDisplay;

/**
    A classe `CrappUIToggleInput` é um componente de interface gráfica que implementa um controle de alternância (toggle switch) personalizado para aplicações Crapp UI. Este componente permite ao usuário alternar entre dois estados (ligado/desligado) através de uma interface visual intuitiva semelhante a um interruptor físico.

    #### Responsabilidades:
    - **Controle de Estado**: Gerencia o estado de seleção (ligado/desligado) através da propriedade `isSelected`
    - **Interface Visual**: Renderiza um componente visual com círculo deslizante e fundo colorido que reflete o estado atual
    - **Interação do Usuário**: Responde a eventos de toque e teclado para alternar o estado do toggle
    - **Customização Visual**: Aplica estilos personalizados incluindo cores, sombras e animações de transição
    - **Suporte a Rótulos**: Permite exibir texto descritivo ao lado do controle toggle
    - **Acessibilidade**: Fornece suporte para navegação por teclado através de métodos herdados
*/
@priori('
<priori>
    <view tag:L="CrappUIStyleDefaultTagType.TOGGLE" >
        <private:CrappUIText id="labelDisplay" tag:L="null" text="LABEL" />
        <private:CrappUIText id="reference" tag:L="null" alpha="0" mouseEnabled=":false" text="test" />

        <private:CrappUIDisplay id="toogleBg" >
            <private:CrappUIDisplay id="toogleCircle" />
        </private:CrappUIDisplay>

    </view>
</priori>
')
class CrappUIToggleInput<T> extends CrappUIInput<T> {

    /**
        Propriedade que controla o estado de seleção do toggle.
        Quando `true`, o toggle é exibido no estado "ligado" (ativado).
        Quando `false`, o toggle é exibido no estado "desligado" (desativado).
        A alteração desta propriedade automaticamente atualiza a exibição visual do componente.
    */
    @:isVar public var isSelected(get, set):Bool = false;

    private var currentValue:T;

    override function setup():Void {
        this.composite.add(ButtonableComposite);
        this.composite.add(DisabledEffectComposite);

        this.toogleBg.composite.add(OverEffectComposite);

        super.setup();

        this.toogleCircle.allowTransition(X, 0.25);
        this.toogleCircle.corners = [100];
        this.toogleCircle.bgColor = 0xFFFFFF;
        this.toogleCircle.shadow = [
            new PriShadowStyle()
            .setColor(0x000000)
            .setOpacity(0.2)
            .setSpread(2)
            .setBlur(4)
            .setHorizontalOffset(0)
            .setVerticalOffset(1)
        ];

        this.toogleBg.corners = [100];
        this.toogleBg.shadow = [
            new PriShadowStyle()
            .setType(INSET)
            .setColor(0x000000)
            .setOpacity(0.1)
            .setSpread(2)
            .setBlur(4)
            .setHorizontalOffset(0)
            .setVerticalOffset(0)
        ];

        this.addEventListener(PriTapEvent.TAP, this.onTap);
    }

    override function get_value():T return this.currentValue;
    override function set_value(value:T):T return this.currentValue = value;

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

        var toggleHeight:Float = style.size * CrappUISizeReference.EXTRA;
        var toggleWidth:Float = toggleHeight + toggleHeight * 3/4;

        this.toogleBg.width = toggleWidth;
        this.toogleBg.height = toggleHeight;

        this.toogleCircle.width = toggleHeight - 4;
        this.toogleCircle.height = toggleHeight - 4;
        this.toogleCircle.centerY = toggleHeight / 2;
        this.toogleCircle.x = this.isSelected ? toggleWidth - toggleHeight + 2 : 2;

        this.updateToggleDisplay();

        var textHeight:Float = this.reference.height + (padding * 2);
        var referenceHeight:Float = Math.max(textHeight, toggleHeight);

        if (StringKit.isEmpty(this.label)) {
            this.width = toggleWidth;
            this.height = toggleHeight;

            this.toogleBg.x = 0;
            this.toogleBg.y = 0;

            return;
        }

        this.toogleBg.centerY = referenceHeight / 2;

        this.labelDisplay.x = this.toogleBg.maxX + space;
        this.labelDisplay.y = referenceHeight/2 - textHeight/2 + padding;

        this.height = Math.max(referenceHeight, this.labelDisplay.maxY + padding);
        this.width = this.labelDisplay.maxX + padding * 2;
    }

    private function updateToggleDisplay():Void {
        var style:CrappUIStyle = CrappUIStyle.fromData(this.style);

        this.toogleBg.style = {
            on_color: this.isSelected ? style.onColor : 0x636363,
            color: this.isSelected ? style.onColor : 0xCCCCCC
        };

        this.toogleBg.composite.get(OverEffectComposite).updateDisplay();
    }

    private function onTap(e:PriTapEvent):Void {
        this.isSelected = !this.isSelected;
    }

    private function get_isSelected():Bool return this.isSelected;
    private function set_isSelected(value:Bool):Bool {
        if (value == null) return value;

        this.isSelected = value;
        this.updateDisplay();

        return value;
    }

    override private function onKeyboardActionable():Void {
        this.isSelected = !this.isSelected;
    }

}
