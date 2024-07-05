package crapp.ui.style;

import priori.style.font.PriFontStyle;
import priori.geom.PriColor;

class CrappUIStyle {

    public var data(get, set):CrappUIStyleData;
    
    public var primary:CrappUIColor;
    public var background:CrappUIColor;
    public var size:Float;
    public var space:Float;
    public var fontFamily:String;
    public var corners:Float;

    public var font(get, null):PriFontStyle;

    public var selectedColorWeight:Float = 0.06;

    public function new(
        primary:PriColor = 0x4A6DE5,
        background:PriColor = 0xFFFFFF, 
        size:Float = 13.0,
        space:Float = 10.0,
        fontFamily:String = 'Saira, Open Sans',
        corners:Float = 6
    ) {
        this.primary = primary;
        this.background = background;
        this.size = size;
        this.space = space;
        this.fontFamily = fontFamily;
        this.corners = corners;
    }

    private function get_data():CrappUIStyleData {
        return {
            primary : this.primary,
            background : this.background,
            size : this.size,
            space : this.space,
            fontFamily : this.fontFamily,
            corners : this.corners,
            selectedColorWeight : this.selectedColorWeight
        };
    }

    private function set_data(value:CrappUIStyleData):CrappUIStyleData {
        if (value == null) return value;

        if (value.primary != null) this.primary = value.primary;
        if (value.background != null) this.background = value.background;
        if (value.size != null) this.size = value.size;
        if (value.space != null) this.space = value.space;
        if (value.fontFamily != null) this.fontFamily = value.fontFamily;
        if (value.corners != null) this.corners = value.corners;
        if (value.selectedColorWeight != null) this.selectedColorWeight = value.selectedColorWeight;

        return value;
    }

    inline public function selectedBackgroundColor():CrappUIColor return new CrappUIColor(this.background.darken(this.selectedColorWeight));

    private function get_font():PriFontStyle {
        return new PriFontStyle(
            this.primary.color, 
            this.fontFamily
        );
    }

    public function clone():CrappUIStyle {
        var result:CrappUIStyle = new CrappUIStyle();
        result.data = this.data;
        return result;
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

    static public function fromData(data:CrappUIStyleData, ?base:CrappUIStyle):CrappUIStyle {
        var result:CrappUIStyle = base == null ? CrappUIStyle.bluePrint() : base.clone();
        result.data = data;
        return result;
    }

}