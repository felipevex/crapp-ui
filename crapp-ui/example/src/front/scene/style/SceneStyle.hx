package front.scene.style;

import crapp.ui.style.theme.CrappUIThemeProvider;
import crapp.ui.style.data.CrappUIThemeData;
import crapp.ui.style.CrappUIStyle;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.button.CrappUIButton />
        <crapp.ui.display.layout.CrappUILayotable />
        <crapp.ui.display.text.CrappUIText />
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

            <CrappUILayotable left="0" right="0" vLayoutSize="FIT" hLayoutDistribution="SIDE">
                <CrappUILayotable theme="dark" hLayoutSize="FLEX" hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" vLayoutSize="FIT" >
                    <private:CrappUIText text="Theme Dark" />
                    <CrappUIButton />
                    <CrappUIButton variant="LIGHTER" />
                </CrappUILayotable>
                <CrappUILayotable theme="red" hLayoutSize="FLEX" hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" vLayoutSize="FIT" >
                    <private:CrappUIText text="Theme Red" />
                    <CrappUIButton />
                </CrappUILayotable>
            </CrappUILayotable>

        </private:CrappUILayotable>
    </view>
</priori>
')
class SceneStyle extends CrappUIScene {

    public function new(data:Dynamic) {
        this.registerTheme();

        super(data);
    }
    
    override function setup() {
        super.setup();
        
        this.boxRed.style = {
            color: 0xFF0000,
            on_color: 0xFFFFFF
        };

        this.boxGreen.style = {
            color: 0x00FF00,
            on_color: 0xFFFFFF
        };

        this.boxBlue.style = {
            color: 0x0000FF,
            on_color: 0xFFFFFF
        };

        
    }

    private function registerTheme():Void {
        var darkTheme:CrappUIThemeData = {
            theme: "dark",
            color: 0x313131,
            on_color: 0xFFFFFF,
            tags: [
                {
                    tag : "TEXT",
                    on_color: 0x000000
                },
                {
                    tag : "BUTTON",
                    variants: [{
                        variant : "LIGHTER",
                        color: 0x696969
                    }]
                }
            ]
        };

        var redTheme:CrappUIThemeData = {
            theme: "red",
            color: 0xB82020,
            on_color: 0xFFFFFF,
            tags: [
                {
                    tag : "TEXT",
                    on_color: 0xB82020
                }
            ]
        };

        CrappUIThemeProvider.get().setTheme(darkTheme);
        CrappUIThemeProvider.get().setTheme(redTheme);
    }

}