package crapp.ui.style;

import priori.geom.PriColor;
import crapp.ui.style.CrappUIColorSwatch;

abstract CrappUIColor(CrappUIColorSwatch) {

    public var color(get, never):PriColor;
    public var brighter(get, never):PriColor;
    public var darker(get, never):PriColor;
    public var isLight(get, never):Bool;
    public var isDark(get, never):Bool;
    public var brightness(get, never):Int;

    inline public function new(color:PriColor) {
        this = new CrappUIColorSwatch(color);
    }

    @:from
    inline static function fromPriColor(color:PriColor):CrappUIColor return new CrappUIColor(color);

    @:to
    inline function toPriColor():PriColor return this.color;

    @:from
    inline static function fromInt(color:Int):CrappUIColor return new CrappUIColor(color);

    @:to
    inline function toInt():Int return this.color;

    inline function get_color():PriColor return this.color;
    inline function get_brighter():PriColor return this.brighter;
    inline function get_darker():PriColor return this.darker;

    inline function get_isLight():Bool return this.isLight();
    inline function get_isDark():Bool return this.isDark();

    inline function get_brightness():Int return this.brightness;

    inline public function darken(amount:Float):PriColor return this.darken(amount);
    inline public function brighten(amount:Float):PriColor return this.brighten(amount);
    inline public function saturate(amount:Float):PriColor return this.saturate(amount);

}