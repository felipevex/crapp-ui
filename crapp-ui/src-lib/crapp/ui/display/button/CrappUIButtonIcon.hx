package crapp.ui.display.button;

import tricks.layout.LayoutElement;
import priori.fontawesome.FontAwesomeIcon;
import crapp.ui.style.CrappUISizeReference;
import crapp.ui.display.button.CrappUIButtonable;
import priori.fontawesome.FontAwesomeIconType;
import crapp.ui.style.CrappUIStyle;

class CrappUIButtonIcon extends CrappUIButtonable {
    
    private var icon:FontAwesomeIcon;

    @:isVar public var iconType(get, set):FontAwesomeIconType;

    public function new(?iconType:FontAwesomeIconType) {
        this.iconType = iconType == null ? FontAwesomeIconType.USER : iconType;

        super();
    }

    override function get_layout():LayoutElement<CrappUIStylableDisplay> {
        var layout = super.get_layout();

        layout.horizontal.size = FIXED;
        layout.vertical.size = FIXED;
        
        return layout;
    }

    private function get_iconType():FontAwesomeIconType return this.iconType;
    private function set_iconType(value:FontAwesomeIconType):FontAwesomeIconType {
        if (value == null || value == this.iconType) return value;
        this.iconType = value;
        this.updateDisplay();
        return value;
    }

    override function setup() {
        super.setup();

        this.icon = new FontAwesomeIcon();

        this.addChildList([
            this.icon
        ]);
    }

    override function paint() {
        super.paint();

        var style:CrappUIStyle = this.style;

        this.corners = [10000000];

        var space:Float = (style.space * 1.6) / 2;

        this.icon.x = space;
        this.icon.y = space;
        this.icon.icon = this.iconType;
        this.icon.color = style.primary.color;
        this.icon.size = style.size * CrappUISizeReference.LARGE;
        
        this.width = this.icon.maxX + space;
        this.height = this.icon.maxY + space;
    }
}