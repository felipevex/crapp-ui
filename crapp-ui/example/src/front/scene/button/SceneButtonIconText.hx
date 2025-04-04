package front.scene.button;

import util.kit.nothing.Nothing;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.button.CrappUIButtonIconText />
        <crapp.ui.display.layout.CrappUILayout />
    </imports>
    <view>
        <private:CrappUILayout hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" left="10" right="10" top="10" bottom="10" >
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
        </private:CrappUILayout>
    </view>
</priori>
')
class SceneButtonIconText extends CrappUIScene<Nothing> {
    
    override function setup() {
        super.setup();
        
        this.red.style = {
            color: 0xFF0000,
            on_color: 0xFFFFFF
        }

        this.noborder.style = {
            prevent_border : true
        }
        
        haxe.Timer.delay(() -> {
            this.small.style = {
                size: 10
            }
        }, 2000);
    }

}