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
            <private:CrappUIButton id="btLongMessage" label="Open Long Message" />
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
        
        this.btLongMessage.actions.onClick = CrappUIDialog.openMessage.bind("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi placerat felis eu est ultrices, at sagittis neque malesuada. Vivamus magna urna, ultricies suscipit massa nec, lobortis porta odio. Sed et euismod leo.", "Longa Mensagem");
    }
}