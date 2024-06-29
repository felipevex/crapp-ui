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


        this.container.addChildList([
            select1
        ]);

        var style:CrappUIStyle = CrappUIStyle.bluePrint();
        style.background = 0xFF0000;
        style.primary = 0xFFFFFF;
        
        // this.red.style = style;
    }

}

private typedef InputSelectData = {
    var label:String;
    var value:Dynamic;
}