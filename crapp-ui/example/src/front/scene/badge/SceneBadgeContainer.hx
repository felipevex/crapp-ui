package front.scene.badge;

import priori.geom.PriColor;
import crapp.ui.display.badge.CrappUIBadgeContainer;
import util.kit.nothing.Nothing;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.icon.CrappUIIcon />
        <crapp.ui.display.layout.CrappUILayout />
    </imports>
    <view>
        <private:CrappUILayout hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="20" left="10" right="10" top="10" bottom="10" >
            <CrappUILayout height="0"/>

            <CrappUIBadgeContainer type="<String>" id="container1" autoSize=":true" />
            <CrappUIBadgeContainer type="<String>" id="container2" autoSize=":false" left="200" right="200" />
            <CrappUIBadgeContainer type="<String>" id="container3" autoSize=":false" hLayoutSize="FLEX" />

            <CrappUIBadgeContainer type="<String>" id="container4" autoSize=":true" />
            <CrappUIBadgeContainer type="<String>" id="container5" autoSize=":false" left="200" right="200" />
            <CrappUIBadgeContainer type="<String>" id="container6" autoSize=":false" hLayoutSize="FLEX" />

            <CrappUIBadgeContainer type="<String>" id="container7" autoSize=":true" />
            <CrappUIBadgeContainer type="<String>" id="container8" autoSize=":false" left="200" right="200" />
            <CrappUIBadgeContainer type="<String>" id="container9" autoSize=":false" hLayoutSize="FLEX" />

            <CrappUIBadgeContainer type="<String>" id="container10" autoSize=":true" multiLine=":true" width="500"/>
            <CrappUIBadgeContainer type="<String>" id="container11" autoSize=":true" multiLine=":true" left="200" right="200" />
            <CrappUIBadgeContainer type="<String>" id="container12" autoSize=":false" multiLine=":true" width="250" height="125" />

        </private:CrappUILayout>
    </view>
</priori>
')
class SceneBadgeContainer extends CrappUIScene<Nothing> {

    override function setup() {
        super.setup();

        var fruits:Array<String> = ["Apple", "Banana", "Cherry", "Grape", "Jackfruit", "Kiwi", "Lemon", "Mango", "Nectarine", "Orange", "Papaya", "Tangerine"];
        var colors:Array<PriColor> = [
            0xe67d7d, 0xec933a, 0xFFF200, 0x56E03B, 0x17f6d8, 0x56a1ec, 0x7e54f1, 0xb460de, 0xe75ca9, 0xf36067,
            0xc45a5a, 0xca7521, 0xC2B809, 0x1DA80E, 0x0baa95, 0x2165a9, 0x4d27b6, 0x7d24a9, 0xac2c72, 0xb3262d,
            0x8d2a2a, 0x975412, 0x727E08, 0x16680D, 0x0d6f62, 0x103e6b, 0x301086, 0x561178, 0x690c3f, 0x740b11,
            0x777777, 0x959595, 0x4F4F4F, 0x3B3B3B
        ];

        this.container1.data = fruits;
        this.container2.data = fruits;
        this.container3.data = fruits;

        this.container4.data = fruits;
        this.container4.colors = [0x008236];
        this.container5.data = fruits;
        this.container5.colors = [0x008236];
        this.container6.data = fruits;
        this.container6.colors = [0x008236];

        this.container7.data = fruits;
        this.container7.colors = colors;
        this.container8.data = fruits;
        this.container8.colors = colors;
        this.container9.data = fruits;
        this.container9.colors = colors;

        this.container10.data = fruits;
        this.container10.colors = colors;
        this.container11.data = fruits;
        this.container11.colors = colors;
        this.container12.data = fruits;
        this.container12.colors = colors;
    }



}