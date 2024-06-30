package crapp.ui.display.button;

import priori.system.PriKey;
import priori.event.PriKeyboardEvent;
import crapp.ui.controller.CrappUITapController;
import priori.event.PriTapEvent;
import priori.types.PriTransitionType;
import crapp.ui.style.CrappUISizeReference;
import priori.geom.PriColor;
import crapp.ui.style.CrappUIStyle;
import crapp.ui.display.CrappUIStylableDisplay;

class CrappUIButtonable extends CrappUIStylableDisplay {
    
    private var tapController:CrappUITapController;
    
    public function new() {
        super();

        this.allowTransition(PriTransitionType.BACKGROUND_COLOR, 0.2);
    }

    private function onTapEvent(e:PriTapEvent):Void {
        if (this.actions.onClick != null) this.actions.onClick();
    }
    
    override function setup() {
        this.tapController = new CrappUITapController(this, this.updateDisplay);
        this.addEventListener(PriTapEvent.TAP, this.onTapEvent);
        this.addEventListener(PriKeyboardEvent.KEY_DOWN, this.onKeyDown);
    }

    private function onKeyDown(e:PriKeyboardEvent):Void {
        if (e.keycode == PriKey.SPACE || e.keycode == PriKey.ENTER) this.onTapEvent(null);
    }

    override function paint() {
        var style:CrappUIStyle = this.style;

        this.startBatchUpdate();
        
        var overColor:PriColor = this.tapController.isDown
            ? style.selectedBackgroundColor().darker
            : style.selectedBackgroundColor();

        var bgColor:PriColor = (this.tapController.isOver || this.tapController.isFocused)
            ? overColor
            : style.background.color;
        
        this.bgColor = bgColor;

        this.endBatchUpdate();
    }

    override public function kill():Void {
        this.tapController.kill();
        super.kill();
    }
}