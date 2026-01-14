package front.scene.menu;

import crapp.ui.display.container.CrappUIScrollable;
import crapp.ui.display.layout.CrappUILayout;
import crapp.ui.display.menu.CrappUIMenu;
import util.kit.nothing.Nothing;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <view>
        <private:CrappUILayout hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" left="10" right="10" top="10" bottom="10" >
            <CrappUIMenu id="menu1" />

            <CrappUIScrollable hLayoutSize="FIT" height="100">
                <CrappUIMenu id="menu2" />
            </CrappUIScrollable>

            <CrappUIMenu id="menu3" maxWidth="250" />

        </private:CrappUILayout>
    </view>
</priori>
')
class SceneMenu extends CrappUIScene<Nothing> {

    override function setup() {
        super.setup();

        menu1.addMenu("item 1", () -> trace("clicked item 1"));
        menu1.addMenu("item 2", () -> trace("clicked item 2"));
        menu1.addMenu("item 3", () -> trace("clicked item 3"));
        menu1.addMenu("item 4", () -> trace("clicked item 4"));
        menu1.addMenu("item 5", () -> trace("clicked item 5"));

        menu2.addMenu("item A", () -> trace("clicked item A"));
        menu2.addMenu("item B", () -> trace("clicked item B"));
        menu2.addMenu("item C", () -> trace("clicked item C"));
        menu2.addMenu("item D", () -> trace("clicked item D"));
        menu2.addMenu("item E", () -> trace("clicked item E"));

        menu3.addMenu("small item" , () -> trace("clicked small item title"));
        menu3.addMenu("a bit longer item title", () -> trace("clicked a bit longer item title"));
        menu3.addMenu("this is a significantly longer item title to test max width", () -> trace("clicked this is a significantly longer item title to test max width"));


    }
}