package front.scene.input;

import crapp.ui.display.input.CrappUIToggleInput;
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
            <CrappUIToggleInput value="1" label="TOGGLE 1" type="<Int>" />
            <CrappUIToggleInput value="2" label="TOGGLE 2" type="<Int>" />
            <CrappUIToggleInput value="3" label="TOGGLE 3 (disabled)" type="<Int>" disabled=":true" />
            <CrappUIToggleInput value="4" label="TOGGLE 4 (disabled)" isSelected=":true" type="<Int>" disabled=":true" />

            <CrappUILayout height="20" />

            <CrappUIToggleInput id="o1" value="1" label="TOGGLE 1" type="<Int>" />
            <CrappUIToggleInput id="o2" value="2" isSelected=":true" label="TOGGLE 2" type="<Int>" />
            <CrappUIToggleInput id="o3" value="3" label="THIS IS A BIG TOGGLE LABEL" type="<Int>" />

            <CrappUILayout height="20" />

            <CrappUIToggleInput id="o4" value="1" type="<Int>" label="" />
            <CrappUIToggleInput id="o5" value="2" type="<Int>" label="" />
            <CrappUIToggleInput id="o6" value="3" type="<Int>" label="" />

            <CrappUILayout height="20" />

        </private:CrappUILayout>
    </view>
</priori>
')
class SceneInputToggle extends CrappUIScene<Nothing> {

    override function setup() {

        this.theme = "InputTheme";

        this.o1.style = this.o2.style = this.o3.style = {
            on_color: 0xFF0000,
            size: 20
        }

        this.o1.actions.onClick = () -> trace("Toggle 1 clicked", this.o1.isSelected);
        this.o1.actions.onChange = () -> trace("Toggle 1 changed", this.o1.isSelected);
        this.o1.actions.onDelayedChange = () -> trace("Toggle 1 delayed changed", this.o1.isSelected);

        this.o4.style = this.o5.style = this.o6.style = {
            on_color: 0x169216,
            size: 30
        }

    }

}
