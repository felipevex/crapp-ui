package crapp.ui.controller;

import priori.app.PriApp;
import priori.event.PriEvent;
import priori.event.PriFocusEvent;
import priori.event.PriTapEvent;
import priori.event.PriMouseEvent;
import priori.view.PriDisplay;

class CrappUITapController {

    public var isDown:Bool = false;
    public var isOver:Bool = false;
    public var isFocused:Bool = false;

    private var o:PriDisplay;
    private var doUpdate:Void->Void;

    public function new(display:PriDisplay, doUpdate:Void->Void) {
        this.o = display;
        this.doUpdate = doUpdate;

        this.o.focusable = true;

        this.initializeEvents();
    }

    public function reset():Void {
        if (this.o == null) return;

        this.isDown = false;
        this.isOver = false;
        this.isFocused = false;

        PriApp.g().removeEventListener(PriTapEvent.TAP_UP, this.onUp);
        PriApp.g().removeEventListener(PriTapEvent.TOUCH_UP, this.onUp);
    }

    private function initializeEvents():Void {
        this.o.addEventListener(PriMouseEvent.MOUSE_OVER, this.onOverIn);
        this.o.addEventListener(PriMouseEvent.MOUSE_OUT, this.onOverOut);

        this.o.addEventListener(PriTapEvent.TAP_DOWN, this.onDown);
        this.o.addEventListener(PriTapEvent.TOUCH_DOWN, this.onDown);

        this.o.addEventListener(PriFocusEvent.FOCUS_IN, this.onFocusIn);
        this.o.addEventListener(PriFocusEvent.FOCUS_OUT, this.onFocusOut);
        this.o.addEventListener(PriTapEvent.TOUCH_MOVE, this.onFocusOut);
    }

    private function onOverIn(e:PriEvent):Void {
        if (this.isOver) return;

        this.isOver = true;
        this.doUpdate();
    }

    private function onOverOut(e:PriEvent):Void {
        if (!this.isOver) return;

        this.isOver = false;
        this.doUpdate();
    }

    private function onFocusIn(e:PriEvent):Void {
        if (this.isFocused) return;

        this.isFocused = true;
        this.isOver = true;
        this.doUpdate();
    }

    private function onFocusOut(e:PriEvent):Void {
        this.o.removeFocus();

        if (!this.isFocused) return;

        this.isOver = false;
        this.isFocused = false;
        this.doUpdate();
    }

    private function onDown(e:PriEvent):Void {
        if (this.isDown) return;

        PriApp.g().removeEventListener(PriTapEvent.TAP_UP, this.onUp);
        PriApp.g().removeEventListener(PriTapEvent.TOUCH_UP, this.onUp);
        PriApp.g().addEventListener(PriTapEvent.TOUCH_UP, this.onUp);
        PriApp.g().addEventListener(PriTapEvent.TAP_UP, this.onUp);

        this.isDown = true;
        this.isFocused = true;


        this.doUpdate();
    }

    private function onUp(e:PriEvent):Void {
        if (!this.isDown) return;

        this.isDown = false;

        PriApp.g().setFocus();

        this.isFocused = false;

        haxe.Timer.delay(() -> {
            if (this.o == null) return;
            if (this.o.disabled || !this.o.hasApp()) {
                this.isOver = false;
                this.isFocused = false;
            }

            if (this.doUpdate != null) this.doUpdate();

        }, 10);

        PriApp.g().removeEventListener(PriTapEvent.TAP_UP, this.onUp);
        PriApp.g().removeEventListener(PriTapEvent.TOUCH_UP, this.onUp);
    }

    public function kill():Void {
        this.o.removeEventListener(PriMouseEvent.MOUSE_OVER, this.onOverIn);
        this.o.removeEventListener(PriMouseEvent.MOUSE_OUT, this.onOverOut);

        this.o.removeEventListener(PriTapEvent.TAP_DOWN, this.onDown);
        this.o.removeEventListener(PriTapEvent.TOUCH_DOWN, this.onDown);

        this.o.removeEventListener(PriFocusEvent.FOCUS_IN, this.onFocusIn);
        this.o.removeEventListener(PriFocusEvent.FOCUS_OUT, this.onFocusOut);

        PriApp.g().removeEventListener(PriTapEvent.TAP_UP, this.onUp);
        PriApp.g().removeEventListener(PriTapEvent.TOUCH_UP, this.onUp);

        this.o = null;
        this.doUpdate = null;
    }
}