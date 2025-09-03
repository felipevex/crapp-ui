package front.scene.input;

import util.kit.nothing.Nothing;
import crapp.ui.style.theme.CrappUIThemeProvider;
import helper.kits.StringKit;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.input.CrappUITextMaskInput />
        <crapp.ui.display.layout.CrappUILayout />
    </imports>
    <view>
        <private:CrappUILayout hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" left="10" right="10" top="10" bottom="10" >
            <private:CrappUITextMaskInput id="field" label="Your Phone" />
        </private:CrappUILayout>
    </view>
</priori>
')
class SceneInputTextMask extends CrappUIScene<Nothing> {

    override function setup() {
        super.setup();

        this.field.mask = '+{55}(00)00000-0000';

        this.field.actions.onChange = () -> {
            trace(this.field.value, this.field.valueMasked);
        };

        haxe.Timer.delay(() -> {
            this.field.value = "123456789012345678901234567890";
        }, 2000);

        haxe.Timer.delay(() -> {
            trace(this.field.value, this.field.valueMasked);
        }, 3000);
    }

}