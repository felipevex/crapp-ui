package crapp.ui.display.button;

import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import crapp.ui.composite.builtin.ButtonableComposite;
import crapp.ui.composite.builtin.OverEffectComposite;

class CrappUIButtonSurface extends CrappUIDisplay {
    
    public function new() {
        super();
        
        this.tag = CrappUIStyleDefaultTagType.BUTTON_SURFACE;
    }

    override function setup() {
        this.composite.add(OverEffectComposite);
        this.composite.add(ButtonableComposite);
    }

    override private function paint():Void {
        this.composite.get(OverEffectComposite).updateDisplay();
    }

}