package front.scene.button;

import crapp.ui.style.data.CrappUIStyleData;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.button.CrappUIButtonSurface />
        <crapp.ui.display.layout.CrappUILayout />
    </imports>
    <view>
        <private:CrappUILayout hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" left="10" right="10" top="10" bottom="10" >
            <private:CrappUIButtonSurface />
        </private:CrappUILayout>
    </view>
</priori>
')
class SceneButtonSurface extends CrappUIScene {
    
    override function setup() {
        super.setup();
        
        // this.red.style = {
        //     color: 0xFF0000,
        //     on_color: 0xFFFFFF
        // }

        // this.noborder.style = {
        //     prevent_border : true
        // }
        
        // haxe.Timer.delay(() -> {
        //     this.small.style = {
        //         size: 10
        //     }
        // }, 2000);
    }

}