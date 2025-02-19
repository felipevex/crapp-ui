package front.scene.text;

import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.text.CrappUIText />
        <crapp.ui.display.layout.CrappUILayout />
    </imports>
    <view>
        <private:CrappUILayout hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" left="10" right="10" top="10" bottom="10" >
            <private:CrappUIText />
            <private:CrappUIText text="This is a loooooooong text" />
            <private:CrappUIText id="textStyle" text="This is a text with style" />
            <private:CrappUIText autoSize=":false" width="150" text="This is a loooooooong text with autosize off" />
            <private:CrappUIText autoSize=":false" width="150" text="right align" align="RIGHT" />
            <private:CrappUIText autoSize=":false" multiLine=":true" width="150" text="This is a loooooooong text with multiline on" />
            <private:CrappUIText selectable=":true" text="This is a selectable text" />
            <private:CrappUIText editable=":true" text="This is an editable text" />
        </private:CrappUILayout>
    </view>
</priori>
')
class SceneText extends CrappUIScene {
    
    override function setup() {
        super.setup();
        
        this.textStyle.style = {
            on_color: 0xAB0D0D
        }

    }

}