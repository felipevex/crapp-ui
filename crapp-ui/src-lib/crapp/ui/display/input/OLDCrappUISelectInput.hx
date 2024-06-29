package priori.ui.input;

import priori.view.PriDisplay;
import priori.fontawesome.FontAwesomeIcon;
import priori.fontawesome.FontAwesomeIconType;
import priori.view.form.PriFormSelect;
import priori.event.PriEvent;
import priori.event.PriFocusEvent;
import priori.style.font.PriFontStyle;
import priori.style.font.PriFontStyleItalic;
import priori.style.font.PriFontStyleWeight;
import priori.view.PriLineHorizontal;
import priori.view.text.PriText;

class OLDCrappUISelectInput<T> extends CrappUIInput<T> {

    public var labelField(get, set):String;

    @:isVar public var data(default, set):Array<T>;
    @:isVar public var placeholder(default, set):String;

    @:isVar public var label(default, set):String = "LABEL";
    
    private var labelDisplay:PriText;
    private var input:PriFormSelect;
    private var line:PriLineHorizontal;

    private var icon:FontAwesomeIcon;
    private var box:PriDisplay;

    public function new() {
        super();

        this.width = 300;

        this.styleDisplayType = PriUIDisplayType.PRIMARY;
        this.clipping = false;
        this.height = 50;
        this.data = [];
    }

    override private function updateStyle():Void {

        var type = this.styleDisplayType;

        if (type != PriUIDisplayType.NONE) {

            var style = this.style;
            var shade = this.styleShade;

            this.bgColor = PriUIDisplayType.SUBTLE.getBackgroundSwatch(style).getColor(shade);
            this.box.bgColor = this.bgColor;

            var colorBasic = type.getColorKit(style).getColor(shade);
            var colorClear = type.getColorKit(style).getColor(PriUIShade.BRIGHTER);

            this.labelPlaceholder.textColor = colorClear;

            this.icon.color = colorBasic;

            var hasFocus:Bool = this.hasFocus();
            var hasValue:Bool = (this.value != null);

            if (hasValue) {
                this.labelPlaceholder.fontSize = 11;
            } else {
                this.labelPlaceholder.fontSize = 18;
            }

            if (hasFocus) {
                this.line.lineColor = colorBasic;
            } else {
                this.line.lineColor = PriUIDisplayType.SUBTLE.getBackgroundSwatch(style).getColor(PriUIShade.DARKER);
            }

            this.input.fontStyle = this.input.fontStyle.setColor(colorBasic);

        }

    }

    private function get_labelField():String return this.input.labelField;
    private function set_labelField(value:String):String return this.input.labelField = value;

    override private function set_disabled(value:Bool) {
        if (value) this.alpha = 0.5;
        else this.alpha = 1;

        return super.set_disabled(value);
    }

    private function set_data(value:Array<T>):Array<T> {
        this.data = value;
        this.updateSelectorData();
        return value;
    }

    private function updateSelectorData():Void {
        var content:Array<Dynamic> = [];

        content.push("");
        if (this.data != null) for (item in this.data) content.push(item);

        this.input.data = content;
        this.updatePlaceholder();
    }

    private function set_placeholder(value:String):String {
        this.labelPlaceholder.text = value.toLowerCase();
        this.updateStyle();
        this.updateDisplay();
        return value;
    }

    private function get_value():T {
        var value = this.input.selected;

        if (Std.is(value, String) && Std.string(value).length == 0) {
            return null;
        } else {
            return cast value;
        }
    }

    private function set_value(value:T):T {
        this.input.selected = value;
        this.updatePlaceholder();

        return value;
    }

    private function updatePlaceholder():Void {
        this.updateStyle();
        this.updateDisplay();
    }

    private function onFocus(e:PriFocusEvent):Void this.updatePlaceholder();

    private function onFieldChange(e:PriEvent):Void {
        this.updatePlaceholder();
        this.dispatchEvent(new PriEvent(PriEvent.CHANGE));
        if (this.onChange != null) this.onChange();
    }

    override private function setup():Void {

        this.corners = [4, 4, 0, 0];

        this.input = new PriFormSelect();
        this.input.addEventListener(PriEvent.CHANGE, this.onFieldChange);
        this.input.addEventListener(PriFocusEvent.FOCUS_IN, this.onFocus);
        this.input.addEventListener(PriFocusEvent.FOCUS_OUT, this.onFocus);
        this.input.height = 40;
        this.input.fontSize = 14;
        this.input.fontStyle = new PriFontStyle().setWeight(PriFontStyleWeight.THICK300);

        this.labelPlaceholder = new PriText();
        this.labelPlaceholder.fontSize = 18;
        this.labelPlaceholder.fontStyle = new PriFontStyle().setItalic(PriFontStyleItalic.ITALIC).setWeight(PriFontStyleWeight.LIGHTER);
        this.labelPlaceholder.autoSize = false;
        this.labelPlaceholder.mouseEnabled = false;

        this.icon = new FontAwesomeIcon();
        this.icon.icon = FontAwesomeIconType.ANGLE_DOUBLE_DOWN;
        this.icon.mouseEnabled = false;

        this.line = new PriLineHorizontal();
        this.line.lineWidth = 2;

        this.box = new PriDisplay();
        this.box.corners = [100];
        this.box.mouseEnabled = false;

        this.addChildList(
            [
                this.input,
                this.box,
                this.icon,
                this.labelPlaceholder,
                this.line
            ]
        );
    }

    override private function paint():Void {

        if (this.labelPlaceholder.fontSize < 14) {
            this.labelPlaceholder.y = 7;
        } else {
            this.labelPlaceholder.y = 17;
        }

        this.labelPlaceholder.x = 13;
        this.labelPlaceholder.width = this.width - 30;

        this.input.x = 13;
        this.input.width = this.width - 13*2;
        this.input.y = 20;
        this.input.height = this.height - this.input.y;

        this.icon.size = this.height * 0.4;
        this.icon.centerY = this.height/2;
        this.icon.maxX = this.width - this.icon.y;

        this.box.x = this.icon.x - 10;
        this.box.width = this.width - this.box.x;
        this.box.height = this.height;

        this.line.width = this.width;
        this.line.y = this.height - 1;

    }

}
