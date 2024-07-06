package crapp.ui.composite.builtin;

import crapp.ui.style.CrappUIStyle;
import priori.geom.PriColor;
import crapp.ui.controller.CrappUITapController;
import priori.types.PriTransitionType;

class OverEffectComposite extends CrappUIComposite {
    
    public var tapController:CrappUITapController;

    public function updateDisplay():Void {
        var style:CrappUIStyle = this.display.style;

        var overColor:PriColor = this.tapController.isDown
            ? style.selectedBackgroundColor().darker
            : style.selectedBackgroundColor();

        var bgColor:PriColor = (this.tapController.isOver || this.tapController.isFocused)
            ? overColor
            : style.background.color;
        
        this.display.bgColor = bgColor;
    }

    override function setup() {
        this.tapController = new CrappUITapController(this.display, this.updateDisplay);

        this.display.allowTransition(PriTransitionType.BACKGROUND_COLOR, 0.2);
    }

    override function kill() {
        if (this.tapController != null) this.tapController.kill();

        this.tapController = null;
    }

}