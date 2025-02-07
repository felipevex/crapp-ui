package front.scene.button;

import crapp.ui.style.data.CrappUIStyleData;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.button.CrappUIButton />
        <crapp.ui.display.layout.CrappUILayout />
    </imports>
    <view>
        <private:CrappUILayout hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" left="10" right="10" top="10" bottom="10" >
            <private:CrappUIButton />
            <private:CrappUIButton label="MY LABEL" />
            <private:CrappUIButton id="red" />
            <private:CrappUIButton id="small" />
            <private:CrappUIButton label="DISABLED" disabled=":true" />
            <private:CrappUIButton autoSize=":false" width="200" />
            <private:CrappUIButton id="noborder" label="NO BORDER" />
            <private:CrappUILayout vLayoutSize="FIT" hLayoutSize="FLEX" hLayoutDistribution="SIDE" hLayoutGap="10" >
                <private:CrappUIButton hLayoutSize="FLEX" />
                <private:CrappUIButton hLayoutSize="FLEX" />
                <private:CrappUIButton hLayoutSize="FLEX" />
            </private:CrappUILayout>
        </private:CrappUILayout>
    </view>
</priori>
')
class SceneButton extends CrappUIScene {
    
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