package front.scene.home;

import priori.scene.PriSceneManager;
import crapp.ui.display.app.CrappUIScene;


@priori('
<priori>
    <imports>
        <crapp.ui.display.button.CrappUIButton />
        <crapp.ui.display.layout.CrappUILayotable />
    </imports>
    <view>
        <private:CrappUILayotable hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" left="10" right="10" top="10" bottom="10" >
            <private:CrappUIButton id="testButton" label="BUTTONS" />
        </private:CrappUILayotable>
    </view>
</priori>
')
class SceneHome extends CrappUIScene {
    
    override function setup() {
        super.setup();

        this.testButton.actions.onClick = () -> {
            PriSceneManager.singleton().navigate('button');
        }
    }
}