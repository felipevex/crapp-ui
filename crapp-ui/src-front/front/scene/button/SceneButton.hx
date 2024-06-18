package front.scene.button;

import crapp.ui.style.CrappUIStyle;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.button.CrappUIButton />
        <crapp.ui.display.layout.CrappUILayotable />
    </imports>
    <view>
        <private:CrappUILayotable hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" left="10" right="10" top="10" bottom="10" >
            <private:CrappUIButton />
            <private:CrappUIButton label="MY LABEL" />
            <private:CrappUIButton id="red" />
            <private:CrappUIButton autoSize=":false" width="200" />
        </private:CrappUILayotable>
    </view>
</priori>
')
class SceneButton extends CrappUIScene {
    
    override function setup() {
        super.setup();

        this.red.style = new CrappUIStyle(0xFFFFFF, 0xFF0000, 13, 10, 'Saira, Open Sans', 6);
    }

    override function paint() {
        super.paint();
    }

}