package front.scene.input;

import crapp.ui.display.input.CrappUIRadioInput;
import util.kit.nothing.Nothing;
import crapp.ui.style.theme.CrappUIThemeProvider;
import crapp.ui.display.input.CrappUISelectInput;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.layout.CrappUILayout />
        <crapp.ui.display.input.CrappUISelectInput />
    </imports>
    <view >
        <private:CrappUILayout id="container" hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" left="10" right="10" top="10" bottom="10" >
            <CrappUIRadioInput groupName="radio" value="1" label="OPTION 1" type="<Int>" />
            <CrappUIRadioInput groupName="radio" value="2" label="OPTION 2" type="<Int>" />
            <CrappUIRadioInput groupName="radio" value="3" label="OPTION 3" type="<Int>" disabled=":true" />

            <CrappUILayout height="20" />

            <CrappUIRadioInput id="o1" groupName="other_radio" value="1" label="OPTION 1" type="<Int>" />
            <CrappUIRadioInput id="o2" groupName="other_radio" value="2" label="OPTION 2" type="<Int>" />
            <CrappUIRadioInput id="o3" groupName="other_radio" value="3" label="THIS IS A BIG OPTION LABEL" type="<Int>" />

            <CrappUILayout height="20" />

            <CrappUIRadioInput id="o4" groupName="other_radio_2" value="1" type="<Int>" label="" />
            <CrappUIRadioInput id="o5" groupName="other_radio_2" value="2" type="<Int>" label="" />
            <CrappUIRadioInput id="o6" groupName="other_radio_2" value="3" type="<Int>" label="" />

            <CrappUILayout height="20" />

        </private:CrappUILayout>
    </view>
</priori>
')
class SceneInputRadio extends CrappUIScene<Nothing> {

    var selectData:Array<InputSelectData> = [
        { label: "Option 1", value: 1 },
        { label: "Option 2", value: 2 },
        { label: "Option 3", value: 3 },
        { label: "Option 4", value: 4 },
        { label: "Option 5", value: 5 },
        { label: "Option 6", value: 6 },
        { label: "Option 7", value: 7 }
    ];

    override function setup() {


        this.theme = "InputTheme";

        this.o1.style = this.o2.style = this.o3.style = {
            on_color: 0xFF0000,
            size: 20
        }

        this.o4.style = this.o5.style = this.o6.style = {
            on_color: 0x169216,
            size: 30
        }

        haxe.Timer.delay(() -> {
            var radio = new CrappUIRadioInput<Int>();
            radio.groupName = "radio";
            radio.value = 4;
            radio.label = "OPTION 4";
            radio.isSelected = true;

            haxe.Timer.delay(() -> {
                this.container.addChild(radio);
            }, 2000);

        }, 4000);

    }

}

private typedef InputSelectData = {
    var label:String;
    var value:Dynamic;
}