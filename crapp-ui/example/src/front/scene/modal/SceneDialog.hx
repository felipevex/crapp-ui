package front.scene.modal;

import crapp.ui.display.modal.dialog.CrappUIDialog;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.button.CrappUIButton />
        <crapp.ui.display.layout.CrappUILayotable />
    </imports>
    <view>
        <CrappUILayotable vLayoutAlignment="CENTER" hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" left="0" right="0" top="0" bottom="0" >
            <private:CrappUIButton id="btMessage" label="Open Message" />
            <private:CrappUIButton id="btMessageWithTitle" label="Open Message with Title" />
        </CrappUILayotable>
    </view>
</priori>
')
class SceneDialog extends CrappUIScene {
    

    override function setup() {
        super.setup();
        
        this.btMessage.actions.onClick = CrappUIDialog.openMessage.bind('Hello World');

        this.btMessageWithTitle.actions.onClick = CrappUIDialog.openDialog.bind({
            message: 'Hello World',
            title: 'Title',
            buttons: [
                { label: 'CANCELAR', action: () -> { trace('Cancel'); } },
                { label: 'CONTINUAR', action: () -> { trace('OK'); } }
            ]
        });
    }
}