package crapp.ui.composite.builtin;

class DisabledEffectComposite extends CrappUIComposite {
    
    @:isVar public var lowAlpha(default, set):Float = 0.5;

    public function updateDisplay():Void {
        this.display.alpha = this.display.disabled ? this.lowAlpha : 1;
    }

    private function set_lowAlpha(value:Float):Float {
        if (value == null) return value;
        
        this.lowAlpha = value;
        this.updateDisplay();
        return value;
    }

}