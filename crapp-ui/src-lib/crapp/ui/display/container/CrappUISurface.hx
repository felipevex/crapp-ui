package crapp.ui.display.container;

import crapp.ui.style.data.CrappUIStyleData;
import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import crapp.ui.display.layout.CrappUILayout;

class CrappUISurface extends CrappUILayout {
    
    public function new() {
        super();

        this.tag = CrappUIStyleDefaultTagType.SURFACE;
    }

    override public function paint():Void {
        super.paint();
        
        var style:CrappUIStyleData = this.style;
        this.bgColor = style.color;
    }
}