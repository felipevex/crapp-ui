package crapp.ui.display.line;

import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import crapp.ui.style.data.CrappUIStyleData;
import crapp.ui.display.line.types.CrappUILineStyleType;
import priori.geom.PriColor;
import crapp.ui.display.line.types.CrappUILineOrientationType;

class CrappUILine extends CrappUIDisplay {

    private var lineColor:PriColor = 0;
    private var pretendedSize:Float = 100;
    
    @:isVar public var thickness(default, set):Float = 1;
    @:isVar public var lineStyle(default, set):CrappUILineStyleType = CrappUILineStyleType.SOLID;
    @:isVar public var orientation(default, set):CrappUILineOrientationType = CrappUILineOrientationType.HORIZONTAL;

    public function new() {
        super();

        this.clipping = false;
        super.set_height(0);
        super.set_width(100);

        this.tag = CrappUIStyleDefaultTagType.LINE;
    }

    private function set_orientation(value:CrappUILineOrientationType):CrappUILineOrientationType {
        if (value == null || value == this.orientation) return value;

        switch (this.orientation) {
            case HORIZONTAL : {
                super.set_height(this.pretendedSize);
                super.set_width(0);
            }
            case VERTICAL : {
                super.set_width(this.pretendedSize);
                super.set_height(0);
            }
        }

        this.orientation = value;

        this.dh.styles.remove("border-top-color");
        this.dh.styles.remove("border-top-width");
        this.dh.styles.remove("border-top-style");
        this.dh.styles.remove("border-left-color");
        this.dh.styles.remove("border-left-width");
        this.dh.styles.remove("border-left-style");
        
        this.updateLineStyle();

        return value;
    }

    private function set_thickness(value:Float):Float {
        if (value == null) return value;

        this.thickness = value;
        this.updateDisplay();
        return value;
    }

    private function set_lineStyle(value:CrappUILineStyleType):CrappUILineStyleType {
        if (value == null) return value;

        this.lineStyle = value;
        this.updateLineStyle();

        return value;
    }

    override private function paint():Void {
        super.paint();

        var style:CrappUIStyleData = this.style;
        this.lineColor = style.on_color;

        this.updateLineStyle();   
    }

    private function updateLineStyle():Void {
        switch (this.orientation) {
            case HORIZONTAL : {
                this.dh.styles.set("border-top-color", this.lineColor.toString());
                this.dh.styles.set("border-top-width", '${this.thickness}px');
                this.dh.styles.set("border-top-style", this.lineStyle);
            }
            case VERTICAL : {
                this.dh.styles.set("border-left-color", this.lineColor.toString());
                this.dh.styles.set("border-left-width", '${this.thickness}px');
                this.dh.styles.set("border-left-style", this.lineStyle);
            }
        }

        this.__updateStyle();
    }

    override private function set_width(value:Float):Float {
        this.pretendedSize = value;
        if (this.orientation == CrappUILineOrientationType.VERTICAL) return value;
        else return super.set_width(value);
    }

    override private function get_width():Float {
        if (this.orientation == CrappUILineOrientationType.VERTICAL) return 0;
        else return super.get_width();
    }

    override private function set_height(value:Float):Float {
        this.pretendedSize = value;
        if (this.orientation == CrappUILineOrientationType.HORIZONTAL) return value;
        else return super.set_height(value);
    }

    override private function get_height():Float {
        if (this.orientation == CrappUILineOrientationType.HORIZONTAL) return 0;
        else return super.get_height();
    }

}