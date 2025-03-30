package crapp.ui.display.icon;

import priori.fontawesome.FixedIcon;
import crapp.ui.display.icon.types.CrappUIIconType;
import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import crapp.ui.style.CrappUISizeReference;
import crapp.ui.style.data.CrappUIStyleData;

@priori('
<priori>
    <view tag:L="CrappUIStyleDefaultTagType.ICON" />
</priori>
')
class CrappUIIcon extends CrappUIDisplay {

    @:isVar public var icon(default, set):CrappUIIconType = CrappUIIconType.COG;
    @:isVar public var size(default, set):CrappUISizeReference = CrappUISizeReference.LARGE;

    private var iconDisplay:FixedIcon;

    override function setup() {
        
        super.setup();

        this.clipping = false;

        this.iconDisplay = new FixedIcon(this.icon);
        this.iconDisplay.clipping = false;

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

    private function set_icon(value:CrappUIIconType):CrappUIIconType {
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
