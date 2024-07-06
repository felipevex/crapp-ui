package crapp.ui.composite.builtin;

import priori.system.PriKey;
import priori.event.PriTapEvent;
import priori.event.PriKeyboardEvent;

class ButtonableComposite extends CrappUIComposite {
    
    private function onTapEvent(e:PriTapEvent):Void {
        if (this.display.actions.onClick != null) this.display.actions.onClick();
    }

    private function onKeyDown(e:PriKeyboardEvent):Void {
        if (e.keycode == PriKey.SPACE || e.keycode == PriKey.ENTER) this.onTapEvent(null);
    }

    override function setup() {
        this.display.addEventListener(PriTapEvent.TAP, this.onTapEvent);
        this.display.addEventListener(PriKeyboardEvent.KEY_DOWN, this.onKeyDown);
    }

    override function kill() {
        this.display.removeEventListener(PriTapEvent.TAP, this.onTapEvent);
        this.display.removeEventListener(PriKeyboardEvent.KEY_DOWN, this.onKeyDown);
    }

}