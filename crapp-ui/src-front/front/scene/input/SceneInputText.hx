package front.scene.input;

import crapp.ui.style.CrappUIStyle;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.input.CrappUITextInput />
        <crapp.ui.display.layout.CrappUILayotable />
    </imports>
    <view>
        <private:CrappUILayotable hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" left="10" right="10" top="10" bottom="10" >
            <private:CrappUITextInput />
            <private:CrappUITextInput width="100" />
            <private:CrappUITextInput value="Value Pre Defined" />
            <private:CrappUITextInput label="Write your label here" />
            <private:CrappUITextInput id="inputChange" label="TEST INPUT CHANGE" />
            <private:CrappUITextInput id="inputChangeDelay" label="TEST CHANGE WITH DELAY" />
            <private:CrappUITextInput id="red" />
            <private:CrappUITextInput label="PASSWORD" password=":true" />
        </private:CrappUILayotable>
    </view>
</priori>
')
class SceneInputText extends CrappUIScene {
    
    override function setup() {

        this.inputChange.actions.onChange = () -> this.inputChange.label = this.inputChange.value;
        this.inputChangeDelay.actions.onDelayedChange = () -> this.inputChangeDelay.label = this.inputChangeDelay.value;

        var style:CrappUIStyle = CrappUIStyle.bluePrint();
        style.background = 0xFF0000;
        style.primary = 0xFFFFFF;
        
        this.red.style = style;
    }

}