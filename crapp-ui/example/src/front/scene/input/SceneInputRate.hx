package front.scene.input;

import crapp.ui.display.input.CrappUICheckInput;
import util.kit.nothing.Nothing;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.layout.CrappUILayout />
        <crapp.ui.display.input.CrappUIRateInput />
    </imports>
    <view >
        <private:CrappUILayout id="container" hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" left="10" right="10" top="10" bottom="10" >
            <CrappUIRateInput />
            <CrappUIRateInput allowNoSelection=":true" />
            <CrappUIRateInput value="3" />
            <CrappUIRateInput value="3" disabled=":true" />

            <CrappUIRateInput max="10" />
            <CrappUIRateInput max="3" />

            <CrappUIRateInput id="red" />

            <CrappUIRateInput iconOn="DOT_CIRCLE_REGULAR" iconOff="CIRCLE_REGULAR" />


        </private:CrappUILayout>
    </view>
</priori>
')
class SceneInputRate extends CrappUIScene<Nothing> {

    override function setup() {

        this.theme = "InputTheme";

        this.red.style = {
            on_color: 0xFF0000,
            color: 0x9900FF,
            size: 25,
            space : 5
        }

    }

}
