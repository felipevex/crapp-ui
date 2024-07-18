package crapp.ui.display.icon;

import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import crapp.ui.style.CrappUISizeReference;
import crapp.ui.style.data.CrappUIStyleData;
import priori.fontawesome.FontAwesomeIconType;
import priori.fontawesome.FontAwesomeIcon;

class CrappUIIcon extends CrappUIDisplay {

    @:isVar public var icon(get, set):FontAwesomeIconType = FontAwesomeIconType.COG;
    @:isVar public var size(default, set):CrappUISizeReference = CrappUISizeReference.LARGE;

    private var iconDisplay:FontAwesomeIcon;

    public function new() {
        super();

        this.tag = CrappUIStyleDefaultTagType.ICON;
    }

    override function setup() {
        super.setup();

        this.iconDisplay = new FontAwesomeIcon(this.icon);

        this.addChildList([
            this.iconDisplay
        ]);
    }

    override private function paint():Void {
        super.paint();

        var style:CrappUIStyleData = this.style;
        
        this.iconDisplay.icon = this.icon;
        this.iconDisplay.color = style.on_color;
        this.iconDisplay.size = style.size * this.size;
        
        this.setDisplaySize(this.iconDisplay.width, this.iconDisplay.height);
    }

    private function get_icon():FontAwesomeIconType return this.icon;
    private function set_icon(value:FontAwesomeIconType):FontAwesomeIconType {
        if (value == null || value == this.icon) return value;
        this.icon = value;
        this.updateDisplay();
        return value;
    }

    private function setDisplaySize(width:Float, height:Float):Void {
        super.set_width(width);
        super.set_height(height);
    }

    override function set_width(value:Float):Float return value;
    override function set_height(value:Float):Float return value;

    private function set_size(value:CrappUISizeReference):CrappUISizeReference {
        this.size = value;
        this.updateDisplay();
        return value;
    }
}