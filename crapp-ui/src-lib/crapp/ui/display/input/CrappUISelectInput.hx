package crapp.ui.display.input;

import js.Browser;
import js.html.SelectElement;
import js.html.HtmlElement;
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

class CrappUISelectInput<T> extends CrappUIInput<T> {
    
    private var labelDisplay:PriText;
    private var input:PriFormSelect;
    private var delayedChangeTimer:Timer;

    @:isVar public var label(default, set):String = "LABEL";

    @:isVar public var data(default, set):Array<T>;

    public function new() {
        super();

        this.data = [];
        this.width = 300;
    }

    private function set_data(value:Array<T>):Array<T> {
        if (value == null) return value;
        this.data = value;

        var content:Array<Dynamic> = [];
        content.push("");
        if (this.data != null) for (item in this.data) content.push(item);

        this.input.data = content;

        return value;
    }

    override private function get_value():T return this.input.selected;
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

        this.addChildList([
            this.input,
            this.labelDisplay
        ]);
    }

    override function paint() {
        super.paint();

        var style:CrappUIStyle = this.style;
        var font:PriFontStyle = style.font;

        this.labelDisplay.fontStyle = font;
        this.input.fontStyle = font;

        this.paintBackground(style);
        this.paintBorder(style);
        this.paintCorners(style, CrappUISizeReference.SMALL);
        
        this.height = this.input.height 
            + (style.space * 2) 
            + (this.input.height * CrappUISizeReference.SMALL)
            + style.space / 2;

        this.input.fontSize = style.size;
        this.input.width = this.width - (style.space * 3.5);
        this.input.centerX = this.width/2;
        this.input.maxY = this.height - style.space;
        
        if (this.hasContentOrSelection()) {
            this.labelDisplay.fontSize = CrappUISizeReference.UNDER * style.size;

            this.labelDisplay.y = style.space;
            this.labelDisplay.width = this.width - (style.space * 3.5);
            this.labelDisplay.centerX = this.width/2;
        } else {
            this.labelDisplay.fontSize = style.size;

            this.labelDisplay.width = this.width - (style.space * 3.5);
            this.labelDisplay.centerX = this.width/2;
            this.labelDisplay.centerY = this.height/2;
        }
        
    }

    inline private function hasContentOrSelection():Bool {
        // if (this.input.hasFocus()) return true;
        // else 
        
        if (this.input.selected != null && this.input.selectedIndex > 0) return true;
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