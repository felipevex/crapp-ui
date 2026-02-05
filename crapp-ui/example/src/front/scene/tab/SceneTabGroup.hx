package front.scene.tab;

import crapp.ui.display.layout.CrappUILayout;
import crapp.ui.display.tab.CrappUITab;
import crapp.ui.display.tab.CrappUITabGroup;
import util.kit.nothing.Nothing;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.layout.CrappUILayout />
        <crapp.ui.display.line.CrappUILine />
    </imports>
    <view bgColor="0xcccccc">
        <CrappUILayout hLayoutAlignment="CENTER" vLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="20" left="20" right="20" top="20" bottom="20" >

            <CrappUITabGroup left="50" right="50" height="300" >
                <CrappUITab label="My Red Tab" >
                    <CrappUILayout bgColor="0xF9C3AD"
                        vLayoutAlignment="CENTER" hLayoutAlignment="CENTER"
                        hLayoutSize="FLEX" vLayoutSize="FLEX" >
                        <CrappUILayout bgColor="0xC8615A" />
                    </CrappUILayout>
                </CrappUITab>

                <CrappUITab label="My Green Tab" >
                    <CrappUILayout bgColor="0xC6F9AD"
                        vLayoutAlignment="CENTER" hLayoutAlignment="CENTER"
                        hLayoutSize="FLEX" vLayoutSize="FLEX" >
                        <CrappUILayout bgColor="0x34A530" />
                    </CrappUILayout>
                </CrappUITab>

                <CrappUITab label="My Blue Tab" >
                    <CrappUILayout bgColor="0xADC8F9"
                        vLayoutAlignment="CENTER" hLayoutAlignment="CENTER"
                        hLayoutSize="FLEX" vLayoutSize="FLEX" >
                        <CrappUILayout bgColor="0x3A75A6" />
                    </CrappUILayout>
                </CrappUITab>

            </CrappUITabGroup>

        </CrappUILayout>
    </view>
</priori>
')
class SceneTabGroup extends CrappUIScene<Nothing> {

    override function setup() {
        super.setup();

    }

}