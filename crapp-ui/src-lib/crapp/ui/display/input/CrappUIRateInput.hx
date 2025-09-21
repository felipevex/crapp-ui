package crapp.ui.display.input;

import crapp.ui.display.button.CrappUIButtonIconTransparent;
import crapp.ui.display.layout.CrappUILayout;
import crapp.ui.display.icon.types.CrappUIIconType;
import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import crapp.ui.style.CrappUIStyle;

@priori('
<priori>
    <view tag:L="CrappUIStyleDefaultTagType.RATE" >
        <private:CrappUILayout id="container" hLayoutSize="FIT" vLayoutSize="FIT" hLayoutDistribution="SIDE" >

        </private:CrappUILayout>
    </view>
</priori>
')
class CrappUIRateInput extends CrappUIInput<Int> {

    public var iconOn(default, set):CrappUIIconType = STAR;
    public var iconOff(default, set):CrappUIIconType = STAR_REGULAR;

    public var allowNoSelection:Bool = false;

    public var max(default, set):Int = 5;

    private var currentValue:Int = 0;

    private var buttons:Array<CrappUIButtonIconTransparent>;

    override function setup():Void {
        super.setup();

        this.buttons = [];
        this.recreateButtons();
    }

    private function recreateButtons():Void {
        this.container.removeAllChildren();
        for (button in this.buttons) button.kill();
        this.buttons = [];

        for (i in 0 ... this.max) {
            var button = new CrappUIButtonIconTransparent();
            button.tag = null;
            button.icon = i < this.currentValue ? this.iconOn : this.iconOff;
            button.actions.onClick = this.onClick.bind(button);
            this.buttons.push(button);
        }

        this.container.addChildList(this.buttons);
    }

    private function updateIcons():Void {
        for (i in 0 ... this.buttons.length) {
            var button = this.buttons[i];
            button.icon = i < this.currentValue ? this.iconOn : this.iconOff;
        }
    }

    private function onClick(button:CrappUIButtonIconTransparent):Void {
        var index:Int = this.buttons.indexOf(button);
        if (index < 0) return;

        var currentValue = this.currentValue;
        var newValue = currentValue;

        newValue = (this.allowNoSelection && currentValue == index + 1)
            ? 0
            : index + 1;

        this.value = newValue;

        if (currentValue != newValue) {
            if (this.actions.onChange != null) this.actions.onChange();
        }
    }

    private function set_max(value:Int):Int {
        if (value == null || value < 2) return value;
        if (value == this.max) return value;

        this.max = value;
        this.recreateButtons();

        return value;
    }

    private function set_iconOn(value:CrappUIIconType):CrappUIIconType {
        if (value == null) return value;
        this.iconOn = value;
        this.updateIcons();
        return value;
    }

    private function set_iconOff(value:CrappUIIconType):CrappUIIconType {
        if (value == null) return value;
        this.iconOff = value;
        this.updateIcons();
        return value;
    }

    override function get_value():Int return this.currentValue;
    override function set_value(value:Int):Int {
        if (value == null || value < 0) return value;

        this.currentValue = value;
        this.updateIcons();

        return value;
    }

    override function set_label(value:String):String {
        return value;
    }

    override function paint():Void {
        super.paint();

        var style:CrappUIStyle = CrappUIStyle.fromData(this.style);

        var space:Float = style.space;

        this.container.hLayoutGap = space;

        // var padding:Float = Math.floor(style.space / 3);

        // var textHeight:Float = this.reference.height + (padding * 2);
        // var iconHeight:Float = this.iconDisplay.height + (padding * 2);
        // var referenceHeight:Float = Math.max(textHeight, iconHeight);

        // if (StringKit.isEmpty(this.label)) {
        //     this.width = this.height = referenceHeight;

        //     this.iconDisplay.centerX = this.width / 2;
        //     this.iconDisplay.centerY = this.height / 2;

        //     this.bg.width = this.width;
        //     this.bg.height = this.height;
        //     this.bg.corners = [100];

        //     return;
        // }

        // this.iconDisplay.x = padding;
        // this.iconDisplay.centerY = referenceHeight / 2;

        // this.labelDisplay.x = this.iconDisplay.maxX + space;
        // this.labelDisplay.y = referenceHeight/2 - textHeight/2 + padding;

        // this.height = Math.max(referenceHeight, this.labelDisplay.maxY + padding);
        // this.width = this.labelDisplay.maxX + padding * 2;

        // this.bg.width = this.width;
        // this.bg.height = this.height;
        // this.bg.corners = [Math.floor(this.iconDisplay.height / 2 + padding)];

        this.width = this.container.width;
        this.height = this.container.height;


    }

    // private function onTap(e:PriTapEvent):Void {
    //     this.isSelected = !this.isSelected;
    // }

    // private function get_isSelected():Bool return this.isSelected;
    // private function set_isSelected(value:Bool):Bool {
    //     if (value == null) return value;

    //     this.isSelected = value;
    //     this.updateSelectedIcon();

    //     return value;
    // }

    // private function updateSelectedIcon():Void {
    //     this.iconDisplay.icon = this.isSelected
    //         ? CHECK_SQUARE_REGULAR
    //         : SQUARE_REGULAR;
    // }


}
