package crapp.ui.display.input;

import crapp.ui.display.icon.types.CrappUIIconType;
import priori.fontawesome.FixedIcon;
import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import priori.types.PriTransitionType;
import js.Browser;
import priori.view.form.PriFormSelect;
import haxe.Timer;
import priori.event.PriKeyboardEvent;
import priori.system.PriKey;
import priori.style.font.PriFontStyle;
import priori.event.PriFocusEvent;
import priori.event.PriEvent;
import priori.view.text.PriText;
import priori.event.PriTapEvent;
import crapp.ui.style.CrappUISizeReference;
import crapp.ui.style.CrappUIStyle;

@:access(crapp.ui.display.icon)
class CrappUISelectInput<T> extends CrappUIInput<T> {
    
    private var labelDisplay:PriText;
    private var input:PriFormSelect;
    private var delayedChangeTimer:Timer;
    private var arrow:FixedIcon;

    @:isVar public var allowNoSelection(default, set):Bool = true;

    @:isVar public var label(default, set):String = "LABEL";
    @:isVar public var data(default, set):Array<T>;

    public var labelField(get, set):String;
    public var labelFieldFunction(get, set):(value:T)->String;

    public function new() {
        super();

        this.tag = CrappUIStyleDefaultTagType.SELECT_INPUT;

        this.data = [];
        this.width = 300;

        haxe.Timer.delay(this.allowTransition.bind(PriTransitionType.BACKGROUND_COLOR, 0.2), 1);
    }

    private function set_allowNoSelection(value:Bool):Bool {
        if (value == null || this.allowNoSelection == value) return value;

        this.allowNoSelection = value;
        var data = this.data;
        this.data = data;

        return value;
    }

    private function get_labelField():String return this.input.labelField;
    private function set_labelField(value:String):String {
        if (value == null) return value;
        this.input.labelField = value;
        return value;
    }

    private function get_labelFieldFunction():(value:T)->String return this.input.labelFieldFunction;
    private function set_labelFieldFunction(value:(value:T)->String):(value:T)->String {
        if (value == null) return value;
        
        this.input.labelFieldFunction = (v:T) -> {
            if (Std.isOfType(v, String) && Std.string(v) == '') return '';
            return value(v);
        };

        return value;
    }

    private function set_data(value:Array<T>):Array<T> {
        if (value == null) return value;
        this.data = value;

        var content:Array<Dynamic> = [];
        if (this.allowNoSelection) content.push("");
        if (this.data != null) for (item in this.data) content.push(item);

        this.input.data = content;

        return value;
    }

    override private function get_value():T {
        return this.input.selectedIndex == 0 && this.allowNoSelection
            ? null : 
            this.input.selected;
    }

	override private function set_value(value:T):T {
        if (value == null) return value;
		this.input.selected = value;
        this.updateDisplay();
        return value;
	}

    override function setup() {
        super.setup();

        this.addEventListener(PriTapEvent.TAP, this.onTap);
        this.pointer = false;

        this.labelDisplay = new PriText();
        this.labelDisplay.mouseEnabled = false;
        this.labelDisplay.alpha = 0.8;
        this.labelDisplay.autoSize = false;
        this.labelDisplay.multiLine = false;
        this.labelDisplay.text = this.label;

        this.input = this.createInputSelect();

        this.arrow = new FixedIcon(CrappUIIconType.CARET_DOWN);

        this.addChildList([
            this.input,
            this.labelDisplay,
            this.arrow
        ]);
    }

    override function paint() {
        super.paint();

        var style:CrappUIStyle = CrappUIStyle.fromData(this.style);
        var font:PriFontStyle = style.font;

        this.labelDisplay.fontStyle = font;

        this.input.fontStyle = font;
        this.input.fontSize = style.size;

        this.paintBackground(style);
        this.paintBorder(style);
        this.paintCorners(style, CrappUISizeReference.SMALL);
        
        this.height = this.input.height 
            + (style.space * 2) 
            + (this.input.height * CrappUISizeReference.SMALL)
            + style.space / 2;

        this.input.x = (style.space * 3.5) / 2;
        this.input.width = this.width - this.input.x;
        this.input.maxY = this.height - style.space;

        this.arrow.size = style.size;
        this.arrow.color = style.onColor.color;
        this.arrow.maxX = this.input.maxX - style.space;

        if (this.hasFocus()) this.bgColor = style.onFocusColor();
        
        if (this.hasContentOrSelection()) {
            this.labelDisplay.fontSize = CrappUISizeReference.UNDER * style.size;

            this.labelDisplay.y = style.space;
            this.labelDisplay.width = this.width - (style.space * 3.5);
            this.labelDisplay.centerX = this.width/2;

            this.arrow.centerY = this.input.centerY;
        } else {
            this.labelDisplay.fontSize = style.size;

            this.labelDisplay.width = this.width - (style.space * 3.5);
            this.labelDisplay.centerX = this.width/2;
            this.labelDisplay.centerY = this.height/2;

            this.arrow.centerY = this.labelDisplay.centerY;
        }
        
    }

    inline private function hasContentOrSelection():Bool {
        if (this.input.selected != null && (!this.allowNoSelection || this.input.selectedIndex > 0)) return true;
        else return false;
    }

    private function createInputSelect():PriFormSelect {
        var input:PriFormSelect = new PriFormSelect();
        
        (cast input)._baseElement.css('apearance', 'none');
        (cast input)._baseElement.css('-moz-appearance', 'none');
        (cast input)._baseElement.css('-webkit-appearance', 'none');

        input.addEventListener(PriKeyboardEvent.KEY_DOWN, this.onKeyDown);
        input.addEventListener(PriEvent.CHANGE, this.onFieldChange);
        input.addEventListener(PriFocusEvent.FOCUS_IN, this.onFocus);
        input.addEventListener(PriFocusEvent.FOCUS_OUT, this.onFocus);

        return input;
    }

    private function onKeyDown(e:PriKeyboardEvent):Void {
        if (e.keycode != PriKey.ENTER) return;
        if (this.actions.onSubmit != null) this.actions.onSubmit();
    }

    private function onFieldChange(e:PriEvent):Void {
        this.updateDisplay();

        this.killTimer();

        this.delayedChangeTimer = Timer.delay(this.runDelayedChangeEvent, 600);
        if (this.actions.onChange != null) this.actions.onChange();
        this.dispatchEvent(new PriEvent(PriEvent.CHANGE));

        if (this.autoValidation) this.validateAndDisplayError();
    }

    private function onFocus(e:PriFocusEvent):Void {
        this.updateDisplay();

        if (e.type == PriFocusEvent.FOCUS_OUT && this.delayedChangeTimer != null) this.runDelayedChangeEvent();
    }

    inline private function runDelayedChangeEvent():Void {
        this.killTimer();
        if (this.actions.onDelayedChange != null) this.actions.onDelayedChange();
    }

    private function killTimer():Void {
        if (this.delayedChangeTimer == null) return;
        
        this.delayedChangeTimer.stop();
        this.delayedChangeTimer.run = null;
        this.delayedChangeTimer = null;
    }

    override function setFocus() {
        this.input.setFocus();

        var el:Dynamic = Browser.document.getElementById(this.input.fieldId);
        if (el.showPicker != null) el.showPicker();
    }

    private function onTap(e:PriTapEvent):Void this.setFocus();

	function set_label(value:String):String {
        if (value == null) return value;
        this.label = value;
        this.labelDisplay.text = value;
        this.updateDisplay();
        return value;
	}

    override function kill() {
        this.killTimer();
        super.kill();
    }
}