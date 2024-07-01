package crapp.ui.display.menu;

import crapp.ui.composite.builtin.OverlayComposite;
import priori.types.PriTransitionType;
import priori.view.PriDisplay;
import crapp.ui.style.CrappUIStyle;
import priori.style.font.PriFontStyleWeight;
import priori.style.font.PriFontStyleAlign;
import crapp.ui.display.text.CrappUIText;
import crapp.ui.display.button.CrappUIButtonable;

class CrappUIContextMenu extends CrappUIStylableDisplay {

    private var ref:PriDisplay;
    private var items:Array<CrappUIContextMenuItem>;

    public function new() {
        super();
    }

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

    public function addMenu(label:String, action:()->Void, ?style:CrappUIStyle):Void {
        var item:CrappUIContextMenuItem = new CrappUIContextMenuItem(label, () -> {
            this.composite.get(OverlayComposite).close();
            action();
        });
        if (style != null) item.style = style;

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

    public static function open(reference:PriDisplay, items:Array<{label:String, action:()->Void, ?style:CrappUIStyle}>):Void {
        var menu:CrappUIContextMenu = new CrappUIContextMenu();
        for (item in items) menu.addMenu(item.label, item.action, item.style);
        menu.openAt(reference);
    }

}

private class CrappUIContextMenuItem extends CrappUIButtonable {
    
    private var displayLabel:CrappUIText;

    private var label:String;

    public function new(label:String, action:()->Void) {
        this.label = label;
        this.actions.onClick = action;
        
        super();
    }

    public function idealWidth():Float {
        var style:CrappUIStyle = this.style;
        return this.displayLabel.width + style.space * 2;
    }

    override function setup() {
        super.setup();

        this.displayLabel = new CrappUIText();
        this.displayLabel.text = this.label;
        this.displayLabel.align = PriFontStyleAlign.LEFT;
        this.displayLabel.weight = PriFontStyleWeight.THICK600;
        this.displayLabel.autoSize = true;

        this.addChildList([
            this.displayLabel
        ]);
    }

    override private function paint():Void {
        super.paint();

        var style:CrappUIStyle = this.style;

        this.height = this.displayLabel.height + style.space * 2;
        
        this.displayLabel.x = style.space;
        this.displayLabel.centerY = this.height/2 + 1;
    }

}