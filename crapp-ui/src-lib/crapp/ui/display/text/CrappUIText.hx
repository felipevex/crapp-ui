package crapp.ui.display.text;

import crapp.ui.style.types.CrappUIStyleFontWeightType;
import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import tricks.layout.LayoutSize;
import priori.style.font.PriFontStyle;
import priori.style.font.PriFontStyleWeight;
import priori.style.font.PriFontStyleAlign;
import priori.event.PriEvent;
import priori.event.PriFocusEvent;
import priori.event.PriKeyboardEvent;
import helper.kits.StringKit;
import crapp.ui.style.CrappUISizeReference;
import crapp.ui.style.CrappUIStyle;
import crapp.ui.display.CrappUIDisplay;

@priori('
<priori>
    <view>
        <private:priori.view.text.PriText id="label"/>
    </view>
</priori>
')
class CrappUIText extends CrappUIDisplay {

    private var __textValue:String = "Text";

    public var text(get, set):String;
    public var editable(get, set):Bool;
    public var autoSize(get, set):Bool;
    public var multiLine(get, set):Bool;
    public var selectable(get, set):Bool;
    public var align(get, set):PriFontStyleAlign;
    
    @:isVar public var weight(default, set):CrappUIStyleFontWeightType;

    public var size(default, set):CrappUISizeReference = CrappUISizeReference.BASE;

    private var lastSettedWidth:Float;
    private var lastSettedHeight:Float;

    @:isVar public var isHTML(default, set):Bool = false;

    public function new() {
        super();
        
        this.tag = CrappUIStyleDefaultTagType.TEXT;

        this.clipping = false;
        
        this.label.clipping = false;
        this.label.text = this.__textValue;
    }

    override private function set_hLayoutSize(value:LayoutSize):LayoutSize {
        if (value == LayoutSize.FLEX) this.autoSize = false;
        return super.set_hLayoutSize(value);
    }

    private function set_size(value:CrappUISizeReference):CrappUISizeReference {
        this.size = value;
        this.updateDisplay();
        return value;
    }
    
    private function set_isHTML(value:Bool):Bool {
        this.isHTML = value;
        var text:String = this.__textValue;
        this.__textValue = '';
        this.set_text(text);
        return value;
    }

    override private function set_testIdentifier(value:String):String return this.label.testIdentifier=value;
    override private function get_testIdentifier():String return this.label.testIdentifier;

    private function get_align():PriFontStyleAlign return this.label.align;
    private function set_align(value:PriFontStyleAlign):PriFontStyleAlign return this.label.align = value;

    override public function hasFocus():Bool return this.label.hasFocus();

    override public function removeFocus():Void {
        super.removeFocus();
        this.label.removeFocus();
    }

    override private function setup():Void {
        this.label.text = this.__textValue;
        this.label.addEventListener(PriEvent.CHANGE, this.onChange);
        this.label.addEventListener(PriKeyboardEvent.KEY_DOWN, this.onKey);
        this.label.addEventListener(PriFocusEvent.FOCUS_IN, this.onFocus);
        this.label.addEventListener(PriFocusEvent.FOCUS_OUT, this.onFocus);
    }

    private function onChange(e:PriEvent):Void {
        this.__textValue = this.label.text;
        
        this.dispatchEvent(new PriEvent(PriEvent.RESIZE));
        
        if (this.actions.onChange != null) this.actions.onChange();
    }

    private function onFocus(e:PriFocusEvent):Void {
        this.label.ellipsis = 
            this.editable && e.type == PriFocusEvent.FOCUS_IN
            ? false
            : true;

        if (e.type == PriFocusEvent.FOCUS_IN && this.actions.onFocusIn != null) this.actions.onFocusIn();
        else if (e.type == PriFocusEvent.FOCUS_OUT && this.actions.onFocusOut != null) this.actions.onFocusOut();
    }

    private function onKey(e:PriKeyboardEvent):Void {
        var ev:PriKeyboardEvent = cast e.clone();
        ev.currentTarget = this;
        ev.target = this;
        this.dispatchEvent(ev);
    }

    private function get_editable():Bool return this.label.editable;
    private function set_editable(value:Bool):Bool {
        this.label.focusable = value;
        return this.label.editable = value;
    }

    private function get_text():String return this.__textValue;
    private function set_text(value:String):String {
        this.__textValue = value == null ? '' : value;

        if (StringKit.isEmpty(value)) {
            this.label.text = ".";
            this.label.visible = false;
        } else {
            if (this.isHTML) this.label.html = value;
            else this.label.text = value;

            this.label.visible = true;
        }

        this.updateDisplay();
        this.dispatchEvent(new PriEvent(PriEvent.RESIZE));
        return value;
    }

    private function get_autoSize():Bool return this.label.autoSize;
    private function set_autoSize(value:Bool):Bool {
        this.label.autoSize = value;
        this.label.clipping = !value;

        if (!value && this.lastSettedWidth != null) this.width = this.lastSettedWidth;

        this.updateDisplay();
        return value;
    }

    private function get_multiLine():Bool return this.label.multiLine;
    private function set_multiLine(value:Bool):Bool {
        this.label.multiLine = value;
        this.updateDisplay();
        return value;
    }

    private function get_selectable():Bool return this.label.selectable;
    private function set_selectable(value:Bool):Bool return this.label.selectable = value;


    override function updateDisplay() {
        super.updateDisplay();
    }

    override private function paint():Void {
        var style:CrappUIStyle = CrappUIStyle.fromData(this.style);
        
        this.label.startBatchUpdate();
        this.label.fontSize = style.size * this.size;

        var fontStyle:PriFontStyle = style.font;
        if (this.weight != null) fontStyle.weight = this.weight.toPriWheight();
        if (fontStyle.align == null) fontStyle.align = this.align;

        this.label.fontStyle = fontStyle;
        
        this.label.endBatchUpdate();
        
        if (!this.autoSize) this.label.width = Math.round(this.width);
        else super.set_width(Math.round(this.label.width));

        super.set_height(Math.round(this.label.height));
    }

    override private function set_width(value:Float):Float {
        this.lastSettedWidth = value;
        if (!this.autoSize) super.set_width(value);
        return value;
    }

    override private function set_height(value:Float):Float {
        this.lastSettedHeight = value;
        return value;
    }

    private function set_weight(value:CrappUIStyleFontWeightType):CrappUIStyleFontWeightType {
        this.weight = value;
		this.updateDisplay();
        return value;
	}
}