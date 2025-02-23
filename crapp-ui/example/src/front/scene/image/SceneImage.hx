package front.scene.image;

import util.kit.nothing.Nothing;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.layout.CrappUILayout />
        <crapp.ui.display.image.CrappUIImage />
        <crapp.ui.display.text.CrappUIText />
    </imports>
    <view>
        <CrappUILayout hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" left="10" right="10" top="10" bottom="10" >
            <CrappUIImage />
            <CrappUIText text="Image without src" />

            <CrappUIImage id="logo" src="./image/logo.png" />
            <CrappUIText text="Image with src" />

            <CrappUIImage src="./image/logo.png" resize="AUTO_HEIGHT" width="200" />
            <CrappUIText text="AUTO_HEIGHT" />

            <CrappUIImage src="./image/logo.png" resize="AUTO_WIDTH" height="13" />
            <CrappUIText text="AUTO_WIDTH" />

            <CrappUIImage src="./image/logo.png" resize="STRETCH" width="25" height="30" />
            <CrappUIText text="STRETCH" />

            <CrappUIImage src="./image/logo.png" resize="FILL" width="60" height="60" />
            <CrappUIText text="FILL" />

            <CrappUIImage src="./image/logo.png" resize="FIT" width="60" height="60" />
            <CrappUIText text="FIT" />

            <CrappUIImage src="./image/logo.png" resize="REAL" />
            <CrappUIText text="REAL" />

            <CrappUIImage src="./image/logo.png" resize="REAL" effect="GRAYSCALE" />
            <CrappUIText text="GRAYSCALE" />

        </CrappUILayout>
    </view>
</priori>
')
class SceneImage extends CrappUIScene<Nothing>{
    
    override function setup() {
        super.setup();

    }

}