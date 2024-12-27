package crapp.ui.composite.builtin;

class DisabledEffectComposite extends CrappUIComposite {
    
    public function updateDisplay():Void {
        this.display.alpha = this.display.disabled ? 0.5 : 1;
    }

}