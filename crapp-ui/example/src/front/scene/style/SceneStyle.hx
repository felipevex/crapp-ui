package front.scene.style;

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
            <private:CrappUILayotable bgColor="0xF8D8D8" id="boxRed" left="0" right="0" vLayoutSize="FIT" hLayoutAlignment="CENTER" >
                <private:CrappUIButton />
            </private:CrappUILayotable>

            <private:CrappUILayotable bgColor="0xE8F9CC" hLayoutDistribution="JUSTIFY" id="boxGreen" left="0" right="0" vLayoutSize="FIT" hLayoutAlignment="CENTER" >
                <private:CrappUILayotable bgColor="0xB7B0F9" id="boxBlue" vLayoutSize="FIT" width="200" hLayoutAlignment="CENTER" >
                    <private:CrappUIButton />
                </private:CrappUILayotable>
                <private:CrappUIButton />
            </private:CrappUILayotable>

        </private:CrappUILayotable>
    </view>
</priori>
')
class SceneStyle extends CrappUIScene {
    
    override function setup() {
        super.setup();

        var red:CrappUIStyle = CrappUIStyle.fromData({
            background: 0xFF0000,
            primary: 0xFFFFFF
        });

        var green:CrappUIStyle = CrappUIStyle.fromData({
            background: 0x00FF00,
            primary: 0xFFFFFF
        });

        var blue:CrappUIStyle = CrappUIStyle.fromData({
            background: 0x0000FF,
            primary: 0xFFFFFF
        });

        this.boxRed.style = red;
        this.boxGreen.style = green;
        this.boxBlue.style = blue;
    }

}