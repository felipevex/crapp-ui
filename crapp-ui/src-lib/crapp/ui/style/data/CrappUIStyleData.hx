package crapp.ui.style.data;

import crapp.ui.style.data.CrappUIStyleColorData;

typedef CrappUIStyleData = {
    > CrappUIStyleColorData,
    
    @:optional var size:Float;
    @:optional var space:Float;
    @:optional var font_family:String;
    @:optional var corners:Float;
    @:optional var on_focus_weight:Float;
    
}