package front.scene.button;

import util.kit.nothing.Nothing;
import crapp.ui.style.CrappUISizeReference;
import crapp.ui.style.data.CrappUIStyleData;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.button.CrappUIButtonIcon />
        <crapp.ui.display.button.CrappUIButtonIconTransparent />
        <crapp.ui.display.layout.CrappUILayout />
    </imports>
    <view>
        <private:CrappUILayout hLayoutDistribution="SIDE" vLayoutGap="10" left="10" right="10" top="10" bottom="10" >
            <CrappUILayout hLayoutSize="FLEX" vLayoutSize="FLEX" vLayoutDistribution="SIDE" hLayoutAlignment="CENTER">
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
            </CrappUILayout>

            <CrappUILayout bgColor="0xF7FFC6" hLayoutSize="FLEX" vLayoutSize="FLEX" vLayoutDistribution="SIDE" hLayoutAlignment="CENTER">
                <private:CrappUIButtonIconTransparent />

                <private:CrappUIButtonIconTransparent size:L="CrappUISizeReference.TINY" />
                <private:CrappUIButtonIconTransparent size:L="CrappUISizeReference.SMALL" />
                <private:CrappUIButtonIconTransparent size:L="CrappUISizeReference.UNDER" />
                <private:CrappUIButtonIconTransparent size:L="CrappUISizeReference.BASE" />
                <private:CrappUIButtonIconTransparent size:L="CrappUISizeReference.EXTRA" />
                <private:CrappUIButtonIconTransparent size:L="CrappUISizeReference.LARGE" />
                <private:CrappUIButtonIconTransparent size:L="CrappUISizeReference.XLARGE" />

                <private:CrappUIButtonIconTransparent icon="BAN" disabled=":true" />

                <private:CrappUIButtonIconTransparent icon="THUMBS_UP" />
                <private:CrappUIButtonIconTransparent id="buttonTransparent" icon="VOLUME_UP" z="3" />
            </CrappUILayout>

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
        this.buttonTransparent.style = style;

    }

}