package crapp.ui.composite.builtin;

import crapp.ui.style.CrappUIColor;
import crapp.ui.style.CrappUIStyle;
import priori.geom.PriColor;
import crapp.ui.controller.CrappUITapController;
import priori.types.PriTransitionType;

class OverEffectComposite extends CrappUIComposite {
    
    public var tapController:CrappUITapController;
    public var style:CrappUIStyle;

    public var mixFocusColor(default, set):Bool = false;

    public function updateDisplay():Void {
        this.style = CrappUIStyle.fromData(this.display.style);

        var bgColor:PriColor = (this.tapController.isOver || this.tapController.isFocused)
            ? this.tapController.isDown
                ? this.mixFocusColor
                    ? new CrappUIColor(this.style.color.color.mix(this.style.onColor.color, this.style.onFocusWeight)).darker
                    : this.style.onFocusColor().darker
                : this.mixFocusColor
                    ? this.style.color.color.mix(this.style.onColor.color, this.style.onFocusWeight)
                    : this.style.onFocusColor()
            : this.style.color.color;
        
        this.display.bgColor = bgColor;
    }

    private function set_mixFocusColor(value:Bool):Bool {
        if (value == null) return value;
        
        this.mixFocusColor = value;
        this.updateDisplay();
        
        return value;
    }

    public function reset():Void {
        if (this.tapController != null) this.tapController.reset();
    }

    override function setup() {
        this.tapController = new CrappUITapController(this.display, this.updateDisplay);
        
        haxe.Timer.delay(this.display.allowTransition.bind(PriTransitionType.BACKGROUND_COLOR, 0.2), 1);
    }

    override function kill() {
        if (this.tapController != null) this.tapController.kill();

        this.tapController = null;
    }

}