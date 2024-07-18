package crapp.ui.style;

import crapp.ui.event.CrappUIEventType;
import crapp.ui.style.theme.CrappUIThemeProvider;
import crapp.ui.style.data.CrappUIStyleData;
import helper.kits.StringKit;
import priori.event.PriEvent;
import crapp.ui.interfaces.ICrappUIStyleObject;

@:access(crapp.ui.interfaces.ICrappUIStyleObject)
class CrappUIStyleManager {

    private var display:ICrappUIStyleObject;
    private var style:CrappUIStyleData;
    private var styleCache:CrappUIStyleData;

    private var tag:String;
    private var variant:String;
    private var theme:String;
    
    public function new() {
        
    }
    
    public function start(display:ICrappUIStyleObject):Void {
        this.display = display;
        this.display.addEventListener(CrappUIEventType.STYLE_CHANGE, this.onStyleChangeEvent);
    }

    private function onStyleChangeEvent(e:PriEvent):Void {
        this.styleCache = null;
        this.display.updateDisplay();
    }

    private function getParentStyledDisplay():ICrappUIStyleObject {
        if (this.display == null) return null;
        else if (this.display.parent == null) return null;
        else if (Std.isOfType(this.display.parent, ICrappUIStyleObject)) return cast this.display.parent;

        return null;
    }

    private function getParentFrom(display:ICrappUIStyleObject):ICrappUIStyleObject {
        if (display == null || display.parent == null) return null;
        else if (Std.isOfType(display.parent, ICrappUIStyleObject)) return cast display.parent;
        else return null;
    }

    // PARENT --> ... --> CURRENT CHILD
    private function createTree(display:ICrappUIStyleObject):Array<ICrappUIStyleObject> {
        var parent:ICrappUIStyleObject = display;
        var tree:Array<ICrappUIStyleObject> = [];

        while (parent != null) {
            tree.unshift(parent);
            parent = this.getParentFrom(parent);
        }

        return tree;
    }

    public function getStyle():CrappUIStyleData {
        if (this.styleCache != null) return this.styleCache;

        var styleSequence:Array<CrappUIStyleData> = [];

        var tree:Array<ICrappUIStyleObject> = this.createTree(this.display);
        
        var theme:String = null;
        var tag:String = null;
        var variant:String = null;

        for (component in tree) {
            var themeChanged:Bool = false;
            var tagChanged:Bool = false;
            var variantChanged:Bool = false;

            var currTheme:String = component.styleManager.theme;
            var currTag:String = component.styleManager.tag;
            var currVariant:String = component.styleManager.variant;

            if (!StringKit.isEmpty(currTheme) && currTheme != theme) {
                theme = currTheme;
                themeChanged = true;
            }

            if (!StringKit.isEmpty(currTag) && currTag != tag) {
                tag = currTag;
                tagChanged = true;
            }

            if (!StringKit.isEmpty(currVariant) && currVariant != variant) {
                variant = currVariant;
                variantChanged = true;
            }

            if (themeChanged || tagChanged || variantChanged) {
                var breaks:Array<CrappUIStyleData> = CrappUIThemeProvider.get().getStyleBreaked(theme, tag, variant);
                if (themeChanged) styleSequence.push(breaks[0]);
                if (tagChanged) styleSequence.push(breaks[1]);
                if (variantChanged) styleSequence.push(breaks[2]);
            }

            if (component.styleManager.style != null) styleSequence.push(component.styleManager.style);
        }

        this.styleCache = CrappUIThemeProvider.get().crush(styleSequence);
        return this.styleCache;
	}

    public function setStyle(value:CrappUIStyleData):CrappUIStyleData {
        this.style = value;
        this.doPropagateChanges();
        return value;
    }

    public function getTheme():String return this.theme;
    public function setTheme(value:String):String {
        if (this.theme == value) return value;
        this.theme = value;
        this.doPropagateChanges();
        return value;
    }

    public function getTag():String return this.tag;
    public function setTag(value:String):String {
        if (this.tag == value) return value;
        this.tag = value;
        this.doPropagateChanges();
        return value;
    }

    public function getVariant():String return this.variant;
    public function setVariant(value:String):String {
        if (this.variant == value) return value;
        this.variant = value;
        this.doPropagateChanges();
        return value;
    }

    public function doPropagateChanges():Void {
        if (this.display == null) return;
        
        var event:PriEvent = new PriEvent(CrappUIEventType.STYLE_CHANGE, true, false);
        this.display.dispatchEvent(event);
    }

}