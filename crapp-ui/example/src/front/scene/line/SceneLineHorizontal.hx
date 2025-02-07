package front.scene.line;

import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.layout.CrappUILayout />
        <crapp.ui.display.line.CrappUILine />
    </imports>
    <view>
        <CrappUILayout hLayoutAlignment="CENTER" vLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="20" left="20" right="20" top="20" bottom="20" >
            
            <CrappUILine />
            <CrappUILine width="200" />
            <CrappUILine left="100" right="100" />

            <CrappUILine hLayoutSize="FLEX" thickness="1" />
            <CrappUILine hLayoutSize="FLEX" thickness="2" />
            <CrappUILine hLayoutSize="FLEX" thickness="4" />

            <CrappUILine hLayoutSize="FLEX" thickness="1" lineStyle="DOTTED" />
            <CrappUILine hLayoutSize="FLEX" thickness="2" lineStyle="DOTTED" />
            <CrappUILine hLayoutSize="FLEX" thickness="4" lineStyle="DOTTED" />

            <CrappUILine hLayoutSize="FLEX" thickness="1" lineStyle="DASHED" />
            <CrappUILine hLayoutSize="FLEX" thickness="2" lineStyle="DASHED" />
            <CrappUILine hLayoutSize="FLEX" thickness="4" lineStyle="DASHED" />

        </CrappUILayout>
    </view>
</priori>
')
class SceneLineHorizontal extends CrappUIScene {
    
    override function setup() {
        super.setup();
    }

}