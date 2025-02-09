package front.scene.icon;

import crapp.ui.style.CrappUISizeReference;
import priori.fontawesome.FontAwesomeIconType;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.icon.CrappUIIcon />
        <crapp.ui.display.layout.CrappUILayout />
    </imports>
    <view>
        <private:CrappUILayout hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" left="10" right="10" top="10" bottom="10" >
            <private:CrappUIIcon />
            
            <private:CrappUIIcon size:L="CrappUISizeReference.TINY" />
            <private:CrappUIIcon size:L="CrappUISizeReference.SMALL" />
            <private:CrappUIIcon size:L="CrappUISizeReference.UNDER" />
            <private:CrappUIIcon size:L="CrappUISizeReference.BASE" />
            <private:CrappUIIcon size:L="CrappUISizeReference.EXTRA" />
            <private:CrappUIIcon size:L="CrappUISizeReference.LARGE" />
            <private:CrappUIIcon size:L="CrappUISizeReference.XLARGE" />
            
            <private:CrappUIIcon icon="THUMBS_UP" />

        </private:CrappUILayout>
    </view>
</priori>
')
class SceneIcon extends CrappUIScene {
    
    override function setup() {
        super.setup();
    }

}