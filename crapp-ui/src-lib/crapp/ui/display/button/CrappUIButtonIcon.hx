package crapp.ui.display.button;

import crapp.ui.display.icon.CrappUIIcon;
import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import crapp.ui.composite.builtin.ButtonableComposite;
import crapp.ui.composite.builtin.OverEffectComposite;
import tricks.layout.LayoutElement;
import crapp.ui.style.CrappUISizeReference;
import crapp.ui.style.CrappUIStyle;

class CrappUIButtonIcon extends CrappUIIcon {
    
    public function new() {
        super();
        this.tag = CrappUIStyleDefaultTagType.BUTTON_ICON;
    }

    override function get_layout():LayoutElement<CrappUIDisplay> {
        var layout = super.get_layout();

        layout.horizontal.size = FIXED;
        layout.vertical.size = FIXED;
        
        return layout;
    }

    override function setup() {
        this.composite.add(OverEffectComposite);
        this.composite.add(ButtonableComposite);

        super.setup();
    }

    override function paint() {
        this.composite.get(OverEffectComposite).updateDisplay();

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