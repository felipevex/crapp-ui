package front.scene.route;

import crapp.ui.display.app.CrappUIScene;


@priori('
<priori>
    <imports>
        <crapp.ui.display.text.CrappUIText />
        <crapp.ui.display.container.CrappUIScrollable />
    </imports>
    <view>
        <private:CrappUIScrollable hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" left="10" right="10" top="10" bottom="10" >
            <private:CrappUIText id="paramId" />
            <private:CrappUIText id="paramName" />
        </private:CrappUIScrollable>
    </view>
</priori>
')
class SceneRouteParametric extends CrappUIScene<{id:Int, name:String}> {
    
    override function setup() {
        super.setup();

        this.paramId.text = '${this.sceneParams.id}';
        this.paramName.text = this.sceneParams.name;
    }
}