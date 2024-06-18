package crapp.ui.display.button;

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
        this.addEventListener(PriTapEvent.TAP, this.onTapEvent);
    }

    private function onTapEvent(e:PriTapEvent):Void {
        if (this.actions.onClick != null) this.actions.onClick();
    }
    
    override function setup() {
        this.tapController = new CrappUITapController(this, this.updateDisplay);
    }

    override function paint() {
        var style:CrappUIStyle = this.style;

        this.startBatchUpdate();
        
        var overColor:PriColor = this.tapController.isFocused
            ? style.background.isLight
                ? style.background.darken(0.2)
                : style.background.brighten(0.2)
            : style.background.isLight
                ? style.background.darker 
                : style.background.brighter
            ;

        var bgColor:PriColor = (this.tapController.isOver || this.tapController.isFocused)
            ? overColor
            : style.background.color;
        
        this.bgColor = bgColor;
        // this.border = style.primary.brightness >= style.background.brightness
        //     ? null
        //     : new PriBorderStyle(2, style.primary.color);

        this.endBatchUpdate();

        this.corners = [Math.round(CrappUISizeReference.TINY * style.corners)];        
    }
}