package crapp.ui.display.menu;

import crapp.ui.style.CrappUIStyle;
import crapp.ui.display.text.CrappUIText;
import crapp.ui.composite.builtin.DisabledEffectComposite;
import crapp.ui.composite.builtin.ButtonableComposite;
import crapp.ui.composite.builtin.OverEffectComposite;
import crapp.ui.display.layout.CrappUILayout;

@priori('
<priori>
    <view >
        <private:CrappUIText id="labelDisplay" />
    </view>
</priori>
')
class CrappUIMenuChild extends CrappUILayout {

    public var label(get, set):String;

    inline private function get_label():String return this.labelDisplay.text;
    inline private function set_label(value:String):String return this.labelDisplay.text = value;

    override function setup() {
        this.composite.add(OverEffectComposite);
        this.composite.add(ButtonableComposite);
        this.composite.add(DisabledEffectComposite);

        this.labelDisplay.tag = null;
    }

    override function paint() {
        super.paint();

        this.composite.get(OverEffectComposite).updateDisplay();
        this.composite.get(DisabledEffectComposite).updateDisplay();

        var style:CrappUIStyle = this.composite.get(OverEffectComposite).style;

        var space:Float = style.space;

        this.labelDisplay.x = space;
        this.labelDisplay.y = space;

        this.height = Math.round(this.labelDisplay.height + space * 2);
    }

    public function idealWidth():Float {
        var style:CrappUIStyle = this.composite.get(OverEffectComposite).style;
        var space:Float = style.space;

        return Math.round(this.labelDisplay.width + space * 2);
    }

}