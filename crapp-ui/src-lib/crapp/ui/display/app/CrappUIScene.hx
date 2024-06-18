package crapp.ui.display.app;

import priori.event.PriEvent;
import crapp.ui.style.CrappUIEvents;
import crapp.ui.style.CrappUIStyle;
import crapp.ui.controller.CrappUIStyleController;
import crapp.ui.interfaces.ICrappUIStyleObject;
import priori.scene.view.PriSceneView;

class CrappUIScene extends PriSceneView implements ICrappUIStyleObject {
    
    private var styleController:CrappUIStyleController;
    public var style(get, set):CrappUIStyle;
    public var parentStyle(get, null):CrappUIStyle;

    public function new(data:Dynamic) {
        this.styleController = new CrappUIStyleController();
        super(data);
        this.styleController.start(this);
    }

    function get_parentStyle():CrappUIStyle return this.styleController.getParentStyle();
    function get_style():CrappUIStyle return this.styleController.getStyle();
	function set_style(value:CrappUIStyle):CrappUIStyle return this.styleController.setStyle(value);

    private function propagateCrappUIEvent(event:CrappUIEvents):Void {
        var event:PriEvent = new PriEvent(event, true, false);
        this.dispatchEvent(event);
    }
}