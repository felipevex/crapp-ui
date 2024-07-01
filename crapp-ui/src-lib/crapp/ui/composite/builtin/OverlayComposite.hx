package crapp.ui.composite.builtin;

import priori.geom.PriGeomPoint;
import priori.view.PriDisplay;
import priori.app.PriApp;
import priori.event.PriTapEvent;
import priori.event.PriEvent;

class OverlayComposite extends CrappUIComposite {

    private var ref:PriDisplay;

    public var autoCloseOnAppClick:Bool = false;
    public var autoPositionOnReference:Bool = false;
    public var autoPositionBorderOffset:Int = 15;
    
    override function setup() {
        
    }

    override function kill() {
        PriApp.g().removeEventListener(PriTapEvent.TAP_UP, this.onAutoClose);
        PriApp.g().removeEventListener(PriEvent.RESIZE, this.onAppResize);
        if (this.ref != null) this.ref.removeEventListener(PriEvent.REMOVED_FROM_APP, this.onAutoClose);
        
        this.ref = null;
    }

    public function open(?reference:PriDisplay):Void {
        this.ref = reference;

        if (autoCloseOnAppClick) PriApp.g().addEventListener(PriTapEvent.TAP_UP, this.onAutoClose);
        
        if (this.ref != null) {
            this.ref.addEventListener(PriEvent.REMOVED_FROM_APP, this.onAutoClose);
            if (autoPositionOnReference) PriApp.g().addEventListener(PriEvent.RESIZE, this.onAppResize);
        }

        PriApp.g().addChild(this.display);
        
        if (autoPositionOnReference) this.updatePositionByReference();
    }

    public function close():Void {
        this.kill();
        
        this.display.removeFromParent();
        this.display.kill();
        this.ref = null;
    }

    private function onAppResize(e:PriEvent):Void {
        this.updatePositionByReference();
    }

    public function updatePositionByReference():Void {
        if (this.ref == null || !this.ref.hasApp()) return;

        var point:PriGeomPoint = this.ref.localToGlobal(new PriGeomPoint(this.ref.x, this.ref.y));
        this.display.x = point.x;
        this.display.y = point.y;

        if (this.display.maxX > (PriApp.g().width - this.autoPositionBorderOffset)) this.display.maxX = PriApp.g().width - this.autoPositionBorderOffset;
        if (this.display.maxY > (PriApp.g().height - this.autoPositionBorderOffset)) this.display.maxY = PriApp.g().height - this.autoPositionBorderOffset;
    }

    private function onAutoClose(e:PriEvent):Void haxe.Timer.delay(this.close, 0);

}