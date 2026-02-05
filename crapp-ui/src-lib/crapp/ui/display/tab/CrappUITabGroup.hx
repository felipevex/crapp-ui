package crapp.ui.display.tab;

import crapp.ui.style.data.CrappUIStyleData;
import crapp.ui.style.CrappUIColor;
import crapp.ui.controller.CrappUITapController;
import priori.types.PriTransitionType;
import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import crapp.ui.style.CrappUIStyle;
import priori.view.PriDisplay;
import crapp.ui.display.CrappUIDisplay;
import crapp.ui.composite.builtin.ButtonableComposite;
import crapp.ui.composite.builtin.OverEffectComposite;
import crapp.ui.display.text.CrappUIText;
import crapp.ui.display.layout.CrappUILayout;

@priori('
<priori>
    <view root="rootDisplay" tag:L="CrappUIStyleDefaultTagType.TAB">
        <private:CrappUILayout id="contentDisplay" vLayoutDistribution="SIDE">
            <private:CrappUITabHeader id="headerDisplay" />
            <private:CrappUILayout id="rootDisplay" hLayoutSize="FLEX" vLayoutSize="FLEX" />
        </private:CrappUILayout>
    </view>
</priori>
')
class CrappUITabGroup extends CrappUIDisplay {

    override function setup() {
        super.setup();

        this.headerDisplay.actions.onChange = this.onHeaderChange;
    }

    private function onHeaderChange():Void {
        var index:Int = this.headerDisplay.tabIndex;
        var count:Int = -1;

        for (i in 0 ... this.rootDisplay.numChildren) {
            var item:PriDisplay = this.rootDisplay.getChild(i);

            if (!Std.isOfType(item, CrappUITab)) continue;

            count++;
            item.visible = (count == index);
        }

        this.updateDisplay();
    }

    private function updateHeader():Void {
        var tabs:Array<String> = [];

        for (i in 0 ... this.rootDisplay.numChildren) {
            var item:PriDisplay = this.rootDisplay.getChild(i);

            if (!Std.isOfType(item, CrappUITab)) continue;

            var tab:CrappUITab = cast item;
            tabs.push(tab.label);
        }

        this.headerDisplay.tabs = tabs;
    }

    override function paint() {
        super.paint();

        var style = this.style;

        this.contentDisplay.width = this.width;
        this.contentDisplay.height = this.height;

        this.headerDisplay.width = this.width;

        this.updateHeader();

        this.rootDisplay.bgColor = style.color;
        this.rootDisplay.corners = [Math.round(style.corners)];
    }
}

@priori('
<priori>
    <view>

    </view>
</priori>
')
private class CrappUITabHeader extends CrappUIDisplay {

    public var tabIndex(default, null):Int;

    private var handlers:Array<CrappUITabHeaderHandle>;

    public var tabs(default, set):Array<String>;

    override function setup() {
        super.setup();

        this.handlers = [];
        this.tabs = [];

        this.tabIndex = -1;
    }

    override function paint() {
        super.paint();

        var style = this.style;

        var space:Float = style.space;
        var currentX:Float = space;
        var containerHeight:Float = 0;

        for (handler in this.handlers) {
            handler.x = currentX;
            currentX += handler.width + space;
            containerHeight = Math.max(containerHeight, 2 + handler.height);
        }

        for (handler in this.handlers) {
            if (handler.selected) handler.maxY = containerHeight;
            else handler.y = 2;
        }

        this.height = Math.floor(containerHeight);
    }


    private function set_tabs(value:Array<String>):Array<String> {
        if (value == null) return this.tabs;

        this.tabs = value;
        this.updateTabs();

        if (this.tabIndex >= 0 && this.tabs.length == 0) this.tabIndex = -1;
        else if (this.tabIndex == -1 && this.tabs.length > 0) this.dispatch(0);
        else if (this.tabIndex >= this.tabs.length) this.dispatch(this.tabs.length - 1);

        return value;
    }

    private function updateTabs():Void {
        var handlersCount:Int = this.handlers.length;
        var tabsCount:Int = this.tabs.length;

        if (handlersCount < tabsCount) {
            for (i in handlersCount ... tabsCount) {
                var handler:CrappUITabHeaderHandle = new CrappUITabHeaderHandle();
                handler.actions.onClick = null;
                handler.zShadow = false;
                this.handlers.push(handler);
                this.addChild(handler);
            }
        } else if (handlersCount > tabsCount) {
            for (i in tabsCount ... handlersCount) {
                var handler:CrappUITabHeaderHandle = this.handlers.pop();
                handler.actions.onClick = null;
                this.removeChild(handler);
                handler.kill();
            }
        }

        for (i in 0 ... this.handlers.length) {
            var handler:CrappUITabHeaderHandle = this.handlers[i];
            handler.label = this.tabs[i];
            handler.actions.onClick = this.dispatch.bind(i);
        }

    }

    private function dispatch(index:Int):Void {
        this.tabIndex = index;

        for (i in 0 ... this.handlers.length) {
            var handler:CrappUITabHeaderHandle = this.handlers[i];
            handler.selected = (i == index);
        }

        if (this.actions.onChange != null) this.actions.onChange();
    }

}

@priori('
<priori>
    <view >
        <private:CrappUIText tag:L="null" id="displayLabel" text="BUTTON" />
    </view>
</priori>
')
private class CrappUITabHeaderHandle extends CrappUIDisplay {

    public var label(default, set):String;
    public var selected(default, set):Bool = false;

    private var tapController:CrappUITapController;

    override function setup() {
        super.setup();

        // this.composite.add(OverEffectComposite);
        this.composite.add(ButtonableComposite);

        this.tapController = new CrappUITapController(this, this.updateDisplay);

        this.allowTransition(PriTransitionType.BACKGROUND_COLOR, 0.2);
        this.allowTransition(PriTransitionType.Y, 0.5);
        this.allowTransition(PriTransitionType.HEIGHT, 0.5);
    }

    override function paint() {
        super.paint();

        var styleData:CrappUIStyleData = this.style;
        var style:CrappUIStyle = CrappUIStyle.fromData(styleData);

        if (!this.selected) {
            style.color = styleData.on_color;
            style.onColor = styleData.color;
        }

        var space:Float = style.space;

        this.bgColor = (this.tapController.isOver || this.tapController.isFocused)
            ? this.tapController.isDown
                ? style.onFocusColor().darker
                : style.onFocusColor()
            : style.color.color;

        this.displayLabel.style = style.data;

        var corner:Int = Math.round(style.corners);

        if (this.selected) {

            this.height = this.displayLabel.height + space * 2;
            this.corners = [corner, corner, 0, 0];

        } else {

            this.height = this.displayLabel.height + space * 1.5;
            this.corners = [corner];

        }

        this.width = this.displayLabel.width + space * 2.5;

        this.displayLabel.centerX = this.width / 2;
        this.displayLabel.centerY = this.height / 2;

    }

    private function set_selected(value:Bool):Bool {
        this.selected = value;
        this.updateDisplay();
        return value;
    }

    private function set_label(value:String):String {
        if (value == null || value == this.displayLabel.text) return value;

        this.displayLabel.text = value;
        this.updateDisplay();

        return value;
    }

}