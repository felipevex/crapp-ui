package front.scene.input;

import crapp.ui.display.input.CrappUISelectInput;
import crapp.ui.style.CrappUIStyle;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.layout.CrappUILayotable />
    </imports>
    <view>
        <private:CrappUILayotable id="container" hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" left="10" right="10" top="10" bottom="10" >
            
        </private:CrappUILayotable>
    </view>
</priori>
')
class SceneInputSelect extends CrappUIScene {

    override function setup() {

        var style:CrappUIStyle = CrappUIStyle.bluePrint();
        style.background = 0xFF0000;
        style.primary = 0xFFFFFF;

        var selectData:Array<InputSelectData> = [
            { label: "Option 1", value: 1 },
            { label: "Option 2", value: 2 },
            { label: "Option 3", value: 3 },
            { label: "Option 4", value: 4 },
            { label: "Option 5", value: 5 },
            { label: "Option 6", value: 6 },
            { label: "Option 7", value: 7 }
        ];

        var select1:CrappUISelectInput<InputSelectData> = new CrappUISelectInput<InputSelectData>();
        select1.data = selectData;

        var select2:CrappUISelectInput<InputSelectData> = new CrappUISelectInput<InputSelectData>();
        select2.label = "Write Other Label";
        select2.data = selectData;

        var select3:CrappUISelectInput<InputSelectData> = new CrappUISelectInput<InputSelectData>();
        select3.data = selectData;
        select3.label = "Change the Value Label";
        select3.labelField = "value";

        var select4:CrappUISelectInput<InputSelectData> = new CrappUISelectInput<InputSelectData>();
        select4.data = selectData;
        select4.style = style;

        var select5:CrappUISelectInput<InputSelectData> = new CrappUISelectInput<InputSelectData>();
        select5.data = selectData;
        select5.actions.onChange = () -> {
            select5.label = select5.value.label;
        }


        this.container.addChildList([
            select1,
            select2,
            select3,
            select4,
            select5
        ]);
    }

}

private typedef InputSelectData = {
    var label:String;
    var value:Dynamic;
}