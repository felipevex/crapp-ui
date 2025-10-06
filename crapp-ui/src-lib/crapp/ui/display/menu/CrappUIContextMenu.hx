package crapp.ui.display.menu;

import crapp.ui.display.layout.CrappUILayout;
import crapp.ui.style.data.CrappUIStyleData;
import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import helper.kits.StringKit;
import crapp.ui.composite.builtin.ButtonableComposite;
import crapp.ui.composite.builtin.OverEffectComposite;
import crapp.ui.composite.builtin.OverlayComposite;
import priori.types.PriTransitionType;
import priori.view.PriDisplay;
import crapp.ui.style.CrappUIStyle;
import priori.style.font.PriFontStyleWeight;
import priori.style.font.PriFontStyleAlign;
import crapp.ui.display.text.CrappUIText;

@priori('
<priori>
    <view tag:L="CrappUIStyleDefaultTagType.CONTEXT_MENU" vLayoutDistribution="SIDE" vLayoutSize="FIT">
        <!-- items here -->
    </view>
</priori>
')
class CrappUIContextMenu extends CrappUILayout {

    private var ref:PriDisplay;
    private var items:Array<CrappUIContextMenuItem>;

    override function setup() {
        super.setup();

        this.composite.add(OverlayComposite);
        this.composite.get(OverlayComposite).autoCloseOnAppClick = true;
        this.composite.get(OverlayComposite).autoPositionOnReference = true;

        this.setupAlphaIntro();
        this.items = [];

        this.z = 6;
        this.corners = [3];
    }

    private function setupAlphaIntro():Void {
        this.alpha = 0;
        this.allowTransition(PriTransitionType.ALPHA, 0.25);
        haxe.Timer.delay(()->{
            this.alpha = 1;
            this.width += 1;
        }, 0);
    }

    override function paint() {
        super.paint();

        this.width = this.getMaxItemWidth();

        this.composite.get(OverlayComposite).updatePositionByReference();
    }

    private function getMaxItemWidth():Float {
        var maxWidth:Float = 120;

        for (i in 0 ... this.items.length) {
            var item:CrappUIContextMenuItem = this.items[i];
            var itemWidth:Float = item.idealWidth();

            maxWidth = Math.max(maxWidth, itemWidth);
        }

        return maxWidth;
    }

    public function addMenu(label:String, action:()->Void, ?tag:String, ?variant:String):Void {
        var item:CrappUIContextMenuItem = new CrappUIContextMenuItem(label, () -> {
            this.composite.get(OverlayComposite).close();
            action();
        });

        if (!StringKit.isEmpty(tag)) item.tag = tag;
        if (!StringKit.isEmpty(variant)) item.variant = variant;

        this.items.push(item);
        this.addChild(item);
        this.updateDisplay();
    }

    public function openAt(reference:PriDisplay):Void {
        this.ref = reference;
        this.composite.get(OverlayComposite).open(this.ref);
    }

    override function kill() {
        this.ref = null;

        super.kill();
    }

    public static function open(reference:PriDisplay, items:Array<{label:String, action:()->Void, ?tag:String, ?variant:String}>):CrappUIContextMenu {
        var menu:CrappUIContextMenu = new CrappUIContextMenu();
        for (item in items) menu.addMenu(item.label, item.action, item.tag, item.variant);
        menu.openAt(reference);

        return menu;
    }

}


@priori('
<priori>
    <view vLayoutAlignment="CENTER" hLayoutSize="FLEX">
        <private:CrappUIText id="displayLabel" />
    </view>
</priori>
')
private class CrappUIContextMenuItem extends CrappUILayout {

    private var label:String;

    public function new(label:String, action:()->Void) {
        this.label = label;
        this.actions.onClick = action;

        super();
    }

    public function idealWidth():Float {
        var style:CrappUIStyle = CrappUIStyle.fromData(this.style);

        trace(this.label, this.displayLabel.width, style.space);
        return this.displayLabel.width + style.space * 2;
    }

    override function setup() {
        this.composite.add(OverEffectComposite);
        this.composite.add(ButtonableComposite);

        this.displayLabel.tag = null;
        this.displayLabel.variant = null;
        this.displayLabel.text = this.label;

        this.addChildList([
            this.displayLabel
        ]);
    }

    override private function paint():Void {
        this.composite.get(OverEffectComposite).updateDisplay();

        var style:CrappUIStyle = CrappUIStyle.fromData(this.style);

        this.height = this.displayLabel.height + style.space * 2;
        this.displayLabel.x = style.space;
    }

}