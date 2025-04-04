package crapp.ui.display.line;

import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import crapp.ui.style.data.CrappUIStyleData;
import crapp.ui.display.line.types.CrappUILineStyleType;
import crapp.ui.display.line.types.CrappUILineOrientationType;

@priori('
<priori>
    <view 
        tag:L="CrappUIStyleDefaultTagType.LINE" 
        clipping=":false" 
        orientation="HORIZONTAL"
        />
</priori>
')
class CrappUILine extends CrappUIDisplay {

    private var size:Float = 100;
    
    @:isVar public var thickness(default, set):Float = 1;
    @:isVar public var lineStyle(default, set):CrappUILineStyleType = CrappUILineStyleType.SOLID;
    @:isVar public var orientation(default, set):CrappUILineOrientationType;

    private function set_orientation(value:CrappUILineOrientationType):CrappUILineOrientationType {
        if (value == null || value == this.orientation) return value;
        this.orientation = value;

        var size:Float = this.size;

        switch (value) {
            case HORIZONTAL : {
                this.height = this.thickness;
                this.width = size;
            }
            case VERTICAL : {
                this.width = this.thickness;
                this.height = size;
            }
        }

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

        switch (this.orientation) {
            case HORIZONTAL : this.height = this.thickness;
            case VERTICAL : this.width = this.thickness;
        }

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
        this.updateLineStyle();   
    }

    private function updateLineStyle():Void {
        var style:CrappUIStyleData = this.style;

        switch (this.orientation) {
            case HORIZONTAL : {
                this.dh.styles.set("border-top-color", style.on_color.toString());
                this.dh.styles.set("border-top-width", '${this.thickness}px');
                this.dh.styles.set("border-top-style", this.lineStyle);
            }
            case VERTICAL : {
                this.dh.styles.set("border-left-color", style.on_color.toString());
                this.dh.styles.set("border-left-width", '${this.thickness}px');
                this.dh.styles.set("border-left-style", this.lineStyle);
            }
        }

        this.__updateStyle();
    }

    override private function set_width(value:Float):Float {
        this.size = value;
        super.set_width(this.orientation == CrappUILineOrientationType.HORIZONTAL ? value : 0);
        return value;
    }

    override private function set_height(value:Float):Float {
        this.size = value;
        super.set_height(this.orientation == CrappUILineOrientationType.VERTICAL ? value : 0);
        return value;
    }

    override private function get_width():Float return switch (this.orientation) {
        case HORIZONTAL : super.get_width();
        case VERTICAL : this.thickness;
    };
    
    override private function get_height():Float return switch (this.orientation) {
        case HORIZONTAL : this.thickness;
        case VERTICAL : super.get_height();
    };

}