package crapp.ui.display.drag;

import priori.event.PriEvent;
import priori.event.PriDragEvent;
import priori.geom.PriGeomPoint;
import helper.kits.NumberKit;
import crapp.ui.display.drag.CrappUIDragAlignHelper.CrappUIDragAlignHelperData;
import priori.geom.PriGeomBox;
import priori.app.PriApp;
import priori.event.PriTapEvent;

class CrappUIDrag<T:CrappUIDragItem> extends CrappUIDisplay {
    
    private var dragItems:Array<T> = [];
    private var draggingItem:T;

    public var items(get, null):Array<T>;

    @:isVar public var dragAlign(get, set):(data:CrappUIDragAlignHelperData)->Array<PriGeomBox>;

    private function get_dragAlign():(data:CrappUIDragAlignHelperData)->Array<PriGeomBox> {
        if (this.dragAlign == null) return CrappUIDragAlignHelper.freeDistribution;
        else return this.dragAlign;
    }

    private function set_dragAlign(value:(data:CrappUIDragAlignHelperData)->Array<PriGeomBox>):(data:CrappUIDragAlignHelperData)->Array<PriGeomBox> {
        return this.dragAlign = value;
    }

    private function get_items():Array<T> return this.dragItems.copy();

    public function addDragItem(item:T):Void {
        this.dragItems.push(item);
        this.addChild(item);

        item.allowTransition(POSITION, 0.5);
        item.dragAnchor.addEventListener(PriTapEvent.TAP_DOWN, this.onDragStart.bind(item));
    }

    override function setup():Void {
        super.setup();

        this.clipping = false;
    }

    override function paint():Void {
        super.paint();

        this.alignItems();
    }

    private function onDragStart(item:T, e:PriTapEvent):Void {
        this.draggingItem = item;

        for (item in this.dragItems) {
            item.z = 0;
        }

        item.z = 20;
        item.zShadow = true;
        item.allowTransition(POSITION, null);
        item.startDrag(false);
        
        PriApp.g().addEventListener(PriTapEvent.TAP_UP, this.onDragStop);
        item.addEventListener(PriEvent.DRAG, this.onDrag);
    }

    private function onDrag(e:PriEvent):Void {
        this.alignItems();
    }

    private function onDragStop(e:PriTapEvent):Void {
        PriApp.g().removeEventListener(PriTapEvent.TAP_UP, this.onDragStop);

        this.draggingItem.removeEventListener(PriEvent.DRAG, this.onDrag);
        this.draggingItem.zShadow = false;
        this.draggingItem.stopDrag();
        this.draggingItem.allowTransition(POSITION, 0.5);
        this.draggingItem = null;

        this.alignItems();
    }

    override function kill():Void {
        PriApp.g().removeEventListener(PriTapEvent.TAP_UP, this.onDragStop);

        if (this.draggingItem != null) {
            this.draggingItem.stopDrag();
            this.draggingItem = null;
        }

        super.kill();
    }

    private function alignItems():Void {
        var boxes = this.dragAlign({
            width : this.width,
            height : this.height,
            items : cast this.dragItems
        });

        if (boxes == null || boxes.length == 0) return;

        if (this.draggingItem != null) {
            var oldIndex:Int = this.dragItems.indexOf(this.draggingItem);

            var box:PriGeomBox = this.findBoxByProximity(this.draggingItem, boxes);
            var newIndex:Int = boxes.indexOf(box);
            
            if (newIndex != oldIndex) {
                trace("Drag item moved from " + oldIndex + " to " + newIndex);
                this.dragItems[oldIndex] = this.dragItems[newIndex];
                this.dragItems[newIndex] = this.draggingItem;

                boxes = this.dragAlign({
                    width : this.width,
                    height : this.height,
                    items : cast this.dragItems
                });
            }
        }
        
        for (i in 0...this.dragItems.length) {
            if (i >= boxes.length) break;
            if (i >= this.dragItems.length) break;

            var item = this.dragItems[i];
            var box = boxes[i];

            if (item == this.draggingItem) continue;

            item.centerX = box.x + box.width / 2;
            item.centerY = box.y + box.height / 2;
        }
    }

    private function findBoxByProximity(element:CrappUIDragItem, boxes:Array<PriGeomBox>):PriGeomBox {
        var result:PriGeomBox = null;

        var elementPoint:PriGeomPoint = new PriGeomPoint(element.centerX, element.centerY);
        var distance:Float = Math.POSITIVE_INFINITY;

        for (box in boxes) {

            var bx:Float = box.x + box.width / 2;
            var by:Float = box.height > element.height 
                ? element.y < box.y
                    ? box.y + box.height 
                    : box.y 
                : box.y + box.height / 2;

            var boxPoint:PriGeomPoint = new PriGeomPoint(bx, by);
            var currDistance:Float = boxPoint.distanceFrom(elementPoint);

            if (currDistance < distance) {
                distance = currDistance;
                result = box;
            }
        }

        return result;
    }
}