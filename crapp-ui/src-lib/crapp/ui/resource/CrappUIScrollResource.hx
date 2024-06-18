package crapp.ui.resource;

import priori.system.PriDeviceSystem;
import priori.system.PriDeviceBrowser;
import priori.system.PriDevice;
import js.html.TouchEvent;
import priori.event.PriEvent;
import priori.event.PriMouseEvent;
import priori.view.PriDisplay;

@:access(priori.view.PriDisplay)
class CrappUIScrollResource {
    
    @:isVar public var allow(default, set):Bool;
    @:isVar public var allowX(default, set):Bool;
    @:isVar public var allowY(default, set):Bool;

    public var y(get, set):Float;
    public var x(get, set):Float;

    public var maxY(get, null):Float;
    public var maxX(get, null):Float;

    private var __touched:Bool;
    private var __mouseIsOver:Bool;

    private var __lastXScroll:Int = 0;
    private var __lastYScroll:Int = 0;

    private var display:PriDisplay;

    public function new(display:PriDisplay) {
        this.display = display;
        
        this.__touched = false;
        this.__mouseIsOver = false;
        this.allowY = true;

        this.display.addEventListener(PriMouseEvent.MOUSE_OVER, onOver);
        this.display.addEventListener(PriMouseEvent.MOUSE_OUT, onOut);

        this.display.addEventListener(PriEvent.ADDED_TO_APP, this.__onAddedToApp);

        if (this.display.getJSElement().addEventListener != null) {

            this.display.getJSElement().addEventListener('touchstart', this.__onTouchStart, true);
            this.display.getJSElement().addEventListener('touchend', this.__onTouchEnd, true);
            this.display.getJSElement().addEventListener('scroll', this.__onScrollUpdater, true);


        } else this.display.getJSElement().onscroll = this.__onScrollUpdater;

    }


    private function __onScrollUpdater():Void {
        this.__lastXScroll = this.display.getJSElement().scrollLeft;
        this.__lastYScroll = this.display.getJSElement().scrollTop;
    }

    private function __onAddedToApp(e:PriEvent):Void {
        this.display.getJSElement().scrollLeft = this.__lastXScroll;
        this.display.getJSElement().scrollTop = this.__lastYScroll;
    }

    private function __onTouchStart(e:TouchEvent):Void this.onOver(null);
    private function __onTouchEnd(e:TouchEvent):Void this.onOut(null);

    private function onOver(e:PriMouseEvent):Void {
        this.__mouseIsOver = true;
        this.updateScrollerView();
    }

    private function onOut(e:PriMouseEvent):Void {
        this.__mouseIsOver = false;
        this.updateScrollerView();
    }

    private function updateScrollerView():Void {
        if (this.display.isKilled()) return;

        if (PriDevice.browser() == PriDeviceBrowser.MOZILLA) {
            /* TODO
            / esta é uma solucao temporaria para um problema que faz com que
            / a caixa de selecao de um Select seja fechada quando modificar o overflow
            / por que a lista de itens causa um mouseleave no objeto pai
            */
            if (this.display.getElement().find("select:focus").length > 0) return;
        }

        if (this.__mouseIsOver) {
            if (this.allowX) this.display.dh.styles.set("overflow-x", "auto");
            else this.display.dh.styles.remove("overflow-x");

            if (this.allowY) this.display.dh.styles.set("overflow-y", "auto");
            else this.display.dh.styles.remove("overflow-y");

            if (!this.allowX && !this.allowY) {
                this.display.dh.styles.set("overflow-x", "hidden");
                this.display.dh.styles.set("overflow-y", "hidden");
            }

            if (PriDevice.deviceSystem() == PriDeviceSystem.IOS) {
                if (this.allowX || this.allowY) this.display.dh.styles.set("-webkit-overflow-scrolling", "touch");
                else this.display.dh.styles.remove("-webkit-overflow-scrolling");
            }

        } else {
            this.display.dh.styles.set("overflow-x", "hidden");
            this.display.dh.styles.set("overflow-y", "hidden");
        }

        this.display.__updateStyle();
    }
    
    // override private function get_clipping():Bool return true;
    // override private function set_clipping(value:Bool) return value;

    private function set_allowX(value:Bool) {
        this.allowX = value;
        if (this.__mouseIsOver) this.updateScrollerView();
        return value;
    }

    private function set_allowY(value:Bool) {
        this.allowY = value;
        if (this.__mouseIsOver) this.updateScrollerView();
        return value;
    }

    private function set_allow(value:Bool) {
        this.allowX = value;
        this.allowY = value;
        return value;
    }


    private function get_y():Float return this.display.getJSElement().scrollTop;
    private function set_y(value:Float) {
        this.display.getJSElement().scrollTop = cast value;
        return value;
    }

    private function get_x():Float return this.display.getJSElement().scrollLeft;
    private function set_x(value:Float) {
        this.display.getJSElement().scrollLeft = cast value;
        return value;
    }

    private function get_maxY():Float {
        var result:Float = this.display.getJSElement().scrollHeight;
        if (result == null || Math.isNaN(result)) return 0;

        return Math.max(0, result - this.display.height);
    }

    private function get_maxX():Float {
        var result:Float = this.display.getJSElement().scrollWidth;
        if (result == null || Math.isNaN(result)) return 0;

        return Math.max(0, result - this.display.width);
    }

}