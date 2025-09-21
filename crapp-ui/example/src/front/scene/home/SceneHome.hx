package front.scene.home;

import crapp.ui.route.CrappUIRouteManager;
import front.route.FrontRoute;
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
            <private:CrappUIButton id="testStyle" label="STYLE" />
            <private:CrappUIButton id="testText" label="TEXTS" />
            <private:CrappUIButton id="testTextIcon" label="TEXTS - ICON" />
            <private:CrappUIButton id="testButton" label="BUTTONS - BUTTON" />
            <private:CrappUIButton id="testButtonIconText" label="BUTTONS - BUTTON ICON TEXT" />
            <private:CrappUIButton id="testButtonIcon" label="BUTTONS - ICON" />
            <private:CrappUIButton id="testButtonSurface" label="BUTTONS - SURFACE" />
            <private:CrappUIButton id="testInputText" label="INPUT - TEXT" />
            <private:CrappUIButton id="testInputTextMask" label="INPUT - TEXT MASK" />
            <private:CrappUIButton id="testInputTextArea" label="INPUT - TEXTAREA" />
            <private:CrappUIButton id="testInputSelect" label="INPUT - SELECT" />
            <private:CrappUIButton id="testInputRadio" label="INPUT - RADIO" />
            <private:CrappUIButton id="testInputCheck" label="INPUT - CHECK" />
            <private:CrappUIButton id="testCompositeScroller" label="COMPOSITE - SCROLLER" />
            <private:CrappUIButton id="testList" label="LIST" />
            <private:CrappUIButton id="testStack" label="STACK" />
            <private:CrappUIButton id="testMenuContext" label="MENU - CONTEXT" />
            <private:CrappUIButton id="testImage" label="IMAGE" />
            <private:CrappUIButton id="testSurface" label="CONTAINER - SURFACE" />
            <private:CrappUIButton id="testLineHorizontal" label="LINE - HORIZONTAL" />
            <private:CrappUIButton id="testLineVertical" label="LINE - VERTICAL" />
            <private:CrappUIButton id="testModal" label="MODAL" />
            <private:CrappUIButton id="testModalDialog" label="MODAL - DIALOG" />
            <private:CrappUIButton id="testIcon" label="ICON" />
            <private:CrappUIButton id="testFrame" label="FRAME" />
            <private:CrappUIButton id="testRoute" label="ROUTE" />
            <private:CrappUIButton id="testRouteParametric" label="ROUTE - PARAMETRIC" />
            <private:CrappUIButton id="testDrag" label="DRAG" />
        </private:CrappUIScrollable>
    </view>
</priori>
')
class SceneHome extends CrappUIScene<Nothing> {

    override function setup() {
        super.setup();

        this.testStyle.actions.onClick = () -> CrappUIRouteManager.use().navigate(FrontRoute.pathSceneStyle);
        this.testText.actions.onClick = () -> CrappUIRouteManager.use().navigate(FrontRoute.pathSceneText);
        this.testTextIcon.actions.onClick = () -> CrappUIRouteManager.use().navigate(FrontRoute.pathSceneTextIcon);
        this.testButton.actions.onClick = () -> CrappUIRouteManager.use().navigate(FrontRoute.pathSceneButton);
        this.testButtonIconText.actions.onClick = () -> CrappUIRouteManager.use().navigate(FrontRoute.pathSceneButtonIconText);
        this.testButtonIcon.actions.onClick = () -> CrappUIRouteManager.use().navigate(FrontRoute.pathSceneButtonIcon);
        this.testButtonSurface.actions.onClick = () -> CrappUIRouteManager.use().navigate(FrontRoute.pathSceneButtonSurface);
        this.testInputText.actions.onClick = () -> CrappUIRouteManager.use().navigate(FrontRoute.pathSceneInputText);
        this.testInputTextMask.actions.onClick = () -> CrappUIRouteManager.use().navigate(FrontRoute.pathSceneInputTextMask);
        this.testInputTextArea.actions.onClick = () -> CrappUIRouteManager.use().navigate(FrontRoute.pathSceneInputTextArea);
        this.testInputSelect.actions.onClick = () -> CrappUIRouteManager.use().navigate(FrontRoute.pathSceneInputSelect);
        this.testInputRadio.actions.onClick = () -> CrappUIRouteManager.use().navigate(FrontRoute.pathSceneInputRadio);
        this.testInputCheck.actions.onClick = () -> CrappUIRouteManager.use().navigate(FrontRoute.pathSceneInputCheck);
        this.testCompositeScroller.actions.onClick = () -> CrappUIRouteManager.use().navigate(FrontRoute.pathSceneScrollerComposite);
        this.testList.actions.onClick = () -> CrappUIRouteManager.use().navigate(FrontRoute.pathSceneList);
        this.testStack.actions.onClick = () -> CrappUIRouteManager.use().navigate(FrontRoute.pathSceneStack);
        this.testMenuContext.actions.onClick = () -> CrappUIRouteManager.use().navigate(FrontRoute.pathSceneContextMenu);
        this.testImage.actions.onClick = () -> CrappUIRouteManager.use().navigate(FrontRoute.pathSceneImage);
        this.testSurface.actions.onClick = () -> CrappUIRouteManager.use().navigate(FrontRoute.pathSceneSurface);
        this.testLineHorizontal.actions.onClick = () -> CrappUIRouteManager.use().navigate(FrontRoute.pathSceneLineHorizontal);
        this.testLineVertical.actions.onClick = () -> CrappUIRouteManager.use().navigate(FrontRoute.pathSceneLineVertical);
        this.testModal.actions.onClick = () -> CrappUIRouteManager.use().navigate(FrontRoute.pathSceneModal);
        this.testModalDialog.actions.onClick = () -> CrappUIRouteManager.use().navigate(FrontRoute.pathSceneDialog);
        this.testIcon.actions.onClick = () -> CrappUIRouteManager.use().navigate(FrontRoute.pathSceneIcon);
        this.testFrame.actions.onClick = () -> CrappUIRouteManager.use().navigate(FrontRoute.pathSceneFrame);
        this.testRoute.actions.onClick = () -> CrappUIRouteManager.use().navigate(FrontRoute.pathSceneRoute);
        this.testRouteParametric.actions.onClick = () -> CrappUIRouteManager.use().navigate(FrontRoute.pathSceneRouteParametric.build({id: 1, name: 'Hello World'}));
        this.testDrag.actions.onClick = () -> CrappUIRouteManager.use().navigate(FrontRoute.pathSceneDrag);

    }
}