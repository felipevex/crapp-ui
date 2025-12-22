package crapp.ui.display.badge;

import crapp.ui.display.button.CrappUIButtonIcon;
import priori.geom.PriColor;
import priori.style.border.PriBorderStyle;
import crapp.ui.style.CrappUIColor;
import crapp.ui.style.CrappUIStyle;
import crapp.ui.style.data.CrappUIStyleData;
import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import crapp.ui.display.text.CrappUIText;
import crapp.ui.display.CrappUIDisplay;

@priori('
<priori>
    <view tag:L="CrappUIStyleDefaultTagType.BADGE" >
        <private:CrappUIText id="displayLabel" text="BADGE" />
        <private:CrappUIButtonIcon id="buttonDisplay" icon="TIMES" size="BASE" visible=":false"/>
    </view>
</priori>
')
class CrappUIBadge extends CrappUIDisplay {

    public var label(default, set):String;
    public var color(default, set):PriColor;
    public var showCloseButton(get, set):Bool;

    override private function setup() {
        super.setup();

        this.displayLabel.tag = null;
        this.buttonDisplay.actions.onClick = this.onCloseClick;
    }

    private function onCloseClick():Void {
        if (this.actions.onClick != null) this.actions.onClick();
        if (this.actions.onClose != null) this.actions.onClose();
    }

    private function set_label(value:String):String {
        if (this.label == value) return value;
        this.label = value;
        this.displayLabel.text = value;
        this.updateDisplay();
        return value;
    }

    private function set_color(value:PriColor):PriColor {
        if (this.color == value) return value;
        this.color = value;

        if (value == null) this.displayLabel.style = null;
        else this.displayLabel.style = {
            on_color: value
        }

        this.updateDisplay();
        return value;
    }

    private function get_showCloseButton():Bool return this.buttonDisplay.visible;
    private function set_showCloseButton(value:Bool):Bool {
        this.buttonDisplay.visible = value;
        this.updateDisplay();
        return value;
    }

    override function paint() {
        var styleData:CrappUIStyleData = this.style;
        var style:CrappUIStyle = CrappUIStyle.fromData(styleData);

        this.paintColors(style);
        this.paintBorders(style);

        var space:Float = style.space;
        this.displayLabel.x = space;
        this.displayLabel.y = space/2;

        this.buttonDisplay.x = this.displayLabel.maxX + space / 2;
        this.buttonDisplay.centerY = this.displayLabel.centerY;

        this.width = this.displayLabel.width + space * 2 + (
            this.showCloseButton
            ? this.buttonDisplay.height + space / 2
            : 0
        );

        this.height = this.displayLabel.height + space;

        this.corners = [Math.round(style.corners)];
    }

    private function paintColors(style:CrappUIStyle):Void {
        var onColor:CrappUIColor = new CrappUIColor(this.getPredominantColor());

        var whiteMix:Float = style.preventBorder
            ? 0.88
            : 0.95;

        var cColor:CrappUIColor = new CrappUIColor(this.getPredominantColor().mix(0xFFFFFF, whiteMix));
        if (!cColor.isGrayScaled) cColor = cColor.saturate(0.4);

        this.bgColor = cColor.color;

        this.buttonDisplay.style = {
            on_color: onColor,
            color : this.bgColor,
            space: 5
        }
    }

    private function paintBorders(style:CrappUIStyle):Void {
        if (style.preventBorder) {
            this.border = null;
            return;
        }

        var cColor:CrappUIColor = new CrappUIColor(this.getPredominantColor().mix(0xFFFFFF, 0.7));
        if (!cColor.isGrayScaled) cColor = cColor.saturate(0.2);

        var borderColor:PriColor = cColor.color;
        this.border = new PriBorderStyle(1, borderColor);
    }

    private function getPredominantColor():PriColor {
        if (this.color != null) return this.color;
        return this.style.on_color;
    }
}