package crapp.ui.display.button;

import crapp.ui.composite.builtin.DisabledEffectComposite;
import crapp.ui.display.icon.CrappUIIcon;
import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import crapp.ui.composite.builtin.ButtonableComposite;
import crapp.ui.composite.builtin.OverEffectComposite;
import tricks.layout.LayoutElement;
import crapp.ui.style.CrappUIStyle;

@priori('
<priori>
    <view tag:L="CrappUIStyleDefaultTagType.BUTTON_ICON" />
</priori>
')
class CrappUIButtonIcon extends CrappUIIcon {

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

        super.setup();
    }

    override function paint() {
        this.composite.get(OverEffectComposite).updateDisplay();
        this.composite.get(DisabledEffectComposite).updateDisplay();

        var style:CrappUIStyle = this.composite.get(OverEffectComposite).style;

        this.corners = [10000000];

        var space:Float = (style.space * 1.6) / 2;

        this.iconDisplay.x = space;
        this.iconDisplay.y = space;
        this.iconDisplay.color = style.onColor;
        this.iconDisplay.icon = this.icon;
        this.iconDisplay.size = style.size * this.size;
        
        this.setDisplaySize(this.iconDisplay.maxX + space, this.iconDisplay.maxY + space);
    }
}