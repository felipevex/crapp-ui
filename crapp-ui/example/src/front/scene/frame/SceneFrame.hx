package front.scene.frame;

import util.kit.nothing.Nothing;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.layout.CrappUILayout />
        <crapp.ui.display.frame.CrappUIFrame />
    </imports>
    <view>
        <CrappUILayout hLayoutAlignment="CENTER" vLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" left="10" right="10" top="10" bottom="10" >
            
            <CrappUIFrame src="./html/example.html" z="8" corners:L="[8]" width="300" height="250" />

        </CrappUILayout>
    </view>
</priori>
')
class SceneFrame extends CrappUIScene<Nothing> {
    
    override function setup() {
        super.setup();
    }

}