package front.scene.line;

import util.kit.nothing.Nothing;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.layout.CrappUILayout />
        <crapp.ui.display.line.CrappUILine />
    </imports>
    <view>
        <CrappUILayout hLayoutAlignment="CENTER" vLayoutAlignment="CENTER" hLayoutDistribution="SIDE" hLayoutGap="20" left="20" right="20" top="20" bottom="20" >
            
            <CrappUILine orientation="vertical" />
            <CrappUILine orientation="vertical" height="200" />
            <CrappUILine orientation="vertical" top="100" bottom="100" />

            <CrappUILine orientation="vertical" vLayoutSize="FLEX" thickness="1" />
            <CrappUILine orientation="vertical" vLayoutSize="FLEX" thickness="2" />
            <CrappUILine orientation="vertical" vLayoutSize="FLEX" thickness="4" />

            <CrappUILine orientation="vertical" vLayoutSize="FLEX" thickness="1" lineStyle="DOTTED" />
            <CrappUILine orientation="vertical" vLayoutSize="FLEX" thickness="2" lineStyle="DOTTED" />
            <CrappUILine orientation="vertical" vLayoutSize="FLEX" thickness="4" lineStyle="DOTTED" />

            <CrappUILine orientation="vertical" vLayoutSize="FLEX" thickness="1" lineStyle="DASHED" />
            <CrappUILine orientation="vertical" vLayoutSize="FLEX" thickness="2" lineStyle="DASHED" />
            <CrappUILine orientation="vertical" vLayoutSize="FLEX" thickness="4" lineStyle="DASHED" />

        </CrappUILayout>
    </view>
</priori>
')
class SceneLineVertical extends CrappUIScene<Nothing> {
    
    override function setup() {
        super.setup();
    }

}