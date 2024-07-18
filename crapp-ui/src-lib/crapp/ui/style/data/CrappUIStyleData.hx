package crapp.ui.style.data;

import crapp.ui.style.data.CrappUIStyleColorData;

typedef CrappUIStyleData = {
    > CrappUIStyleColorData,
    > CrappUIStyleFontData,
    
    @:optional var size:Float;
    @:optional var space:Float;
    
    @:optional var corners:Float;
    @:optional var on_focus_weight:Float;
    
}