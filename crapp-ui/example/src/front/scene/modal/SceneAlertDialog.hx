package front.scene.modal;

import crapp.ui.display.modal.dialog.CrappUIAlertDialog;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.button.CrappUIButton />
        <crapp.ui.display.layout.CrappUILayotable />
    </imports>
    <view>
        <CrappUILayotable vLayoutAlignment="CENTER" hLayoutAlignment="CENTER" hLayoutDistribution="SIDE" left="0" right="0" top="0" bottom="0" >
            <private:CrappUIButton id="dialogAlert" label="Open Alert" />
        </CrappUILayotable>
    </view>
</priori>
')
class SceneAlertDialog extends CrappUIScene {
    

    override function setup() {
        super.setup();

        
        this.dialogAlert.actions.onClick = CrappUIAlertDialog.show.bind('Hello World');
    }
}