package front.scene.input;

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
    <view>
        <private:CrappUILayout id="container" hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" left="10" right="10" top="10" bottom="10" >
            <CrappUISelectInput data:Literal="this.selectData" type="<InputSelectData>" />
            <CrappUISelectInput data:Literal="this.selectData" type="<InputSelectData>" label="Write Other Label" />
            <CrappUISelectInput data:Literal="this.selectData" type="<InputSelectData>" label="Change the Value Label" labelField="value" />
            <CrappUISelectInput data:Literal="this.selectData" disabled=":true" type="<InputSelectData>" label="Disabled" labelField="value" />
            <CrappUISelectInput id="red" data:Literal="this.selectData" type="<InputSelectData>" />
            <CrappUISelectInput id="small" data:Literal="this.selectData" type="<InputSelectData>" />
            <CrappUISelectInput id="inputChange" data:Literal="this.selectData" type="<InputSelectData>" />
            <CrappUISelectInput id="inputChangeDelay" data:Literal="this.selectData" type="<InputSelectData>" />
            <CrappUISelectInput id="inputError" label="ERROR TEST" data:Literal="this.selectData" type="<InputSelectData>" />
            <CrappUISelectInput id="noborder" data:Literal="this.selectData" type="<InputSelectData>" label="NO BORDER" />
            <CrappUISelectInput id="labelFunc" data:Literal="this.selectData" type="<InputSelectData>" label="LABEL FUNCTION" />
            <CrappUISelectInput id="forceSelection" data:Literal="this.selectData" type="<InputSelectData>" label="FORCE SELECTION" />
            <private:CrappUILayout id="distribute" vLayoutSize="FIT" hLayoutSize="FLEX" hLayoutDistribution="SIDE" hLayoutGap="10" >
                <CrappUISelectInput type="<InputSelectData>" hLayoutSize="FLEX" />
                <CrappUISelectInput type="<InputSelectData>" hLayoutSize="FLEX" />
                <CrappUISelectInput type="<InputSelectData>" hLayoutSize="FLEX" />
            </private:CrappUILayout>
        </private:CrappUILayout>
    </view>
</priori>
')
class SceneInputSelect extends CrappUIScene<Nothing> {

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

        red.style = {
            color: 0xFF0000,
            on_color: 0xFFFFFF
        }

        noborder.style = {
            prevent_border : true
        }

        this.labelFunc.labelFieldFunction = (value:InputSelectData) -> {
            return 'Double ${value.value} -> ${value.value * 2}';
        }

        haxe.Timer.delay(() -> {
            this.small.style = {
                size: 10
            }
        }, 2000);

        inputChange.actions.onChange = () -> {
            inputChange.label = inputChange.value.label;
        }

        inputChangeDelay.actions.onDelayedChange = () -> {
            inputChangeDelay.label = inputChangeDelay.value.label;
        }

        this.inputError.addValidation((value:InputSelectData) -> {
            if (value == null) throw "Value is required";
        });

        this.forceSelection.allowNoSelection = false;

        CrappUIThemeProvider.get().setTheme({
            theme : "InputTheme",
            tags: [
                {
                    tag : "TEXT_ICON",
                    variants : [
                        {
                            variant: "ERROR",
                            color: 0xFF0000,
                            on_color: 0xFFFFFF,
                            size : 10
                        }
                    ]
                }
            ]
        });
    }

}

private typedef InputSelectData = {
    var label:String;
    var value:Dynamic;
}