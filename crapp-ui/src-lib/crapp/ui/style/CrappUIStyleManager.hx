package crapp.ui.style;

import crapp.ui.style.theme.CrappUIThemeProvider;
import crapp.ui.style.data.CrappUIStyleData;
import helper.kits.StringKit;
import priori.event.PriEvent;
import crapp.ui.style.CrappUIEvents;
import crapp.ui.interfaces.ICrappUIStyleObject;

@:access(crapp.ui.interfaces.ICrappUIStyleObject)
class CrappUIStyleManager {

    private var display:ICrappUIStyleObject;
    private var style:CrappUIStyleData;

    private var tag:String;
    private var variant:String;
    private var theme:String;
    
    public function new() {
        
    }

    public function start(display:ICrappUIStyleObject):Void {
        this.display = display;
        this.display.addEventListener(CrappUIEvents.STYLE_CHANGE, this.onStyleChangeEvent);
    }

    private function onStyleChangeEvent(e:PriEvent):Void this.display.updateDisplay();

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

    private function createParentTreeFrom(display:ICrappUIStyleObject):Array<ICrappUIStyleObject> {
        var parent:ICrappUIStyleObject = display;
        var tree:Array<ICrappUIStyleObject> = [];

        while (parent != null) {
            tree.push(parent);
            parent = this.getParentFrom(parent);
        }

        return tree;
    }

    private function getParentThemeFromTree(tree:Array<ICrappUIStyleObject>):String {
        for (component in tree) {
            var theme:String = component.styleManager.theme;
            if (!StringKit.isEmpty(theme)) return theme;
        }

        return null;
    }

    public function getStyle():CrappUIStyleData {
        var styleSequence:Array<CrappUIStyleData> = [];
        var tree:Array<ICrappUIStyleObject> = this.createParentTreeFrom(this.display);

        while (tree.length > 0) {
            var theme:String = this.getParentThemeFromTree(tree);
            
            var component:ICrappUIStyleObject = tree.shift();

            var tag:String = component.styleManager.tag;
            var variant:String = component.styleManager.variant;

            if (!StringKit.isEmpty(theme) || !StringKit.isEmpty(tag) || !StringKit.isEmpty(variant)) {
                styleSequence.unshift(
                    CrappUIThemeProvider.get().getStyleData(theme, tag, variant, false)
                );
            }
            
            if (component.styleManager.style != null) styleSequence.unshift(component.styleManager.style);
        }

        return CrappUIThemeProvider.get().crush(styleSequence);
	}

    public function setStyle(value:CrappUIStyleData):CrappUIStyleData {
        this.style = value;
        this.doPropagateChanges();
        return value;
    }

    public function getTheme():String {
        var tree:Array<ICrappUIStyleObject> = this.createParentTreeFrom(this.display);
        return this.getParentThemeFromTree(tree);
    }

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

    private function doPropagateChanges():Void {
        if (this.display == null) return;
        this.display.propagateCrappUIEvent(CrappUIEvents.STYLE_CHANGE);
    }

}