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

        this.clipping = false;
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

        if (this.autoValidation) this.validateAndDisplayError();
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

    override public function validateAndDisplayError():Void {
        try {
            this.validate();
            if (this.displayError != null) this.displayError.visible = false;
        } catch (e:String) {
            this.createErrorMessage();
            this.displayError.text = this.getErrorMessage();

            if (!this.displayError.visible) {
                this.displayError.visible = true;
                this.displayError.allowTransition(ALPHA, null);

                this.displayError.centerX = this.width / 2;
                this.displayError.maxY = 0;
                this.displayError.alpha = 0;

                haxe.Timer.delay(() -> {
                    this.displayError.allowTransition(ALPHA, 0.12);
                    this.displayError.alpha = 1;
                }, 0);
            }
        }
    }

    override function paint():Void {
        super.paint();

        var style:CrappUIStyle = CrappUIStyle.fromData(this.style);

        var space:Float = style.space;

        this.container.hLayoutGap = space;

        this.width = this.container.width;
        this.height = this.container.height;

        if (this.displayError != null) {
            this.displayError.centerX = this.width / 2;
        }
    }

}
