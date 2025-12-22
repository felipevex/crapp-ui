package crapp.ui.display.badge;

import tricks.layout.LayoutSize;
import helper.kits.NumberKit;
import priori.geom.PriColor;
import crapp.ui.style.CrappUIStyle;
import crapp.ui.style.data.CrappUIStyleData;

@priori('
<priori>
    <view>

    </view>
</priori>
')
class CrappUIBadgeContainer<T> extends CrappUIDisplay {

    private var badges:Array<CrappUIBadge>;
    private var hideBadge:CrappUIBadge;

    public var data(default, set):Array<T>;
    public var colors(default, set):Array<PriColor> = [];

    public var autoSize(default, set):Bool;
    // public var multiLine(default, set):Bool;

    override function setup() {
        super.setup();

        this.updateHideBadge([]);

        this.badges = [];

        // this.bgColor = 0xcccccc;
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

    private function set_autoSize(value:Bool):Bool {
        this.autoSize = value;
        this.updateDisplay();
        return value;
    }

    override function paint() {
        var styleData:CrappUIStyleData = this.style;
        var style:CrappUIStyle = CrappUIStyle.fromData(styleData);

        var space:Float = style.space;

        this.updateBadgesInline(space);
        this.updateBadgesHiddens(space);
        this.updateBadgesColors();

        this.startBatchUpdate();
        if (this.autoSize) this.width = this.getItemsWidth();
        this.height = this.getItemsHeight();
        this.endBatchUpdate();
    }

    private function updateBadgesInline(space:Float):Void {
        var lastX:Float = 0;

        for (badge in this.badges) {
            badge.x = lastX;
            lastX = badge.maxX + space;
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
        return this.hideBadge.height;
    }

    private function getItemsWidth():Float {
        if (this.badges.length == 0) return 0;
        return this.badges[this.badges.length - 1].maxX;
    }

    private function set_data(value:Array<T>):Array<T> {
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
}