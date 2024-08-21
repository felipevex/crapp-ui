package crapp.ui.display.button;

import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import crapp.ui.composite.builtin.ButtonableComposite;
import crapp.ui.composite.builtin.OverEffectComposite;
import tricks.layout.LayoutSize;
import tricks.layout.LayoutElement;
import priori.style.font.PriFontStyleAlign;
import priori.style.border.PriBorderStyle;
import crapp.ui.style.CrappUISizeReference;
import crapp.ui.style.CrappUIStyle;
import crapp.ui.display.text.CrappUIText;

class CrappUIButton extends CrappUIDisplay {
    
    private var displayLabel:CrappUIText;

    @:isVar public var autoSize(default, set):Bool = true;
    
    public var label(get, set):String;

    public function new() {
        super();
        
        this.tag = CrappUIStyleDefaultTagType.BUTTON;
        
        this.label = 'BUTTON';
    }

    override function get_layout():LayoutElement<CrappUIDisplay> {
        var layout = super.get_layout();
        
        layout.horizontal = {
            size : this.hLayoutSize,
        }

        if (this.autoSize) layout.children = [{x : 0, y : 0, width : this.width, height : this.height}];
        else layout.children = [];
        
        return layout;
    }

    override function set_layout(value:LayoutElement<CrappUIDisplay>):LayoutElement<CrappUIDisplay> {
        var layout = super.set_layout(value);
        
        if (layout.horizontal == null) this.autoSize = true;
        else {
            switch (layout.horizontal.size) {
                case null | LayoutSize.FIT: {
                    this.autoSize = true;
                }
                case LayoutSize.FLEX: {
                    this.autoSize = false;
                    this.width = layout.width;
                }
                case LayoutSize.FIXED: {
                    this.width = layout.width;
                }
            }
        }
        
        return layout;
    }

    override function setup() {
        this.composite.add(OverEffectComposite);
        this.composite.add(ButtonableComposite);

        this.displayLabel = new CrappUIText();
        this.displayLabel.actions.onResize = this.updateDisplay;
        this.displayLabel.tag = null;
        this.displayLabel.align = PriFontStyleAlign.CENTER;

        this.addChildList([
            this.displayLabel
        ]);
    }

    private function set_autoSize(value:Bool):Bool {
        this.autoSize = value;
        this.displayLabel.autoSize = value;
        this.updateDisplay();
        return value;
    }

    private function get_label():String return this.displayLabel.text;
    private function set_label(value:String):String {
        if (value == this.displayLabel.text || value == null) return value;

        this.displayLabel.text = value;
        this.updateDisplay();

        return value;
    }

    override private function paint():Void {
        this.composite.get(OverEffectComposite).updateDisplay();
        
        var style:CrappUIStyle = this.composite.get(OverEffectComposite).style;
        trace(style.preventBorder);

        this.corners = [Math.round(CrappUISizeReference.TINY * style.corners)];
        this.border = style.preventBorder || style.onColor.brightness >= style.color.brightness
            ? null
            : new PriBorderStyle(2, style.onColor.color);

        if (this.autoSize) {
            this.height = this.displayLabel.height + style.space * 2;
            this.width = this.displayLabel.width + style.space * 3.5;
        } else {
            this.displayLabel.width = this.width - style.space * 3.5;
        }
        
        this.displayLabel.startBatchUpdate();
        this.displayLabel.centerY = this.height/2 + 1;
        this.displayLabel.centerX = this.width/2;
        this.displayLabel.endBatchUpdate();
    }

}