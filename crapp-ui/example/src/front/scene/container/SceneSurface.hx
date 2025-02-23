package front.scene.container;

import util.kit.nothing.Nothing;
import crapp.ui.style.theme.CrappUIThemeProvider;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.layout.CrappUILayout />
        <crapp.ui.display.container.CrappUISurface />
    </imports>
    <view>
        <CrappUILayout hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" left="10" right="10" top="10" bottom="10" >
            <CrappUISurface id="suf1" />
            <CrappUISurface id="suf2" variant="other-surface" />
        </CrappUILayout>
    </view>
</priori>
')
class SceneSurface extends CrappUIScene<Nothing> {
    
    override function setup() {
        super.setup();

        this.theme = "SURFACE_SCENE_THEME";

        this.suf1.style = {
            color: 0x00FF00
        }

        CrappUIThemeProvider.get().setTheme({
            theme: "SURFACE_SCENE_THEME",
            tags: [
                {
                    tag : "SURFACE",
                    variants: [
                        {
                            variant : "other-surface",
                            color : 0xFF0000
                        }
                    ]
                }
            ]
        });

    }

}