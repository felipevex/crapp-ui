package crapp.ui.display.app;

import crapp.ui.style.data.CrappUIStyleData;
import priori.event.PriEvent;
import crapp.ui.style.CrappUIEvents;
import crapp.ui.style.CrappUIStyleManager;
import crapp.ui.interfaces.ICrappUIStyleObject;
import priori.scene.view.PriSceneView;

class CrappUIScene extends PriSceneView implements ICrappUIStyleObject {
    
    private var styleManager:CrappUIStyleManager;

    public var theme(get, set):String;
    public var tag(get, set):String;
    public var variant(get, set):String;
    public var style(get, set):CrappUIStyleData;
    // public var parentStyle(get, null):CrappUIStyle;

    public function new(data:Dynamic) {
        this.styleManager = new CrappUIStyleManager();
        super(data);
        this.styleManager.start(this);
    }

    // function get_parentStyle():CrappUIStyle return this.styleManager.getParentStyle();
    function get_style():CrappUIStyleData return this.styleManager.getStyle();
	function set_style(value:CrappUIStyleData):CrappUIStyleData return this.styleManager.setStyle(value);
    function get_theme():String return this.styleManager.getTheme();
    function set_theme(value:String):String return this.styleManager.setTheme(value);
    function get_tag():String return this.styleManager.getTag();
    function set_tag(value:String):String return this.styleManager.setTag(value);
    function get_variant():String return this.styleManager.getVariant();
    function set_variant(value:String):String return this.styleManager.setVariant(value);

    private function propagateCrappUIEvent(event:CrappUIEvents):Void {
        var event:PriEvent = new PriEvent(event, true, false);
        this.dispatchEvent(event);
    }
}