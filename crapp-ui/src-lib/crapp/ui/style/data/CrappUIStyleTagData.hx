package crapp.ui.style.data;

import crapp.ui.style.data.CrappUIStyleData;
import crapp.ui.style.data.CrappUIStyleVariantData;

typedef CrappUIStyleTagData = {
    > CrappUIStyleData,
    
    var tag:String;

    @:optional var variants:Array<CrappUIStyleVariantData>;

}