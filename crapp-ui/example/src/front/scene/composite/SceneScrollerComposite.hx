package front.scene.composite;

import crapp.ui.composite.builtin.ScrollerComposite;
import crapp.ui.display.layout.CrappUILayout;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.button.CrappUIButton />
        <crapp.ui.display.layout.CrappUILayout />
    </imports>
    <view>
        <private:CrappUILayout hLayoutAlignment="CENTER" vLayoutAlignment="CENTER" left="10" right="10" top="10" bottom="10" >
            <private:LayoutWithScroller bgColor="0xCCCCCC" hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" width="250" height="250" >
                <private:CrappUIButton />
                <private:CrappUIButton />
                <private:CrappUIButton />
                <private:CrappUIButton />
                <private:CrappUIButton />
                <private:CrappUIButton />
                <private:CrappUIButton />
                <private:CrappUIButton />
                <private:CrappUIButton />
                <private:CrappUIButton />
                <private:CrappUIButton />
                <private:CrappUIButton />
                <private:CrappUIButton />
            </private:LayoutWithScroller>
        </private:CrappUILayout>
    </view>
</priori>
')
class SceneScrollerComposite extends CrappUIScene {
    
    override function setup() {
        super.setup();
    }

}

class LayoutWithScroller extends CrappUILayout {
    
    override function setup() {
        super.setup();

        this.composite.add(ScrollerComposite);
    }
}