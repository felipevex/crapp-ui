package crapp.ui.display.input;

import helper.kits.TimerKit;
import crapp.ui.display.container.CrappUIScrollable;
import crapp.ui.composite.builtin.OverlayComposite;
import crapp.ui.display.app.CrappUIApp;
import crapp.ui.display.menu.CrappUIMenu;
import helper.kits.ArrayKit;
import priori.event.PriEvent;
import priori.geom.PriColor;
import crapp.ui.style.CrappUIStyle;
import priori.system.PriKey;
import priori.event.PriKeyboardEvent;
import helper.kits.StringKit;
import crapp.ui.display.badge.CrappUIBadgeContainer;
import crapp.ui.style.types.CrappUIStyleDefaultTagType;

@priori('
<priori>
    <view
        tag:L="CrappUIStyleDefaultTagType.BADGE_INPUT"
        width="300"
    />
</priori>
')
@:access(crapp.ui.display.input.CrappUITextInput)
@:access(crapp.ui.display.badge.CrappUIBadgeContainer)
class CrappUIBadgeInput extends CrappUIInput<Array<String>> {

    private var field:CrappUITextInput;
    private var optionData:Array<String>;
    private var valueData:Array<String>;

    private var badgeContainer:CrappUIBadgeContainer;

    public var badgeLabelTransformation(default, set):(value:String)->String;
    public var colors(get, set):Array<PriColor>;

    public var allowCreateValues:Bool;

    private var menu:CrappUIBadgeInputMenu;

    @:isVar public var data(default, set):Array<String>;

    /**
       Construtor da classe `CrappUITextInput` que inicializa o componente de entrada de texto.
       Define o `tag` como `TEXT_INPUT` e configura a largura padrão para 300.
       @default width = 300
    **/
    public function new() {
        this.allowCreateValues = true;
        this.valueData = [];
        this.optionData = [];
        this.badgeLabelTransformation = null; // set to default transformation

        super();
    }

    private function set_badgeLabelTransformation(value:(value:String)->String):(value:String)->String {
        if (value == null) this.badgeLabelTransformation = (value:String) -> {
            // default transformation
            if (value == null) return "";
            return StringKit.trim(value).toUpperCase();

        } else this.badgeLabelTransformation = value;

        return value;
    }

    private function get_colors():Array<PriColor> return this.badgeContainer.colors.copy();
    private function set_colors(value:Array<PriColor>):Array<PriColor> {
        this.badgeContainer.colors = value?.copy();
        return value;
    }

    private function set_data(value:Array<String>):Array<String> {
        if (value == null) return value;

        this.data = [];

        for (item in value) {
            var val:String = this.badgeLabelTransformation(item);
            if (!this.data.contains(val)) this.data.push(val);
        }

        return value;
    }

    override private function get_label():String return this.field.label;
    override private function set_label(value:String):String return this.field.label = value;

    override private function get_value():Array<String> return this.valueData.copy();
	override private function set_value(value:Array<String>):Array<String> {
        if (value == null) return value;

        var data:Array<String> = [];

        for (item in value) {
            var val:String = this.badgeLabelTransformation(item);
            if (!data.contains(val)) data.push(val);
        }

		this.valueData = data;
        this.updateDisplay();
        return value;
	}

    override function setup() {
        super.setup();

        this.field = new CrappUITextInput();
        this.field.addEventListener(PriKeyboardEvent.KEY_DOWN, this.onInputKeyDown);

        this.badgeContainer = new CrappUIBadgeContainer();
        this.badgeContainer.showCloseButton = true;
        this.badgeContainer.onClose = this.onCloseBadge;
        this.badgeContainer.zShadow = false;
        this.badgeContainer.z = 1;

        // this.menu = new CrappUIMenu();

        this.addChildList([
            this.badgeContainer,
            this.field
        ]);
    }

    override function paint() {
        super.paint();

        this.field.width = this.width;
        this.height = this.field.height;

        this.updateRenderView();
    }

    private function onCloseBadge(tag:String):Void {
        this.valueData.remove(tag);
        this.updateRenderView();
        this.dispatchChangeAction();
    }

    private function updateRenderView():Void {
        var style:CrappUIStyle = CrappUIStyle.fromData(this.style);
        var padding:Float = (style.space * 3.5) / 2;

        this.badgeContainer.x = padding / 2;

        var maxWidth:Float = this.width * 0.8;

        this.badgeContainer.autoSize = true;
        this.badgeContainer.data = this.valueData;

        this.field.leftInputPadding = this.badgeContainer.width;
        this.field.forceHasContentState = this.valueData.length > 0;
        this.field.updateDisplay();

        if (this.badgeContainer.width > maxWidth) {
            this.badgeContainer.autoSize = false;
            this.badgeContainer.width = maxWidth;
            this.badgeContainer.width = this.badgeContainer.getMaxRenderedLimit();

            this.field.leftInputPadding = this.badgeContainer.width;
            this.field.updateDisplay();
        }

        this.badgeContainer.centerY = this.field.input.centerY;
    }

    private function onInputKeyDown(e:PriKeyboardEvent):Void {

        if (e.keycode == PriKey.ENTER) {
            this.addBadgeFromInput();
            this.closeMenu();
        }
        else if (e.keycode == PriKey.ESC) {
            this.closeMenu();
        }
        else if (e.keycode == PriKey.BACKSPACE && this.field.value == "") {
            this.removeLastBadge();
            this.closeMenu();
        }
        else if (e.keycode == PriKey.ARROW_DOWN) this.openMenu(true);
        else {
            TimerKit.delay('CrappUIBadgeInput', 80, () -> {
                if (this.menu != null) {
                    this.openMenu(false);
                } else {
                    if (!StringKit.isEmpty(this.field.value)) this.openMenu(false);
                }
            });
        }

    }

    private function closeMenu():Void {
        if (this.menu == null) return;

        this.menu.close();
        this.menu.kill();
        this.menu = null;
    }

    private function openMenu(autoFocus:Bool):Void {
        this.closeMenu();

        if (this.data == null) return;

        var input:String = this.badgeLabelTransformation(this.field.value);
        var options:Array<String> = this.data.filter((f:String) -> {
            if (StringKit.isEmpty(input)) return true;
            return StringTools.startsWith(f, input);
        });

        if (options.length == 0) return;

        this.menu = new CrappUIBadgeInputMenu(this.field);

        for (item in options) {
            if (this.valueData.contains(item)) continue;

            this.menu.addMenu(item, () -> {
                if (this.valueData.contains(item)) return;

                this.valueData.push(item);
                this.updateRenderView();
                this.dispatchChangeAction();

                this.field.input.value = "";
                this.field.setFocus();
            });
        }

        this.menu.open();
        if (autoFocus) this.menu.setFocus();
    }

    private function addBadgeFromInput():Void {
        var inputValue:String = this.badgeLabelTransformation(this.field.value);

        if (StringKit.isEmpty(inputValue)) return;
        else if (this.valueData.contains(inputValue)) {
            this.field.value = "";
            return;
        }

        if (!this.allowCreateValues && (this.data == null || !this.data.contains(inputValue))) {
            this.field.value = "";
            return;
        }

        this.field.value = "";
        this.valueData.push(inputValue);
        this.updateRenderView();

        this.dispatchChangeAction();
    }

    private function removeLastBadge():Void {
        if (this.valueData.length == 0) return;

        this.valueData.pop();
        this.updateRenderView();

        this.dispatchChangeAction();
    }

    private function dispatchChangeAction():Void {
        if (this.actions.onChange != null) this.actions.onChange();
    }

}


@priori('
<priori>
    <view

    />
</priori>
')
private class CrappUIBadgeInputMenu extends CrappUIScrollable {

    private var menu:CrappUIMenu;
    private var ref:CrappUITextInput;

    public function new(ref:CrappUITextInput) {
        super();
        this.ref = ref;
    }

    override function setFocus() {
        this.menu.setFocus();
    }

    inline public function addMenu(label:String, action:()->Void):Void {
        this.menu.addMenu(label, () -> {
            action();
            this.close();
        });
    }

    override function setup() {
        super.setup();

        this.composite.add(OverlayComposite);
        this.composite.get(OverlayComposite).autoCloseOnAppClick = true;
        this.composite.get(OverlayComposite).autoPositionOnReference = false;

        this.menu = new CrappUIMenu();
        this.menu.autoSize = false;
        this.addChild(this.menu);

        this.addEventListener(PriKeyboardEvent.KEY_DOWN, this.onKeyDown);
    }

    private function onKeyDown(e:PriKeyboardEvent):Void {
        if (e.keycode == PriKey.ESC) this.close();
    }

    override function paint() {
        super.paint();

        var maxHeight:Float = 200;

        var box = this.composite.get(OverlayComposite).getReferencePosition();
        if (box == null) return;

        this.x = box.x;
        this.y = box.y + box.height;
        this.width = box.width;

        this.height = this.menu.height > maxHeight
            ? maxHeight
            : this.menu.height;

        this.menu.width = this.width;

        var style:CrappUIStyle = CrappUIStyle.fromData(this.style);

        this.corners = [0, 0, Math.round(style.corners), Math.round(style.corners)];
        this.z = 2;
    }

    public function open():Void {
        this.composite.get(OverlayComposite).open(this.ref);
        this.updateDisplay();
    }

    public function close():Void {
        if (!this.hasApp()) return;
        this.composite.get(OverlayComposite).close();
    }

}