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
            <private:CrappUILayotable vLayoutSize="FIT" hLayoutSize="FLEX" hLayoutDistribution="SIDE" hLayoutGap="10" >
                <private:CrappUIButton hLayoutSize="FLEX" />
                <private:CrappUIButton hLayoutSize="FLEX" />
                <private:CrappUIButton hLayoutSize="FLEX" />
            </private:CrappUILayotable>
        </private:CrappUILayotable>
    </view>
</priori>
')
class SceneButton extends CrappUIScene {
    
    override function setup() {
        super.setup();

        var style:CrappUIStyle = CrappUIStyle.bluePrint();
        style.background = 0xFF0000;
        style.primary = 0xFFFFFF;

        this.red.style = style;
    }

}