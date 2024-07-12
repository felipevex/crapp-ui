package front.scene.button;

import priori.fontawesome.FontAwesomeIconType;
import crapp.ui.style.CrappUIStyle;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.button.CrappUIButtonIcon />
        <crapp.ui.display.layout.CrappUILayotable />
    </imports>
    <view>
        <private:CrappUILayotable hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" left="10" right="10" top="10" bottom="10" >
            <private:CrappUIButtonIcon />
            <private:CrappUIButtonIcon iconType="${FontAwesomeIconType.THUMBS_UP}" />
            <private:CrappUIButtonIcon id="button" iconType="${FontAwesomeIconType.VOLUME_UP}" z="3" />
        </private:CrappUILayotable>
    </view>
</priori>
')
class SceneButtonIcon extends CrappUIScene {
    
    override function setup() {
        super.setup();
        
        var style:CrappUIStyle = CrappUIStyle.bluePrint();
        style.background = 0xC9EBCA;
        style.primary = 0x126238;

        this.button.style = style;

    }

}