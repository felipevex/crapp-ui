package front.scene.line;

import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.layout.CrappUILayotable />
        <crapp.ui.display.line.CrappUILine />
    </imports>
    <view>
        <CrappUILayotable hLayoutAlignment="CENTER" vLayoutAlignment="CENTER" hLayoutDistribution="SIDE" hLayoutGap="20" left="20" right="20" top="20" bottom="20" >
            
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

        </CrappUILayotable>
    </view>
</priori>
')
class SceneLineVertical extends CrappUIScene {
    
    override function setup() {
        super.setup();
    }

}