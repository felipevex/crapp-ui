package crapp.ui.display.text;

import crapp.ui.display.icon.types.CrappUIIconType;
import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import crapp.ui.style.CrappUISizeReference;
import priori.style.font.PriFontStyle;
import crapp.ui.style.CrappUIStyle;
import crapp.ui.display.icon.CrappUIIcon;

@priori('
<priori>
    <view tag:L="CrappUIStyleDefaultTagType.TEXT_ICON" />
</priori>
')
class CrappUITextIcon extends CrappUIText {
    
    private var iconDisplay:CrappUIIcon;
    
    @:isVar public var icon(get, set):CrappUIIconType;

    private function get_icon():CrappUIIconType return this.iconDisplay.icon;
    private function set_icon(value:CrappUIIconType):CrappUIIconType return this.iconDisplay.icon = value;

    override function setup() {
        super.setup();

        this.iconDisplay = new CrappUIIcon();
        this.iconDisplay.tag = null;
        this.iconDisplay.size = this.size;

        this.addChildList([
            this.iconDisplay
        ]);
    }

    override private function paint():Void {
        var style:CrappUIStyle = CrappUIStyle.fromData(this.style);

        this.bgColor = style.color;
        this.corners = style.getCornersArray(CrappUISizeReference.UNDER);

        var space:Float = style.space * CrappUISizeReference.UNDER;
        var fontStyle:PriFontStyle = style.font;

        this.iconDisplay.x = space;

        this.label.startBatchUpdate();

        this.label.fontSize = style.size * this.size;
        this.label.x = this.iconDisplay.maxX + space * 0.5;
        this.label.y = space;
        
        if (this.weight != null) fontStyle.weight = this.weight.toPriWheight();
        if (fontStyle.align == null) fontStyle.align = this.align;

        this.label.fontStyle = fontStyle;
        
        this.label.endBatchUpdate();
        
        if (!this.autoSize) this.label.width = Math.round(this.width - space * 2.5 - this.iconDisplay.width);
        else this.setSize(Math.round(this.label.width + space * 2.5 + this.iconDisplay.width), null);

        this.setSize(null, Math.round(this.label.height + space * 2));

        this.iconDisplay.centerY = this.height/2;
    }
}