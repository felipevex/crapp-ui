package crapp.ui.display.button;

import crapp.ui.display.icon.types.CrappUIIconType;
import crapp.ui.style.CrappUISizeReference;
import crapp.ui.display.icon.CrappUIIcon;

@priori('
<priori>
    <view />
</priori>
')
class CrappUIButtonIconText extends CrappUIButton {
    
    public var icon(get, set):CrappUIIconType;

    public var rotationSpeed:Float = 0.5;
    @:isVar public var rotateIcon(default, set):Bool = false;
    
    private var iconDisplay:CrappUIIcon;

    private function set_rotateIcon(value:Bool):Bool {
        if (value == null) return value;

        this.rotateIcon = value;

        if (value) this.doRotateIcon();
        else this.iconDisplay.rotation = 0;

        return value;
    }

    private function doRotateIcon():Void {
        if (this.isKilled()) return;
        else if (!this.rotateIcon) {
            this.iconDisplay.rotation = 0;
            return;
        }

        this.iconDisplay.rotation += this.rotationSpeed;
        haxe.Timer.delay(this.doRotateIcon, Math.round(40/1000));
    }

    override function setup() {
        super.setup();

        this.iconDisplay = new CrappUIIcon();
        this.iconDisplay.tag = null;
        this.iconDisplay.size = CrappUISizeReference.EXTRA;

        this.addChild(this.iconDisplay);
    }


    override private function paint_drawThisSize(autoSize:Bool, space:Float):Void {
        this.height = this.displayLabel.height + space * 2;

        if (autoSize) this.width = this.iconDisplay.width + this.displayLabel.width + space * 4.5;
    }

    override private function paint_drawLabelPosition(autoSize:Bool, space:Float):Void {
        this.iconDisplay.x = space * 1.25;
        this.iconDisplay.centerY = this.height / 2 + 1;

        this.displayLabel.centerY = this.height/2 + 1;
        this.displayLabel.x = this.iconDisplay.maxX + space * 1.5;
    }
    
    override private function set_autoSize(value:Bool):Bool {
        this.autoSize = value;
        this.updateDisplay();
        return value;
    }

    private function get_icon():CrappUIIconType return this.iconDisplay.icon;
    private function set_icon(value:CrappUIIconType):CrappUIIconType {
        this.iconDisplay.icon = value;
        this.updateDisplay();
        return value;
    }

}