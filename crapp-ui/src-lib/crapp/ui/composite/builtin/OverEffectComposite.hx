package crapp.ui.composite.builtin;

import crapp.ui.style.CrappUIStyle;
import priori.geom.PriColor;
import crapp.ui.controller.CrappUITapController;
import priori.types.PriTransitionType;

class OverEffectComposite extends CrappUIComposite {
    
    public var tapController:CrappUITapController;
    public var style:CrappUIStyle;

    public function updateDisplay():Void {
        this.style = CrappUIStyle.fromData(this.display.style);

        var overColor:PriColor = this.tapController.isDown
            ? this.style.onFocusColor().darker
            : this.style.onFocusColor();

        var bgColor:PriColor = (this.tapController.isOver || this.tapController.isFocused)
            ? overColor
            : this.style.color.color;
        
        this.display.bgColor = bgColor;
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