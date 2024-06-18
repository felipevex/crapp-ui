package crapp.ui.style;

import priori.style.font.PriFontStyle;
import priori.geom.PriColor;

class CrappUIStyle {
    
    public var primary:CrappUIColor;
    public var background:CrappUIColor;
    public var size:Float;
    public var space:Float;
    public var fontFamily:String;
    public var corners:Float;

    public var font(get, null):PriFontStyle;

    public function new(
        primary:PriColor, 
        background:PriColor,
        size:Float,
        space:Float,
        fontFamily:String,
        corners:Float
    ) {
        this.primary = primary;
        this.background = background;
        this.size = size;
        this.space = space;
        this.fontFamily = fontFamily;
        this.corners = corners;
    }

    static public function bluePrint():CrappUIStyle {
        return new CrappUIStyle(
            0x4A6DE5, 
            0xFFFFFF, 
            13.0,
            10.0,
            'Saira, Open Sans',
            6
        );
    }

    private function get_font():PriFontStyle {
        return new PriFontStyle(
            this.primary.color, 
            this.fontFamily
        );
    }

}