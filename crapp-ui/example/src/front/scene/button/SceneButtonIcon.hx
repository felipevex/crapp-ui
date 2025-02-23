package front.scene.button;

import util.kit.nothing.Nothing;
import crapp.ui.style.CrappUISizeReference;
import crapp.ui.style.data.CrappUIStyleData;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.button.CrappUIButtonIcon />
        <crapp.ui.display.layout.CrappUILayout />
    </imports>
    <view>
        <private:CrappUILayout hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" left="10" right="10" top="10" bottom="10" >
            <private:CrappUIButtonIcon />

            <private:CrappUIButtonIcon size:L="CrappUISizeReference.TINY" />
            <private:CrappUIButtonIcon size:L="CrappUISizeReference.SMALL" />
            <private:CrappUIButtonIcon size:L="CrappUISizeReference.UNDER" />
            <private:CrappUIButtonIcon size:L="CrappUISizeReference.BASE" />
            <private:CrappUIButtonIcon size:L="CrappUISizeReference.EXTRA" />
            <private:CrappUIButtonIcon size:L="CrappUISizeReference.LARGE" />
            <private:CrappUIButtonIcon size:L="CrappUISizeReference.XLARGE" />
            
            <private:CrappUIButtonIcon icon="BAN" disabled=":true" />

            <private:CrappUIButtonIcon icon="THUMBS_UP" />
            <private:CrappUIButtonIcon id="button" icon="VOLUME_UP" z="3" />
        </private:CrappUILayout>
    </view>
</priori>
')
class SceneButtonIcon extends CrappUIScene<Nothing> {
    
    override function setup() {
        super.setup();
        
        var style:CrappUIStyleData = {
            color : 0xC9EBCA,
            on_color : 0x126238
        }

        this.button.style = style;

    }

}