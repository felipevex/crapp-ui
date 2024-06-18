package crapp.ui.controller;

import priori.event.PriEvent;
import crapp.ui.style.CrappUIEvents;
import crapp.ui.interfaces.ICrappUIStyleObject;
import crapp.ui.style.CrappUIStyle;

@:access(crapp.ui.interfaces.ICrappUIStyleObject)
class CrappUIStyleController {

    private var display:ICrappUIStyleObject;
    private var style:CrappUIStyle;
    
    public function new() {
        
    }

    public function start(display:ICrappUIStyleObject):Void {
        this.display = display;
        this.display.addEventListener(CrappUIEvents.STYLE_CHANGE, this.onStyleChangeEvent);
    }

    private function onStyleChangeEvent(e:PriEvent):Void {
        this.display.updateDisplay();
    }

    public function getParentStyle():CrappUIStyle {
        if (this.display == null) return null;
        else if (this.display.parent == null) return null;

        if (Std.isOfType(this.display.parent, ICrappUIStyleObject)) {
            var parent:ICrappUIStyleObject = cast this.display.parent;
            return parent.style;
        }
        
        return null;
    }

    public function getStyle():CrappUIStyle {
        if (this.display == null) return CrappUIStyle.bluePrint();
        else if (this.style != null) return this.style;
        
        var parentStyle:CrappUIStyle = this.display.parentStyle;
        if (parentStyle == null) return CrappUIStyle.bluePrint();
        
        return parentStyle;
	}

    public function setStyle(value:CrappUIStyle):CrappUIStyle {
        this.style = value;

        if (this.display == null) return value;

        this.display.propagateCrappUIEvent(CrappUIEvents.STYLE_CHANGE);
        this.display.updateDisplay();

        return value;
    }

}