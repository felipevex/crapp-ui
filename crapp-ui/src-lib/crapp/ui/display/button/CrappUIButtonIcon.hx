package crapp.ui.display.button;

import crapp.ui.style.CrappUISizeReference;
import priori.geom.PriColor;
import crapp.ui.display.button.CrappUIButtonable;
import priori.fontawesome.FontAwesomeIconType;
import crapp.ui.style.CrappUIStyle;
import priori.fontawesome.PriFAIcon;

class CrappUIButtonIcon extends CrappUIButtonable {
    
    public var iconColor(default, set):PriColor;

    private var icon:PriFAIcon;
    private var iconType:FontAwesomeIconType;

    public function new(iconType:FontAwesomeIconType) {
        this.iconType = iconType;

        super();
    }

    private function set_iconColor(value:PriColor):PriColor {
        this.iconColor = value;
        this.updateDisplay();
        return value;
    }

    override function setup() {
        super.setup();

        this.width = 30;
        this.height = 30;

        this.icon = new PriFAIcon();
        this.icon.icon = Std.string(this.iconType);

        this.addChildList([
            this.icon
        ]);
    }

    override function paint() {
        super.paint();
        
        var style:CrappUIStyle = this.style;

        this.icon.iconColor = this.iconColor == null
            ? style.primary
            : this.iconColor;

        this.corners = [Std.int(style.corners * CrappUISizeReference.SMALL)];

        this.icon.iconSize = Std.int(Math.min(this.height - 5, this.width - 5));
        this.icon.centerX = this.width/2;
        this.icon.centerY = this.height/2;
    }
}