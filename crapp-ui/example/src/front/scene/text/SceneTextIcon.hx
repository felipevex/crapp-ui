package front.scene.text;

import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.text.CrappUITextIcon />
        <crapp.ui.display.layout.CrappUILayout />
    </imports>
    <view>
        <private:CrappUILayout hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" left="10" right="10" top="10" bottom="10" >
            <private:CrappUITextIcon />
            <private:CrappUITextIcon text="This is a loooooooong text" />
            <private:CrappUITextIcon icon="EXCLAMATION_TRIANGLE" id="textStyle" text="This is a text with style" />
            <private:CrappUITextIcon autoSize=":false" width="150" text="This is a loooooooong text with autosize off" />
            <private:CrappUITextIcon autoSize=":false" multiLine=":true" width="150" text="This is a loooooooong text with multiline on" />
            <private:CrappUITextIcon selectable=":true" text="This is a selectable text" />
            <private:CrappUITextIcon editable=":true" text="This is an editable text" />
        </private:CrappUILayout>
    </view>
</priori>
')
class SceneTextIcon extends CrappUIScene {
    
    override function setup() {
        super.setup();
        
        this.textStyle.style = {
            color: 0xAB0D0D,
            on_color: 0xFFFFFF
        }

    }
}