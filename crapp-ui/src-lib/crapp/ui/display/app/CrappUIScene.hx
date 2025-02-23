package crapp.ui.display.app;

import crapp.ui.route.CrappUIRouteManager;
import crapp.ui.display.layout.CrappUILayout;
import crapp.ui.interfaces.ICrappUIStyleObject;

class CrappUIScene<T> extends CrappUILayout implements ICrappUIStyleObject {
    
    @:isVar public var sceneParams(get, null):T;

    private function get_sceneParams():T {
        if (this.sceneParams == null) this.sceneParams = CrappUIRouteManager.use().routeParam();
        return this.sceneParams;
    }

}