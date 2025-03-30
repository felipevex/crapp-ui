package crapp.ui.display.container;

import crapp.ui.style.data.CrappUIStyleData;
import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import crapp.ui.display.layout.CrappUILayout;

@priori('
<priori>
    <view tag:L="CrappUIStyleDefaultTagType.SURFACE" />
</priori>
')
class CrappUISurface extends CrappUILayout {
    
    override public function paint():Void {
        super.paint();
        
        var style:CrappUIStyleData = this.style;
        this.bgColor = style.color;
    }
}