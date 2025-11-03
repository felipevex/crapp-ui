package front.scene.input;

import crapp.ui.display.input.CrappUICheckInput;
import util.kit.nothing.Nothing;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.layout.CrappUILayout />
        <crapp.ui.display.input.CrappUISelectInput />
    </imports>
    <view >
        <private:CrappUILayout id="container" hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" left="10" right="10" top="10" bottom="10" >
            <CrappUICheckInput value="1" label="OPTION 1" type="<Int>" />
            <CrappUICheckInput value="2" label="OPTION 2" type="<Int>" />
            <CrappUICheckInput value="3" label="OPTION 3" type="<Int>" disabled=":true" />

            <CrappUILayout height="20" />

            <CrappUICheckInput id="o1" value="1" label="OPTION 1" type="<Int>" />
            <CrappUICheckInput id="o2" value="2" label="OPTION 2" type="<Int>" />
            <CrappUICheckInput id="o3" value="3" label="THIS IS A BIG CHECK LABEL" type="<Int>" />

            <CrappUILayout height="20" />

            <CrappUICheckInput id="o4" value="1" type="<Int>" label="" />
            <CrappUICheckInput id="o5" value="2" type="<Int>" label="" />
            <CrappUICheckInput id="o6" value="3" type="<Int>" label="" />

            <CrappUILayout height="20" />

            <CrappUICheckInput id="o7" value="4" label="THIS IS A BIG CHECK LABEL WITH AUTOSIZE FALSE" autoSize=":false" type="<Int>" />

            <CrappUILayout height="20" />

        </private:CrappUILayout>
    </view>
</priori>
')
class SceneInputCheck extends CrappUIScene<Nothing> {

    override function setup() {

        this.theme = "InputTheme";

        this.o1.style = this.o2.style = this.o3.style = {
            on_color: 0xFF0000,
            size: 20
        }

        this.o1.actions.onClick = () -> trace("Check 1 clicked", this.o1.isSelected);
        this.o1.actions.onChange = () -> trace("Check 1 changed", this.o1.isSelected);
        this.o1.actions.onDelayedChange = () -> trace("Check 1 delayed changed", this.o1.isSelected);

        this.o4.style = this.o5.style = this.o6.style = {
            on_color: 0x169216,
            size: 30
        }

        this.o7.width = 200;

    }

}
