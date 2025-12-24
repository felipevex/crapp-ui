package crapp.ui.display.badge;

import tricks.layout.LayoutSize;
import helper.kits.NumberKit;
import priori.geom.PriColor;
import crapp.ui.style.CrappUIStyle;
import crapp.ui.style.data.CrappUIStyleData;

@priori('
<priori>
    <view />
</priori>
')
class CrappUIBadgeContainer extends CrappUIDisplay {

    private var badges:Array<CrappUIBadge>;
    private var hideBadge:CrappUIBadge;

    public var data(default, set):Array<String>;
    public var colors(default, set):Array<PriColor> = [];

    public var autoSize(default, set):Bool = true;
    public var multiLine(default, set):Bool = false;

    public var showCloseButton(default, set):Bool = false;

    public var onClose:(value:String)->Void;

    override function setup() {
        super.setup();
        this.updateHideBadge([]);
        this.badges = [];
    }

    private function getMaxRenderedLimit():Float {
        if (this.hideBadge.visible) return this.hideBadge.maxX;
        else return this.badges.length > 0 ? this.badges[this.badges.length - 1].maxX : 0;
    }

    private function updateHideBadge(hidedItems:Array<String>):Void {
        if (this.hideBadge == null) {
            this.hideBadge = new CrappUIBadge();
            this.hideBadge.color = 0x000000;
            this.addChild(this.hideBadge);
        }

        this.hideBadge.tooltip = hidedItems.join(', ');
        this.hideBadge.label = '+${hidedItems.length}';
        this.hideBadge.visible = hidedItems.length > 0;
    }

    private function set_showCloseButton(value:Bool):Bool {
        this.showCloseButton = value;
        for (badge in this.badges) badge.showCloseButton = value;
        this.updateDisplay();
        return value;
    }

    private function set_autoSize(value:Bool):Bool {
        this.autoSize = value;
        this.updateDisplay();
        return value;
    }

    private function set_multiLine(value:Bool):Bool {
        this.multiLine = value;
        this.updateDisplay();
        return value;
    }

    override function paint() {
        var styleData:CrappUIStyleData = this.style;
        var style:CrappUIStyle = CrappUIStyle.fromData(styleData);

        var space:Float = style.space;

        if (!this.multiLine) {
            this.updateBadgesInline(space);
            this.updateBadgesHiddens(space);
        } else {
            this.updateBadgesInBlock(space);
            // this.updateBadgesHiddens(space);
        }

        this.updateBadgesColors();

        this.startBatchUpdate();
        var w:Float = this.getItemsWidth();
        var h:Float = this.getItemsHeight();
        if (w != null) this.width = w;
        if (h != null) this.height = h;
        this.endBatchUpdate();
    }

    private function updateBadgesInline(space:Float):Void {
        var lastX:Float = 0;

        for (badge in this.badges) {
            badge.x = lastX;
            lastX = badge.maxX + space;
        }
    }

    private function updateBadgesInBlock(space:Float):Void {
        var lastX:Float = 0;
        var lastY:Float = 0;
        var maxHeightInLine:Float = 0;

        for (badge in this.badges) {

            if (lastX > 0 && lastX + badge.width > this.width) {
                lastX = 0;
                lastY += maxHeightInLine + space;
                maxHeightInLine = 0;
            }

            badge.x = lastX;
            badge.y = lastY;

            lastX = badge.maxX + space;
            maxHeightInLine = Math.max(maxHeightInLine, badge.height);
        }
    }

    private function updateBadgesHiddens(space:Float):Void {
        if (this.autoSize) {
            for (badge in this.badges) badge.visible = true;
            this.updateHideBadge([]);
            return;
        }

        var hidedItems:Array<String> = [];
        var extraWidth:Float = this.hideBadge.width + space;

        var i:Int = this.badges.length;
        while (i > 0) {
            i--;
            var badge:CrappUIBadge = this.badges[i];

            if (
                (hidedItems.length == 0 && badge.maxX > this.width)
                ||
                (hidedItems.length > 0 && badge.maxX + extraWidth > this.width)
            ) {
                badge.visible = false;
                hidedItems.push(badge.label);
            } else badge.visible = true;

        }

        for (badge in this.badges) {
            if (!badge.visible) {
                this.hideBadge.x = badge.x;
                break;
            }
        }

        hidedItems.reverse();
        this.updateHideBadge(hidedItems);

    }

    private function updateBadgesColors():Void {
        for (badge in this.badges) {
            if (this.colors.length == 0) badge.color = null;
            else if (this.colors.length == 1) badge.color = this.colors[0];
            else {
                var seed:Float = NumberKit.getKeyForSeed(badge.label, 4);
                var index:Int = Math.floor(this.colors.length * seed);
                badge.color = this.colors[index];
            }
        }
    }

    private function getItemsHeight():Float {
        if (!this.autoSize) return null;
        else if (!this.autoSize && !this.multiLine) return this.hideBadge.height;
        else if (this.autoSize && this.badges.length == 0) return this.hideBadge.height;
        else if (this.autoSize && this.multiLine) return this.badges[this.badges.length - 1].maxY;
        else if (this.autoSize && !this.multiLine) return this.hideBadge.height;
        else return null;
    }

    private function getItemsWidth():Float {
        if (!this.autoSize) return null;
        else if (this.autoSize && this.multiLine) return null;
        else if (this.autoSize && !this.multiLine && this.badges.length == 0) return 0;
        else if (this.autoSize && !this.multiLine && this.badges.length > 0) return this.badges[this.badges.length - 1].maxX;
        else return null;
    }

    private function set_data(value:Array<String>):Array<String> {
        this.data = value;
        this.buildTags();
        return value;
    }

    private function buildTags():Void {
        if (this.data == null) {
            this.removeAllChildren();
            this.badges = [];
            return;
        }

        var badgesRemoved:Array<CrappUIBadge> = [];
        var badgesCreated:Array<CrappUIBadge> = [];


        // Remove excess badges
        while (this.badges.length > this.data.length) {
            var badge:CrappUIBadge = this.badges.pop();
            badgesRemoved.push(badge);
        }

        // Add missing badges
        while (this.badges.length < this.data.length) {
            var badge:CrappUIBadge = new CrappUIBadge();
            badge.showCloseButton = this.showCloseButton;
            badge.actions.onClose = this.onBadgeClose.bind(badge);
            this.badges.push(badge);
            badgesCreated.push(badge);
        }

        if (badgesRemoved.length > 0) {
            this.removeChildList(badgesRemoved);
            for (badge in badgesRemoved) badge.kill();
        }

        if (badgesCreated.length > 0) this.addChildList(badgesCreated);

        // Update all badges
        for (i in 0...this.data.length) {
            this.badges[i].label = Std.string(this.data[i]);
        }

        this.updateDisplay();
    }

    private function set_colors(value:Array<PriColor>):Array<PriColor> {
        this.colors = value == null ? [] : value;
        this.updateDisplay();
        return value;
    }

    override private function set_hLayoutSize(value:LayoutSize):LayoutSize {
        if (value == FLEX) this.autoSize = false;
        return super.set_hLayoutSize(value);
    }

    private function onBadgeClose(badge:CrappUIBadge):Void {
        if (this.onClose != null) this.onClose(badge.label);
        if (this.actions.onClick != null) this.actions.onClick();
        if (this.actions.onClose != null) this.actions.onClose();
    }
}