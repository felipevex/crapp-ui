package front.scene.input;

import crapp.ui.style.theme.CrappUIThemeProvider;
import crapp.ui.style.data.CrappUIStyleData;
import crapp.ui.display.input.CrappUISelectInput;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.layout.CrappUILayotable />
        <crapp.ui.display.input.CrappUISelectInput />
    </imports>
    <view>
        <private:CrappUILayotable id="container" hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" left="10" right="10" top="10" bottom="10" >
            <CrappUISelectInput data:Literal="this.selectData" type="<InputSelectData>" />
            <CrappUISelectInput data:Literal="this.selectData" type="<InputSelectData>" label="Write Other Label" />
            <CrappUISelectInput data:Literal="this.selectData" type="<InputSelectData>" label="Change the Value Label" labelField="value" />
            <CrappUISelectInput id="red" data:Literal="this.selectData" type="<InputSelectData>" />
            <CrappUISelectInput id="small" data:Literal="this.selectData" type="<InputSelectData>" />
            <CrappUISelectInput id="inputChange" data:Literal="this.selectData" type="<InputSelectData>" />
            <CrappUISelectInput id="inputChangeDelay" data:Literal="this.selectData" type="<InputSelectData>" />
            <CrappUISelectInput id="inputError" label="ERROR TEST" data:Literal="this.selectData" type="<InputSelectData>" />
            <CrappUISelectInput id="noborder" data:Literal="this.selectData" type="<InputSelectData>" label="NO BORDER" />
            
            <private:CrappUILayotable id="distribute" vLayoutSize="FIT" hLayoutSize="FLEX" hLayoutDistribution="SIDE" hLayoutGap="10" >
                <CrappUISelectInput type="<InputSelectData>" hLayoutSize="FLEX" />
                <CrappUISelectInput type="<InputSelectData>" hLayoutSize="FLEX" />
                <CrappUISelectInput type="<InputSelectData>" hLayoutSize="FLEX" />
            </private:CrappUILayotable>
        </private:CrappUILayotable>
    </view>
</priori>
')
class SceneInputSelect extends CrappUIScene {

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