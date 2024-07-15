package front.scene.input;

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
            <CrappUISelectInput id="select1" data:Literal="this.selectData" type="<InputSelectData>" />
            <CrappUISelectInput id="select2" data:Literal="this.selectData" type="<InputSelectData>" label="Write Other Label" />
            <CrappUISelectInput id="select3" data:Literal="this.selectData" type="<InputSelectData>" label="Change the Value Label" labelField="value" />
            <CrappUISelectInput id="select4" data:Literal="this.selectData" type="<InputSelectData>" />
            <CrappUISelectInput id="select5" data:Literal="this.selectData" type="<InputSelectData>" />
            <CrappUISelectInput id="select6" data:Literal="this.selectData" type="<InputSelectData>" />
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

        var style:CrappUIStyleData = {
            color: 0xFF0000,
            on_color: 0xFFFFFF    
        }

        select4.style = style;

        select5.actions.onChange = () -> {
            select5.label = select5.value.label;
        }

        select6.actions.onDelayedChange = () -> {
            select6.label = select6.value.label;
        }
    }

}

private typedef InputSelectData = {
    var label:String;
    var value:Dynamic;
}