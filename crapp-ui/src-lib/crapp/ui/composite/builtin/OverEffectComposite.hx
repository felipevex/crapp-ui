package crapp.ui.composite.builtin;

import crapp.ui.display.CrappUIDisplay;
import crapp.ui.style.CrappUIColor;
import crapp.ui.style.CrappUIStyle;
import priori.geom.PriColor;
import crapp.ui.controller.CrappUITapController;
import priori.types.PriTransitionType;

class OverEffectComposite extends CrappUIComposite {

    public var tapController:CrappUITapController;
    public var style:CrappUIStyle;

    public var mixFocusColor(default, set):Bool = false;
    public var target(default, set):CrappUIDisplay;

    public var isAlphaEffect(default, set):Bool = false;

    public function updateDisplay():Void {
        this.style = CrappUIStyle.fromData(this.display.style);

        var target:CrappUIDisplay = this.target != null
            ? this.target
            : this.display;

        if (this.isAlphaEffect) {
            var alpha:Float = (this.tapController.isOver || this.tapController.isFocused)
                ? this.tapController.isDown
                    ? 0.6
                    : 0.2
                : 0.0;

            var bgColor:PriColor = this.mixFocusColor
                ? new CrappUIColor(this.style.color.color.mix(this.style.onColor.color, this.style.onFocusWeight)).darker
                : this.style.onFocusColor().darker;

            target.bgColor = bgColor;
            target.alpha = alpha;

            return;
        }

        var bgColor:PriColor = (this.tapController.isOver || this.tapController.isFocused)
            ? this.tapController.isDown
                ? this.mixFocusColor
                    ? new CrappUIColor(this.style.color.color.mix(this.style.onColor.color, this.style.onFocusWeight)).darker
                    : this.style.onFocusColor().darker
                : this.mixFocusColor
                    ? this.style.color.color.mix(this.style.onColor.color, this.style.onFocusWeight)
                    : this.style.onFocusColor()
            : this.style.color.color;

        target.bgColor = bgColor;
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

    private function set_target(target:CrappUIDisplay):CrappUIDisplay {
        this.target = target;

        if (target != null) {
            haxe.Timer.delay(this.target.allowTransition.bind(PriTransitionType.BACKGROUND_COLOR, 0.2), 1);
            if (this.isAlphaEffect) haxe.Timer.delay(this.target.allowTransition.bind(PriTransitionType.ALPHA, 0.2), 1);
        }

        this.updateDisplay();

        return target;
    }

    private function set_isAlphaEffect(value:Bool):Bool {
        if (value == null) return value;

        this.isAlphaEffect = value;

        if (this.isAlphaEffect) {
            if (this.target != null) haxe.Timer.delay(this.target.allowTransition.bind(PriTransitionType.ALPHA, 0.2), 1);
            else haxe.Timer.delay(this.display.allowTransition.bind(PriTransitionType.ALPHA, 0.2), 1);
        }

        this.updateDisplay();

        return value;
    }

    override function kill() {
        if (this.tapController != null) this.tapController.kill();

        this.tapController = null;
    }

}