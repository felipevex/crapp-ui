package front.scene.home;

import priori.scene.PriSceneManager;
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
            <private:CrappUIButton id="testInputSelect" label="INPUT - SELECT" />
            <private:CrappUIButton id="testCompositeScroller" label="COMPOSITE - SCROLLER" />
            <private:CrappUIButton id="testList" label="LIST" />
            <private:CrappUIButton id="testMenuContext" label="MENU - CONTEXT" />
            <private:CrappUIButton id="testImage" label="IMAGE" />
            <private:CrappUIButton id="testSurface" label="CONTAINER - SURFACE" />
            <private:CrappUIButton id="testLineHorizontal" label="LINE - HORIZONTAL" />
            <private:CrappUIButton id="testLineVertical" label="LINE - VERTICAL" />
            <private:CrappUIButton id="testModalDialog" label="MODAL - DIALOG" />
            <private:CrappUIButton id="testIcon" label="ICON" />
        </private:CrappUIScrollable>
    </view>
</priori>
')
class SceneHome extends CrappUIScene {
    
    override function setup() {
        super.setup();
        
        this.testStyle.actions.onClick = () -> PriSceneManager.singleton().navigate('style');
        this.testText.actions.onClick = () -> PriSceneManager.singleton().navigate('text');
        this.testTextIcon.actions.onClick = () -> PriSceneManager.singleton().navigate('text/icon');
        this.testButton.actions.onClick = () -> PriSceneManager.singleton().navigate('button/button');
        this.testButtonIconText.actions.onClick = () -> PriSceneManager.singleton().navigate('button/icon/text');
        this.testButtonIcon.actions.onClick = () -> PriSceneManager.singleton().navigate('button/icon');
        this.testButtonSurface.actions.onClick = () -> PriSceneManager.singleton().navigate('button/surface');
        this.testInputText.actions.onClick = () -> PriSceneManager.singleton().navigate('input/text');
        this.testInputSelect.actions.onClick = () -> PriSceneManager.singleton().navigate('input/select');
        this.testCompositeScroller.actions.onClick = () -> PriSceneManager.singleton().navigate('composite/scroller');
        this.testList.actions.onClick = () -> PriSceneManager.singleton().navigate('list');
        this.testMenuContext.actions.onClick = () -> PriSceneManager.singleton().navigate('menu/context');
        this.testImage.actions.onClick = () -> PriSceneManager.singleton().navigate('image');
        this.testSurface.actions.onClick = () -> PriSceneManager.singleton().navigate('container/surface');
        this.testLineHorizontal.actions.onClick = () -> PriSceneManager.singleton().navigate('line/horizontal');
        this.testLineVertical.actions.onClick = () -> PriSceneManager.singleton().navigate('line/vertical');
        this.testModalDialog.actions.onClick = () -> PriSceneManager.singleton().navigate('modal/dialog');
        this.testIcon.actions.onClick = () -> PriSceneManager.singleton().navigate('icon');
        
    }
}