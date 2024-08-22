package crapp.ui.display.icon;

import js.html.Element;
import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import crapp.ui.style.CrappUISizeReference;
import crapp.ui.style.data.CrappUIStyleData;
import priori.fontawesome.FontAwesomeIconType;
import priori.fontawesome.FontAwesomeIcon;

class CrappUIIcon extends CrappUIDisplay {

    @:isVar public var icon(get, set):FontAwesomeIconType = FontAwesomeIconType.COG;
    @:isVar public var size(default, set):CrappUISizeReference = CrappUISizeReference.LARGE;

    private var iconDisplay:FixedIcon;

    public function new() {
        super();

        this.tag = CrappUIStyleDefaultTagType.ICON;
    }

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

private class FixedIcon extends FontAwesomeIcon {
    override private function updateIcon():Void {

        this.dh.jselement.innerHTML = '<i class="${this.icon}"></i>';

        this.getFontAwesome().dom.i2svg(
            {
                node : this.dh.jselement,

                callback:function():Void {

                    var svg:Element = this.dh.jselement.getElementsByTagName("svg").item(0);

                    if (svg != null) {
                        svg.style.width = "100%";
                        svg.style.height = "100%";
                        svg.style.top = "0px";
                        svg.style.position = "absolute";
                    }
                }
            }
        );
    }
}