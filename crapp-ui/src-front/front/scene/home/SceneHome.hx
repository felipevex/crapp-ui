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
            <private:CrappUIButton id="testStyle" label="STYLE" />
            <private:CrappUIButton id="testText" label="TEXTS" />
            <private:CrappUIButton id="testButton" label="BUTTONS - BUTTON" />
            <private:CrappUIButton id="testButtonIcon" label="BUTTON - ICON" />
            <private:CrappUIButton id="testInputText" label="INPUT - TEXT" />
            <private:CrappUIButton id="testInputSelect" label="INPUT - SELECT" />
            <private:CrappUIButton id="testCompositeScroller" label="COMPOSITE - SCROLLER" />
            <private:CrappUIButton id="testList" label="LIST" />
            <private:CrappUIButton id="testMenuContext" label="MENU - CONTEXT" />
        </private:CrappUILayotable>
    </view>
</priori>
')
class SceneHome extends CrappUIScene {
    
    override function setup() {
        super.setup();

        this.testStyle.actions.onClick = () -> PriSceneManager.singleton().navigate('style');
        this.testText.actions.onClick = () -> PriSceneManager.singleton().navigate('text');
        this.testButton.actions.onClick = () -> PriSceneManager.singleton().navigate('button/button');
        this.testButtonIcon.actions.onClick = () -> PriSceneManager.singleton().navigate('button/icon');
        this.testInputText.actions.onClick = () -> PriSceneManager.singleton().navigate('input/text');
        this.testInputSelect.actions.onClick = () -> PriSceneManager.singleton().navigate('input/select');
        this.testCompositeScroller.actions.onClick = () -> PriSceneManager.singleton().navigate('composite/scroller');
        this.testList.actions.onClick = () -> PriSceneManager.singleton().navigate('list');
        this.testMenuContext.actions.onClick = () -> PriSceneManager.singleton().navigate('menu/context');
    }
}