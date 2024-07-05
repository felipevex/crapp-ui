package crapp.ui.style;

import priori.geom.PriColor;

typedef CrappUIStyleData = {
    @:optional var primary: PriColor;
    @:optional var background: PriColor;
    @:optional var size: Float;
    @:optional var space: Float;
    @:optional var fontFamily: String;
    @:optional var corners: Float;
    @:optional var selectedColorWeight: Float;
}