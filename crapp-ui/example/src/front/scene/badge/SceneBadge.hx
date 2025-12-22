package front.scene.badge;

import crapp.ui.style.data.CrappUIStyleData;
import crapp.ui.style.CrappUIStyle;
import crapp.ui.display.badge.CrappUIBadge;
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

            <CrappUILayout hLayoutDistribution="SIDE" hLayoutGap="20" vLayoutSize="FIT" hLayoutSize="FIT" >
                <CrappUIBadge label="BADGE 1" />
                <CrappUIBadge label="BADGE 2" />
                <CrappUIBadge label="BADGE 3" />
                <CrappUIBadge label="BADGE 4" />
                <CrappUIBadge label="BADGE 5" />
                <CrappUIBadge label="BADGE 6" />
                <CrappUIBadge label="BADGE 7" />
                <CrappUIBadge label="BADGE 8" />
                <CrappUIBadge label="BADGE 9" />
            </CrappUILayout>

            <CrappUILayout hLayoutDistribution="SIDE" hLayoutGap="20" vLayoutSize="FIT" hLayoutSize="FIT" >
                <CrappUIBadge label="BADGE 1" color="0x4a5565"/>
                <CrappUIBadge label="BADGE 2" color="0xc10007"/>
                <CrappUIBadge label="BADGE 3" color="0x894b00"/>
                <CrappUIBadge label="BADGE 4" color="0x008236"/>
                <CrappUIBadge label="BADGE 5" color="0x1447e6"/>
                <CrappUIBadge label="BADGE 6" color="0x432dd7"/>
                <CrappUIBadge label="BADGE 7" color="0x8200db"/>
                <CrappUIBadge label="BADGE 8" color="0xc6005c"/>
                <CrappUIBadge label="BADGE 9" color="0x000000"/>
            </CrappUILayout>

            <CrappUILayout hLayoutDistribution="SIDE" hLayoutGap="20" vLayoutSize="FIT" hLayoutSize="FIT" >
                <CrappUIBadge label="BADGE 1" color="0x4a5565" style:L="{prevent_border:true}"/>
                <CrappUIBadge label="BADGE 2" color="0xc10007" style:L="{prevent_border:true}"/>
                <CrappUIBadge label="BADGE 3" color="0x894b00" style:L="{prevent_border:true}"/>
                <CrappUIBadge label="BADGE 4" color="0x008236" style:L="{prevent_border:true}"/>
                <CrappUIBadge label="BADGE 5" color="0x1447e6" style:L="{prevent_border:true}"/>
                <CrappUIBadge label="BADGE 6" color="0x432dd7" style:L="{prevent_border:true}"/>
                <CrappUIBadge label="BADGE 7" color="0x8200db" style:L="{prevent_border:true}"/>
                <CrappUIBadge label="BADGE 8" color="0xc6005c" style:L="{prevent_border:true}"/>
                <CrappUIBadge label="BADGE 9" color="0x000000" style:L="{prevent_border:true}"/>
            </CrappUILayout>

            <CrappUILayout hLayoutDistribution="SIDE" hLayoutGap="20" vLayoutSize="FIT" hLayoutSize="FIT" >
                <CrappUIBadge label="BADGE 1" color="0x4a5565" showCloseButton=":true"/>
                <CrappUIBadge label="BADGE 2" color="0xc10007" showCloseButton=":true"/>
                <CrappUIBadge label="BADGE 3" color="0x894b00" showCloseButton=":true"/>
                <CrappUIBadge label="BADGE 4" color="0x008236" showCloseButton=":true"/>
                <CrappUIBadge label="BADGE 5" color="0x1447e6" showCloseButton=":true"/>
                <CrappUIBadge label="BADGE 6" color="0x432dd7" showCloseButton=":true"/>
                <CrappUIBadge label="BADGE 7" color="0x8200db" showCloseButton=":true"/>
                <CrappUIBadge label="BADGE 8" color="0xc6005c" showCloseButton=":true"/>
                <CrappUIBadge label="BADGE 9" color="0x000000" showCloseButton=":true"/>
            </CrappUILayout>

            <CrappUILayout hLayoutDistribution="SIDE" hLayoutGap="20" vLayoutSize="FIT" hLayoutSize="FIT" >
                <CrappUIBadge label="BADGE 1" color="0x4a5565" style:L="{prevent_border:true}" showCloseButton=":true"/>
                <CrappUIBadge label="BADGE 2" color="0xc10007" style:L="{prevent_border:true}" showCloseButton=":true"/>
                <CrappUIBadge label="BADGE 3" color="0x894b00" style:L="{prevent_border:true}" showCloseButton=":true"/>
                <CrappUIBadge label="BADGE 4" color="0x008236" style:L="{prevent_border:true}" showCloseButton=":true"/>
                <CrappUIBadge label="BADGE 5" color="0x1447e6" style:L="{prevent_border:true}" showCloseButton=":true"/>
                <CrappUIBadge label="BADGE 6" color="0x432dd7" style:L="{prevent_border:true}" showCloseButton=":true"/>
                <CrappUIBadge label="BADGE 7" color="0x8200db" style:L="{prevent_border:true}" showCloseButton=":true"/>
                <CrappUIBadge label="BADGE 8" color="0xc6005c" style:L="{prevent_border:true}" showCloseButton=":true"/>
                <CrappUIBadge label="BADGE 9" color="0x000000" style:L="{prevent_border:true}" showCloseButton=":true"/>
            </CrappUILayout>



        </private:CrappUILayout>
    </view>
</priori>
')
class SceneBadge extends CrappUIScene<Nothing> {

    override function setup() {
        super.setup();


    }



}