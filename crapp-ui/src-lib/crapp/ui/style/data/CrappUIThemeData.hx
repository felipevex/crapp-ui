package crapp.ui.style.data;

import crapp.ui.style.data.CrappUIStyleData;
import crapp.ui.style.data.CrappUIStyleTagData;

typedef CrappUIThemeData = {
    > CrappUIStyleData,

    var theme:String;

    var tags:Array<CrappUIStyleTagData>;
}

