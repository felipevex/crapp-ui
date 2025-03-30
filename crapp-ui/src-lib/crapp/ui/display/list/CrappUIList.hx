package crapp.ui.display.list;

import crapp.ui.composite.builtin.ScrollerComposite;
import priori.event.PriEvent;
import priori.view.PriDisplay;

@priori('
<priori>
    <view />
</priori>
')
class CrappUIList<T> extends CrappUIDisplay {

    @:isVar public var rowHeight(default, set):Float = 40;
    @:isVar public var data(default, set):Array<T> = [];
    
    @:isVar public var childClass(get, set):Class<CrappUIListChild<T>>;
    private var scrollerSpacer:PriDisplay;
    
    private var childPool:Array<CrappUIListChild<T>> = [];

    private function get_childClass():Class<CrappUIListChild<T>> {
        return this.childClass == null ? CrappUIListChild : this.childClass;
    }

    private function set_childClass(value:Class<CrappUIListChild<T>>):Class<CrappUIListChild<T>> {
        if (value == null || value == this.childClass) return value;

        this.resetChildPool();
        this.childClass = value;
        this.updateList();

        return value;
    }

    override private function setup():Void {
        this.composite.add(ScrollerComposite);

        this.scrollerSpacer = new PriDisplay();
        this.scrollerSpacer.width = 1;
        this.scrollerSpacer.alpha = 0;

        this.addEventListener(PriEvent.SCROLL, this.onScroll);

        this.addChildList([
            this.scrollerSpacer
        ]);
    }

    override private function paint():Void {
        this.updateList();
    }

    private function set_rowHeight(value:Float):Float {
        if (value == null) return value;

        this.rowHeight = value;
        this.updateList();
        return value;
    }

    private function set_data(value:Array<T>):Array<T> {
        this.data = value == null ? [] : value;
        this.updateList();
        return value;
    }

    private function onScroll(e:PriEvent):Void {
        this.updatePoolChildPosition();
    }

    private function updateList():Void {
        this.updateFakeScrollSize();
        this.updatePool();
        this.updatePoolChildSizes();
        this.updatePoolChildPosition();
    }

    private function updateFakeScrollSize():Void {
        var itemHeight:Float = Math.fround(this.rowHeight);

        this.scrollerSpacer.height = itemHeight * this.data.length;
    }

    private function updatePool():Void {
        var itemsNeeded:Int = this.getTotalItemsNeeded();

        if (this.childPool.length > itemsNeeded) this.removeExceedPoolItems(itemsNeeded);
        else if (itemsNeeded > this.childPool.length) this.createNewPoolItems(itemsNeeded);
    }

    inline private function getTotalItemsNeeded():Int {
        var currentHeight:Float = this.height;
        var itemHeight:Float = Math.fround(this.rowHeight);

        return Math.floor(Math.min(this.data.length, currentHeight/itemHeight + 2));
    }

    inline private function removeExceedPoolItems(itemsNeeded:Int):Void {
        var itemsToRemove = this.childPool.splice(itemsNeeded, this.childPool.length);
        this.removeChildList(itemsToRemove);
        for (item in itemsToRemove) item.kill();
    }

    inline private function createNewPoolItems(itemsNeeded:Int):Void {
        var newItemsNeeded:Int = itemsNeeded - this.childPool.length;
        var newItems:Array<CrappUIListChild<T>> = [];

        for (i in 0 ... newItemsNeeded) {
            var item = this.factoryNewItem();
            newItems.push(item);
            this.childPool.push(item);
        }

        this.addChildList(newItems);
    }

    inline private function factoryNewItem():CrappUIListChild<T> {
        var instance:CrappUIListChild<T> = Type.createInstance(
            this.childClass == null ? CrappUIListChild : this.childClass,
            []
        );
        return instance;
    }

    private function resetChildPool():Void {
        if (this.childPool.length == 0) return;

        this.removeChildList(this.childPool);

        for (item in this.childPool) item.kill();

        this.childPool = [];
    }

    private function updatePoolChildSizes():Void {
        var itemHeight:Float = Math.fround(this.rowHeight);
        var itemWidth:Float = this.width;

        for (item in this.childPool) {
            item.startBatchUpdate();

            item.width = itemWidth;
            item.height = itemHeight;

            item.endBatchUpdate();
        }
    }

    private function updatePoolChildPosition():Void {
        if (this.childPool.length == 0) return;

        var totalItems:Int = this.data == null ? 0 : this.data.length;

        var itemHeight:Float = Math.fround(this.rowHeight);
        var currentScrollPosition:Float = this.composite.get(ScrollerComposite).scrollY;

        var initialPosition:Int = Math.floor(currentScrollPosition / itemHeight);
        var initialIndex:Int = initialPosition % this.childPool.length;

        var currentPosition:Int = initialPosition;

        for (i in initialIndex ... this.childPool.length) {
            this.updateItem(this.childPool[i], currentPosition, totalItems, itemHeight);
            currentPosition ++;
        }

        for (i in 0 ... initialIndex) {
            this.updateItem(this.childPool[i], currentPosition, totalItems, itemHeight);
            currentPosition ++;
        }
    }

    private function updateItem(item:CrappUIListChild<T>, rowIndex:Int, totalItems:Int, itemHeight:Float):Void {
        item.startBatchUpdate();

        if (rowIndex >= totalItems) {
            item.visible = false;
            item.y = 0;
        } else {
            item.visible = true;
            item.y = rowIndex * itemHeight;
            item.x = 0;
            item.index = rowIndex;
            item.data = this.data[rowIndex];
        }

        item.endBatchUpdate();
    }

}
