package crapp.ui.route;

import crapp.ui.route.browser.RouteBrowserHost;
import crapp.ui.display.app.CrappUIScene;
import priori.app.PriApp;
import util.kit.path.Path;

class CrappUIRouteManager {
    
    // SINGLETON
    private static var _singleton:CrappUIRouteManager;

    public static function use():CrappUIRouteManager {
        if (_singleton == null) _singleton = new CrappUIRouteManager();
        return _singleton;
    }

    // CLASS

    private var host:RouteBrowserHost;
    private var routes:Array<RouteItem>;
    private var scopes:Array<String>;

    private var scene:CrappUIScene<Dynamic>;

    private function new() {
        this.host = new RouteBrowserHost();
        this.host.onRouteChange = this.onRouteChange;

        this.reset();
    }

    public function reset():Void {
        this.routes = [];
        this.scopes = [];
        this.killScene();
    }

    inline private function killScene():Void {
        if (this.scene != null) {
            this.scene.removeFromParent();
            this.scene.kill();
            this.scene = null;
        }
    }

    public function register<T>(path:Path<T>, scene:Class<CrappUIScene<T>>, ?scope:String):Void {
        if (path == null || scene == null) return;

        this.routes.push({path: path, scene: scene, scope: scope});
    }

    private function findRouteByPath(path:String):RouteItem {
        var starRoute:RouteItem = null;

        for (route in this.routes) {
            if (route.path == '**') starRoute = route;
            if (!route.path.match(path).matched) continue;
            
            return route;
        }

        return starRoute;
    }

    private function onRouteChange():Void {
        if (this.routes.length == 0) return;

        var path:String = this.host.getPath();
        var route:RouteItem = this.findRouteByPath(path);

        if (route == null) return;

        this.instantiateScene(route);
    }

    public function hasScope(scope:String):Bool return this.scopes.indexOf(scope) >= 0;
    public function addScope(scope:String):Void {
        if (scope == null || this.scopes.indexOf(scope) >= 0) return;
        this.scopes.push(scope);
    }
    public function removeScope(scope:String):Void {
        if (scope == null) return;
        this.scopes.remove(scope);
    }

    private function instantiateScene(route:RouteItem):Void {
        this.killScene();

        this.scene = Type.createInstance(route.scene, []);
        this.scene.left = 0;
        this.scene.top = 0;
        this.scene.right = 0;
        this.scene.bottom = 0;

        PriApp.g().addChild(this.scene);

        if (route.path == '**') this.host.overwriteRoute('');
    }

    inline public function navigateBack():Void this.host.navigateBack();
    inline public function navigateForward():Void this.host.navigateForward();
    inline public function navigate(path:String):Void this.host.navigate(path);
    
    inline public function reload():Void this.onRouteChange();
    inline public function replace(path:String):Void this.host.replace(path);

    public function routeParam():Null<Dynamic> {
        if (this.routes.length == 0) return null;

        var path:String = this.host.getPath();
        var route:RouteItem = this.findRouteByPath(path);
        
        return route.path.extract(path);
    }
}

private typedef RouteItem = {
    var path:Path<Dynamic>;
    var scene:Class<CrappUIScene<Dynamic>>;
    var scope:String;
}