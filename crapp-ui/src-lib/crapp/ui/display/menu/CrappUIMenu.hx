package crapp.ui.display.menu;

import priori.system.PriKey;
import priori.event.PriKeyboardEvent;
import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import crapp.ui.display.layout.CrappUILayout;

@priori('
<priori>
    <view tag:L="CrappUIStyleDefaultTagType.MENU" vLayoutDistribution="SIDE" vLayoutSize="FIT"  >
        <!-- items here -->
    </view>
</priori>
')
class CrappUIMenu extends CrappUILayout {

    public var minWidth(default, set):Float = 100;
    public var maxWidth(default, set):Float;

    private var items:Array<CrappUIMenuChild>;
    private var itemsData:Array<{label:String, action:()->Void}>;

    public var autoSize(default, set):Bool = true;
    public var childClass(default, set):Class<CrappUIMenuChild>;

    public function new() {
        this.items = [];
        this.itemsData = [];

        this.childClass = CrappUIMenuChild;

        super();
    }

    override function paint() {
        super.paint();

        var itemWidth:Float = this.minWidth == null ? 0 : this.minWidth;
        for (item in this.items) itemWidth = Math.max(itemWidth, item.idealWidth());

        if (this.maxWidth != null) itemWidth = Math.round(Math.min(itemWidth, this.maxWidth));

        for (item in this.items) item.width = itemWidth;
        this.width = itemWidth;
    }

    override function setFocus() {
        if (this.items.length > 0) this.items[0].setFocus();
    }

    private function set_minWidth(value:Float):Float {
        this.minWidth = value;
        this.updateDisplay();

        return value;
    }

    private function set_maxWidth(value:Float):Float {
        this.maxWidth = value;
        this.updateDisplay();

        return value;
    }

    private function set_childClass(value:Class<CrappUIMenuChild>):Class<CrappUIMenuChild> {
        if (value == this.childClass) return value;

        this.childClass = value;
        this.rebuildMenu();
        this.updateDisplay();

        return value;
    }

    private function set_autoSize(value:Bool):Bool {
        if (value == null) return this.autoSize;

        this.autoSize = value;
        this.updateDisplay();

        return value;
    }

    public function addMenu(label:String, action:()->Void):Void {
        var instance:CrappUIMenuChild = this.factoryNewItem();
        instance.label = label;
        instance.actions.onClick = action;
        instance.addEventListener(PriKeyboardEvent.KEY_DOWN, this.onKeyDown);

        this.items.push(instance);
        this.itemsData.push({ label: label, action: action });

        this.addChild(instance);
        this.updateDisplay();
    }

    public function clearMenu():Void {
        this.removeChildList(this.items);
        for (item in this.items) item.kill();

        this.items = [];
        this.itemsData = [];

        this.updateDisplay();
    }

    inline private function factoryNewItem():CrappUIMenuChild {
        if (this.childClass == null) throw 'CrappUIMenu: childClass is not set.';

        var instance:CrappUIMenuChild = Type.createInstance(this.childClass, []);
        return instance;
    }

    private function rebuildMenu():Void {
        if (this.items.length == 0) return;

        var itemsDataCopy = this.itemsData.copy();
        this.clearMenu();

        for (data in itemsDataCopy) this.addMenu(data.label, data.action);
    }

    private function onKeyDown(e:PriKeyboardEvent):Void {
        var item:CrappUIMenuChild = cast e.currentTarget;
        var itemIndex:Int = this.items.indexOf(item);

        if (e.keycode == PriKey.ARROW_DOWN) {
            if (itemIndex >= this.items.length - 1) return;
            var nextItem:CrappUIMenuChild = this.items[itemIndex + 1];
            nextItem.setFocus();
        } else if (e.keycode == PriKey.ARROW_UP) {
            if (itemIndex == 0) return;
            var prevItem:CrappUIMenuChild = this.items[itemIndex - 1];
            prevItem.setFocus();
        }
    }


}