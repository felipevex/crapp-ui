package crapp.ui.display;

import crapp.ui.style.CrappUIEvents;
import priori.event.PriEvent;
import priori.style.shadow.PriShadowStyle;
import priori.view.builder.PriBuilder;

class CrappUIDisplay extends PriBuilder {
    
    @:noCompletion private var _z:Float = 0;
    public var z(get, set):Float;

    private function get_z():Float return this._z;
    private function set_z(value:Float):Float {
        var val:Float = value;
        
        if (value == null || value < 0.1) val = 0;
        else val = value;

        if (val == this.z) return value;
        else this._z = val;

        this.dh.styles.set("z-index", Std.string(this.dh.depth + Math.floor(this._z)));
        if (this.dh.elementBorder != null) this.dh.elementBorder.style.zIndex = Std.string(this.dh.depth + Math.floor(this._z));
        
        if (val > 0) {
            // hard shadow
            var keyLight:PriShadowStyle = new PriShadowStyle()
                .setVerticalOffset(0.2 + val * 0.9)
                .setBlur(0.2 + val * 0.8 + (val*val) * 0.04)
                .setOpacity((val + 14 + val * 0.4 - (val*val*0.05)) / 100)
                .setSpread(0.3 - val * 0.1);

            // soft shadow
            var ambientLight:PriShadowStyle = new PriShadowStyle()
                .setVerticalOffset(0)
                .setBlur(val * 2)
                .setOpacity((val + 5 + val * 0.11 - (val*val*0.03)) / 100)
                .setSpread(0);

            this.shadow = [keyLight, ambientLight];
        } else {
            this.shadow = null;
        }

        return value;
    }

    private function propagateCrappUIEvent(event:CrappUIEvents):Void {
        var event:PriEvent = new PriEvent(event, true, false);
        this.dispatchEvent(event);
    }

    @:noCompletion
    override private function ___onResize(e:PriEvent):Void {
        super.___onResize(e);
        if (this.parent != null) this.parent.dispatchEvent(new CrappUIEvent(CrappUIEvent.UPDATE_DISPLAY));
    }
}