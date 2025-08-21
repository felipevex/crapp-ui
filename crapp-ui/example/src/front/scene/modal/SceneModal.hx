package front.scene.modal;

import crapp.ui.display.modal.CrappUIModal;
import util.kit.nothing.Nothing;
import crapp.ui.display.app.CrappUIScene;
import crapp.ui.style.types.CrappUIStyleDefaultTagType;


@priori('
<priori>
    <imports>
        <crapp.ui.display.button.CrappUIButton />
        <crapp.ui.display.layout.CrappUILayout />
    </imports>
    <view>
        <CrappUILayout vLayoutAlignment="CENTER" hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" left="0" right="0" top="0" bottom="0" >
            <private:CrappUIButton id="btMessage" label="Open My Modal" />
        </CrappUILayout>
    </view>
</priori>
')
class SceneModal extends CrappUIScene<Nothing> {


    override function setup() {
        super.setup();

        this.btMessage.actions.onClick = this.openModal;

    }

    private function openModal():Void {
        var modal:MyModal = new MyModal();
        modal.open();
    }

}

@priori('
<priori>
    <imports>
        <crapp.ui.display.button.CrappUIButton />
        <crapp.ui.display.layout.CrappUILayout />
    </imports>
    <view tag:L="CrappUIStyleDefaultTagType.DIALOG" width="300" height="300" bgColor="#FF0000" vLayoutAlignment="CENTER" hLayoutAlignment="CENTER" >
        <private:CrappUIButton id="button" label="My Modal Button" />
    </view>
</priori>
')
class MyModal extends CrappUIModal {

    public function new() {
        super();

        this.button.actions.onClick = () -> {
            trace('Button clicked in MyModal');
            this.close();
        };
    }

    override public function onOpenModal() {
        trace('MyModal opened');
    }

}