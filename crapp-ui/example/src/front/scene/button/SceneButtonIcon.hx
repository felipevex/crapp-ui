package front.scene.button;

import crapp.ui.style.CrappUISizeReference;
import crapp.ui.style.data.CrappUIStyleData;
import priori.fontawesome.FontAwesomeIconType;
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

            <private:CrappUIButtonIcon size:L="CrappUISizeReference.TINY" />
            <private:CrappUIButtonIcon size:L="CrappUISizeReference.SMALL" />
            <private:CrappUIButtonIcon size:L="CrappUISizeReference.UNDER" />
            <private:CrappUIButtonIcon size:L="CrappUISizeReference.BASE" />
            <private:CrappUIButtonIcon size:L="CrappUISizeReference.EXTRA" />
            <private:CrappUIButtonIcon size:L="CrappUISizeReference.LARGE" />
            <private:CrappUIButtonIcon size:L="CrappUISizeReference.XLARGE" />

            <private:CrappUIButtonIcon icon:L="FontAwesomeIconType.THUMBS_UP" />
            <private:CrappUIButtonIcon id="button" icon:L="FontAwesomeIconType.VOLUME_UP" z="3" />
        </private:CrappUILayotable>
    </view>
</priori>
')
class SceneButtonIcon extends CrappUIScene {
    
    override function setup() {
        super.setup();
        
        var style:CrappUIStyleData = {
            color : 0xC9EBCA,
            on_color : 0x126238
        }

        this.button.style = style;

    }

}