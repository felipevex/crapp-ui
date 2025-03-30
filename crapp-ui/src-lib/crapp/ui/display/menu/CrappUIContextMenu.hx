package crapp.ui.display.menu;

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
    <view tag:L="CrappUIStyleDefaultTagType.CONTEXT_MENU" />
</priori>
')
class CrappUIContextMenu extends CrappUIDisplay {

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
        haxe.Timer.delay(()->{this.alpha = 1;}, 0);
    }

    override function paint() {
        super.paint();

        var lastY:Float = 0;
        var maxWidth:Float = this.getMaxItemWidth();

        for (i in 0 ... this.items.length) {
            var item:CrappUIContextMenuItem = this.items[i];

            item.x = 0;
            item.y = lastY;
            item.width = maxWidth;

            lastY = item.maxY;
        }

        this.width = maxWidth;
        this.height = lastY;

        this.composite.get(OverlayComposite).updatePositionByReference();
    }

    private function getMaxItemWidth():Float {
        var maxWidth:Float = 120;

        for (i in 0 ... this.items.length) {
            var item:CrappUIContextMenuItem = this.items[i];
            maxWidth = Math.max(maxWidth, item.idealWidth());
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

private class CrappUIContextMenuItem extends CrappUIDisplay {
    
    private var displayLabel:CrappUIText;

    private var label:String;

    public function new(label:String, action:()->Void) {
        this.label = label;
        this.actions.onClick = action;
        
        super();
    }

    public function idealWidth():Float {
        var style:CrappUIStyle = CrappUIStyle.fromData(this.style);
        return this.displayLabel.width + style.space * 2;
    }

    override function setup() {
        this.composite.add(OverEffectComposite);
        this.composite.add(ButtonableComposite);

        this.displayLabel = new CrappUIText();
        this.displayLabel.tag = null;
        this.displayLabel.text = this.label;
        this.displayLabel.align = PriFontStyleAlign.LEFT;
        this.displayLabel.weight = PriFontStyleWeight.THICK600;
        this.displayLabel.autoSize = true;

        this.addChildList([
            this.displayLabel
        ]);
    }

    override private function paint():Void {
        this.composite.get(OverEffectComposite).updateDisplay();

        var style:CrappUIStyle = this.composite.get(OverEffectComposite).style;
        
        this.height = this.displayLabel.height + style.space * 2;
        
        this.displayLabel.x = style.space;
        this.displayLabel.centerY = this.height/2 + 1;
    }

}