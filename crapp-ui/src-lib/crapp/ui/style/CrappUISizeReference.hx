package crapp.ui.style;

enum abstract CrappUISizeReference(Float) {
    
    var TINY = 0.25;
    var SMALL = 0.66;
    var UNDER = 0.72;
    var BASE = 1.00;
    var EXTRA = 1.33;
    var LARGE = 2.00;
    var XLARGE = 2.66;

    @:op(A * B)
    inline private static function multiply_float_r(lhs:Float, rhs:CrappUISizeReference):Float return rhs.toFloat() * lhs;

    @:op(A * B)
    inline private static function multiply_float_l(lhs:CrappUISizeReference, rhs:Float):Float return rhs * lhs.toFloat();

    @:to
    inline public function toFloat():Float return this;

    @:from
    static public function fromFloat(value:Float):CrappUISizeReference {
        return switch (value) {
            case 0.25: TINY;
            case 0.66: SMALL;
            case 0.72: UNDER;
            case 1.00: BASE;
            case 1.33: EXTRA;
            case 2.00: LARGE;
            case 2.66: XLARGE;
            default: BASE;
        }
    }

    @:from
    static public function fromString(value:String):CrappUISizeReference {
        if (value == null) return BASE;

        return switch (value.toLowerCase()) {
            case "tiny": TINY;
            case "small": SMALL;
            case "under": UNDER;
            case "base" | "normal" : BASE;
            case "extra": EXTRA;
            case "large": LARGE;
            case "xlarge": XLARGE;
            default: BASE;
        }
    }
}