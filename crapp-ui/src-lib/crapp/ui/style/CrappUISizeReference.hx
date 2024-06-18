package crapp.ui.style;

enum abstract CrappUISizeReference(Float) from Float to Float {
    var TINY:Float = 0.25;
    var SMALL:Float = 0.66;
    var UNDER:Float = 0.72;
    var BASE:Float = 1.00;
    var LARGE:Float = 2.00;
    var XLARGE:Float = 2.66;

    public function toFloat():Float return this;
}