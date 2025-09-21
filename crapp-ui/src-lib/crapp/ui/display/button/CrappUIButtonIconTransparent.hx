package crapp.ui.display.button;

import crapp.ui.composite.builtin.DisabledEffectComposite;
import crapp.ui.display.icon.CrappUIIcon;
import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import crapp.ui.composite.builtin.ButtonableComposite;
import crapp.ui.composite.builtin.OverEffectComposite;
import tricks.layout.LayoutElement;
import crapp.ui.style.CrappUIStyle;
import crapp.ui.display.CrappUIDisplay;

@priori('
<priori>
    <view tag:L="CrappUIStyleDefaultTagType.BUTTON_ICON" >
        <CrappUIDisplay id="bg" />
    </view>
</priori>
')
class CrappUIButtonIconTransparent extends CrappUIIcon {

    override function get_layout():LayoutElement<CrappUIDisplay> {
        var layout = super.get_layout();

        layout.horizontal.size = FIXED;
        layout.vertical.size = FIXED;

        return layout;
    }

    override function setup() {

        this.composite.add(OverEffectComposite);
        this.composite.add(ButtonableComposite);
        this.composite.add(DisabledEffectComposite);

        this.composite.get(OverEffectComposite).target = this.bg;
        this.composite.get(OverEffectComposite).mixFocusColor = true;
        this.composite.get(OverEffectComposite).isAlphaEffect = true;

        super.setup();

        this.corners = [10000000];
        this.bg.corners = [10000000];
    }

    override function paint() {
        this.composite.get(OverEffectComposite).updateDisplay();
        this.composite.get(DisabledEffectComposite).updateDisplay();

        var style:CrappUIStyle = this.composite.get(OverEffectComposite).style;

        var space:Float = (style.space * 1.6) / 2;

        this.iconDisplay.x = space;
        this.iconDisplay.y = space;
        this.iconDisplay.color = style.onColor;
        this.iconDisplay.icon = this.icon;
        this.iconDisplay.size = style.size * this.size;

        this.setDisplaySize(this.iconDisplay.maxX + space, this.iconDisplay.maxY + space);

        this.bg.width = this.width;
        this.bg.height = this.height;
    }
}