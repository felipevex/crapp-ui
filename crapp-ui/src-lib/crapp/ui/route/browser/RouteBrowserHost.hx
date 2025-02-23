package crapp.ui.route.browser;

class RouteBrowserHost {

    public var onRouteChange:()->Void;

    private var overCallTimer:haxe.Timer;

    public function new() {
        this.registerChangeHashEvent();
    }

    public function getPath():String {
        var hash:String = js.Browser.location.hash;

        if (StringTools.startsWith(hash, "/#")) hash = hash.substr(2);
        else if (StringTools.startsWith(hash, "#")) hash = hash.substr(1);

        return hash;
    }

    inline private function callChange():Void {
        if (this.overCallTimer != null) {
            this.overCallTimer.stop();
            this.overCallTimer.run = null;
            this.overCallTimer = null;
        }

        this.overCallTimer = haxe.Timer.delay(() -> {
            if (this.onRouteChange != null) this.onRouteChange();
        }, 10);
    }

    private function registerChangeHashEvent():Void {
        if (js.Browser.window.addEventListener == null) return;
        js.Browser.window.addEventListener("hashchange", this.callChange);
    }

    public function navigateBack():Void try {
        js.Browser.window.history.back();
    } catch(e:Dynamic) {}
    
    public function navigateForward():Void try {
        js.Browser.window.history.forward();
    } catch(e:Dynamic) {}
    
    public function navigate(path:String):Void {
        path = this.sanitizePath(path);

        if (js.Browser.location.hash == path) this.callChange();
        else js.Browser.location.hash = path;
    }

    inline public function overwriteRoute(path:String):Void {
        path = this.sanitizePath(path);
        js.Browser.window.history.replaceState({}, "", path);
    }

    public function replace(path:String):Void {
        this.overwriteRoute(path);
        this.callChange();
    }

    inline private function sanitizePath(path:String):String {
        if (StringTools.startsWith(path, "#")) path = path.substr(1);
        else if (StringTools.startsWith(path, "/#")) path = path.substr(2);
        
        if (StringTools.startsWith(path, "/")) path = path.substr(1);
        
        return "#/" + path;
    }

}