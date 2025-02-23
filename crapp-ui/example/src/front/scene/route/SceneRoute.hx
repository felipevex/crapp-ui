package front.scene.route;

import crapp.ui.route.CrappUIRouteManager;
import util.kit.nothing.Nothing;
import crapp.ui.display.app.CrappUIScene;


@priori('
<priori>
    <imports>
        <crapp.ui.display.button.CrappUIButton />
        <crapp.ui.display.container.CrappUIScrollable />
    </imports>
    <view>
        <private:CrappUIScrollable hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" left="10" right="10" top="10" bottom="10" >
            <private:CrappUIButton id="routeBack" label="ROUTE BACK" />
            <private:CrappUIButton id="routeForward" label="ROUTE FORWARD" />
            <private:CrappUIButton id="routeReload" label="ROUTE RELOAD" />
            <private:CrappUIButton id="routeReplaceWithHome" label="ROUTE REPLACE WITH HOME" />
        </private:CrappUIScrollable>
    </view>
</priori>
')
class SceneRoute extends CrappUIScene<Nothing> {
    
    override function setup() {
        super.setup();

        trace('Scene Started!');
        
        this.routeBack.actions.onClick = () -> CrappUIRouteManager.use().navigateBack();
        this.routeForward.actions.onClick = () -> CrappUIRouteManager.use().navigateForward();
        this.routeReload.actions.onClick = () -> CrappUIRouteManager.use().reload();
        this.routeReplaceWithHome.actions.onClick = () -> CrappUIRouteManager.use().replace(front.route.FrontRoute.pathSceneHome);
        
    }
}