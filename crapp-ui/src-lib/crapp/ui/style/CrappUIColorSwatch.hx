package crapp.ui.style;

import priori.geom.PriColor;

class CrappUIColorSwatch {
    
    @:isVar public var color(default, null):PriColor;
    @:isVar public var brighter(default, null):PriColor;
    @:isVar public var darker(default, null):PriColor;

    public var brightness(get, null):Int;
    public var gray(get, null):PriColor;

    public function new(baseColor:PriColor) {
        this.color = baseColor;
        this.createShades();
    }

    public function clone():CrappUIColorSwatch return new CrappUIColorSwatch(this.color);

    public function darken(amount:Float):PriColor return new TinyColor(this.color.toString()).darken(amount*100).toHexString();
    public function brighten(amount:Float):PriColor return new TinyColor(this.color.toString()).brighten(amount*100).toHexString();

    private function createShades():Void {
        this.darker = this.createDarkerShade();
        this.brighter = this.createBrighterShade();
    }

    private function createDarkerShade():PriColor {
        var color:TinyColor = new TinyColor(this.color.toString());
        
        color.darken(10);
        if (color.toHsl().s > 0.1) color.saturate(7);
        
        return PriColor.fromString(color.toHexString());
    }

    private function createBrighterShade():PriColor {
        var color:TinyColor = new TinyColor(this.color.toString());
        
        color.lighten(color.isLight() ? 18 : 10);
        if (color.toHsl().s > 0.1) color.saturate(7);
        
        return PriColor.fromString(color.toHexString());
    }

    private function get_gray():PriColor {
        return PriColor.fromString(new TinyColor(this.color.toString()).greyscale().toHexString());
    }

    private function get_brightness():Int return new TinyColor(this.color.toString()).getBrightness();

    public function isLight():Bool return new TinyColor(this.color.toString()).isLight();
    public function isDark():Bool return new TinyColor(this.color.toString()).isDark();
}


@:native("tinycolor")
private extern class TinyColor {

    public function new(?color:Dynamic, ?opts:Dynamic);
    
    public function isValid():Bool;

    //String Representations
    public function toHsv():HSV;
    public function toHsvString():String;
    public function toHsl():HSL;
    public function toHslString():String;
    public function toHex(?allow3Char:Bool):String;         // ffffff
    public function toHexString(?allow3Char:Bool):String;   // #ffffff
    public function toHex8():String;
    public function toHex8String():String;
    public function toRgb():RGB;
    public function toRgbString():String;
    public function toPercentageRgb():RGB;
    public function toPercentageRgbString():String;
    public function toName():Dynamic;
    public function toFilter(?secondColor:Bool):String;
    public function toString(format:String):String;

    public function clone():TinyColor;

    public function getAlpha():Float;
    public function setAlpha(value:Float):Void;
    public function getBrightness():Int;
    public function isLight():Bool;
    public function isDark():Bool;
    public function getLuminance():Float;

    public function lighten(?amount:Float):TinyColor;   // 0 to 100
    public function brighten(?amount:Float):TinyColor;    // 0 to 100
    public function darken(?amount:Float):TinyColor;      // 0 to 100
    public function desaturate(?amount:Int):TinyColor;  // 0 to 100
    public function saturate(?amount:Int):TinyColor;    // 0 to 100
    public function greyscale():TinyColor;

    public static function fromRatio(?color:Dynamic, ?opts:Dynamic):TinyColor;
    public static function equals(?color1:Dynamic, ?color2:Dynamic):Bool;
    public static function random():TinyColor;

    public static function complement():TinyColor;

    public function spin(amount:Float):TinyColor;
    
    public static function triad():Array<TinyColor>;
    public static function tetrad():Array<TinyColor>;
    public static function splitcomplement():Array<TinyColor>;
    public static function analogous():Array<TinyColor>;
    public function monochromatic():Array<TinyColor>;
    
    public static function readability(color1:TinyColor, color2:TinyColor):Float; // contrast ratio
    public static function readable(color1:TinyColor, color2:TinyColor):Bool;
    public static function mostReadable(baseColor:Dynamic, colorList:Array<Dynamic>):TinyColor;

    public static function isReadable(color1:Dynamic, color2:Dynamic, object:ReadableObject = null):Bool;

}

private enum abstract ReadableLevel(String) {
    var AA = "AA";
    var AAA = "AAA";
}

private typedef ReadableObject = {
    @:optional var level:ReadableLevel;
    @:optional var size:ReadableSize;
}

private enum abstract ReadableSize(String) {
    var SMALL = "small";
    var LARGE = "large";
}

private typedef RGB = {
    r:Float,
    g:Float,
    b:Float,
    a:Float
}

// hue, saturation, value
private typedef HSV = {
    h:Float,
    s:Float,
    v:Float,
    a:Float
}

// hue, saturation, lightness
private typedef HSL = {
    h:Float,
    s:Float,
    l:Float,
    a:Float
}
