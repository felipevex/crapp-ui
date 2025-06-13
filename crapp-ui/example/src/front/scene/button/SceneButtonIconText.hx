package front.scene.button;

import crapp.ui.display.container.CrappUIScrollable;
import util.kit.nothing.Nothing;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.button.CrappUIButtonIconText />
        <crapp.ui.display.layout.CrappUILayout />
    </imports>
    <view>
        <private:CrappUIScrollable hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" left="10" right="10" top="10" bottom="10" >
            <private:CrappUIButtonIconText />
            <private:CrappUIButtonIconText label="MY LABEL" />
            <private:CrappUIButtonIconText id="red" label="CUBE" icon="CUBE" />
            <private:CrappUIButtonIconText id="small" />
            <private:CrappUIButtonIconText label="DISABLED" disabled=":true" />
            <private:CrappUIButtonIconText label="ROTATION" rotateIcon=":true" />
            <private:CrappUIButtonIconText label="ROTATION DISABLED" disabled=":true" rotateIcon=":true" />
            <private:CrappUIButtonIconText autoSize=":false" width="200" />
            <private:CrappUIButtonIconText id="noborder" label="NO BORDER" />
            <private:CrappUILayout vLayoutSize="FIT" hLayoutSize="FLEX" hLayoutDistribution="SIDE" hLayoutGap="10" >
                <private:CrappUIButtonIconText hLayoutSize="FLEX" />
                <private:CrappUIButtonIconText hLayoutSize="FLEX" />
                <private:CrappUIButtonIconText hLayoutSize="FLEX" />
            </private:CrappUILayout>


            <private:CrappUIButtonIconText iconPosition="RIGHT" />
            <private:CrappUIButtonIconText iconPosition="RIGHT" label="MY LABEL" />
            <private:CrappUIButtonIconText iconPosition="RIGHT" id="red2" label="CUBE" icon="CUBE" />
            <private:CrappUIButtonIconText iconPosition="RIGHT" id="small2" />
            <private:CrappUIButtonIconText iconPosition="RIGHT" label="DISABLED" disabled=":true" />
            <private:CrappUIButtonIconText iconPosition="RIGHT" label="ROTATION" rotateIcon=":true" />
            <private:CrappUIButtonIconText iconPosition="RIGHT" label="ROTATION DISABLED" disabled=":true" rotateIcon=":true" />
            <private:CrappUIButtonIconText iconPosition="RIGHT" autoSize=":false" width="200" />
            <private:CrappUIButtonIconText iconPosition="RIGHT" id="noborder2" label="NO BORDER" />
            <private:CrappUILayout vLayoutSize="FIT" hLayoutSize="FLEX" hLayoutDistribution="SIDE" hLayoutGap="10" >
                <private:CrappUIButtonIconText iconPosition="RIGHT" hLayoutSize="FLEX" />
                <private:CrappUIButtonIconText iconPosition="RIGHT" hLayoutSize="FLEX" />
                <private:CrappUIButtonIconText iconPosition="RIGHT" hLayoutSize="FLEX" />
            </private:CrappUILayout>

        </private:CrappUIScrollable>
    </view>
</priori>
')
class SceneButtonIconText extends CrappUIScene<Nothing> {

    override function setup() {
        super.setup();

        this.red.style = this.red2.style = {
            color: 0xFF0000,
            on_color: 0xFFFFFF
        }

        this.noborder.style = this.noborder2.style = {
            prevent_border : true
        }

        haxe.Timer.delay(() -> {
            this.small.style = this.small2.style = {
                size: 10
            }
        }, 2000);
    }

}