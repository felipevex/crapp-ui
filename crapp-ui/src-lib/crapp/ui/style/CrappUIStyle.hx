package crapp.ui.style;

import crapp.ui.style.data.CrappUIStyleData;
import priori.style.font.PriFontStyle;
import priori.geom.PriColor;

class CrappUIStyle {

    public var data(get, set):CrappUIStyleData;
    
    public var onColor:CrappUIColor;
    public var color:CrappUIColor;
    public var size:Float;
    public var space:Float;
    public var fontFamily:String;
    public var corners:Float;

    public var font(get, null):PriFontStyle;

    public var onFocusWeight:Float = 0.06;

    public function new(
        on_color:PriColor = 0x4A6DE5,
        color:PriColor = 0xFFFFFF, 
        size:Float = 13.0,
        space:Float = 10.0,
        fontFamily:String = 'Saira, Open Sans',
        corners:Float = 6
    ) {
        this.onColor = on_color;
        this.color = color;
        this.size = size;
        this.space = space;
        this.fontFamily = fontFamily;
        this.corners = corners;
    }

    private function get_data():CrappUIStyleData {
        return {
            on_color : this.onColor,
            color : this.color,
            size : this.size,
            space : this.space,
            font_family : this.fontFamily,
            corners : this.corners,
            on_focus_weight : this.onFocusWeight
        };
    }

    private function set_data(value:CrappUIStyleData):CrappUIStyleData {
        if (value == null) return value;

        if (value.on_color != null) this.onColor = value.on_color;
        if (value.color != null) this.color = value.color;
        if (value.size != null) this.size = value.size;
        if (value.space != null) this.space = value.space;
        if (value.font_family != null) this.fontFamily = value.font_family;
        if (value.corners != null) this.corners = value.corners;
        if (value.on_focus_weight != null) this.onFocusWeight = value.on_focus_weight;

        return value;
    }

    inline public function onFocusColor():CrappUIColor {
        return new CrappUIColor(this.color.darken(this.onFocusWeight));
    }

    private function get_font():PriFontStyle {
        return new PriFontStyle(
            this.onColor.color, 
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