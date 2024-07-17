package crapp.ui.display.modal.dialog;

import crapp.ui.display.button.CrappUIButton;
import tricks.layout.LayoutSize;
import tricks.layout.LayoutDistribution;
import helper.kits.StringKit;
import crapp.ui.style.CrappUISizeReference;
import crapp.ui.display.modal.dialog.data.CrappUIDialogData;
import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import tricks.layout.LayoutAlignment;
import crapp.ui.style.CrappUIStyle;
import crapp.ui.display.text.CrappUIText;

@priori('
<priori>
    <imports>
        <crapp.ui.display.button.CrappUIButton />
        <crapp.ui.display.layout.CrappUILayotable />
    </imports>
    <view>
        <private:CrappUILayotable id="container" vLayoutGap="10" vLayoutDistribution="SIDE" >
            
            <private:CrappUILayotable id="textContainer" hLayoutSize="FLEX" vLayoutDistribution="SIDE" vLayoutSize="FIT" >
                <!-- TEXTS -->
            </private:CrappUILayotable>

            <private:CrappUILayotable hLayoutSize="FLEX" vLayoutSize="FLEX" >
            </private:CrappUILayotable>

            <private:CrappUILayotable id="buttonContainer" hLayoutSize="FLEX" hLayoutGap="10" hLayoutAlignment="MAX" vLayoutAlignment="CENTER" hLayoutDistribution="SIDE" vLayoutSize="FIT" >
                <!-- BUTTONS -->
            </private:CrappUILayotable>

        </private:CrappUILayotable>
    </view>
</priori>
')
class CrappUIDialog extends CrappUIModal {
    
    private var data:CrappUIDialogData;

    private var title:CrappUIText;
    private var text:CrappUIText;

    private function new(data:CrappUIDialogData) {
        this.data = data;

        super();

        this.tag = CrappUIStyleDefaultTagType.DIALOG;

        this.allowCloseModal = false;
        this.allowCloseModalWithEsc = false;
    }

    override function setup() {
        super.setup();

        if (!StringKit.isEmpty(this.data.title)) {
            this.title = new CrappUIText();
            this.title.hLayoutSize = LayoutSize.FLEX;
            this.title.uiSize = CrappUISizeReference.EXTRA;
            this.title.selectable = true;
            this.title.tag = null;
            this.title.autoSize = false;
            this.title.text = this.data.title;
        }

        this.text = new CrappUIText();
        this.text.hLayoutSize = LayoutSize.FLEX;
        this.text.selectable = true;
        this.text.tag = null;
        this.text.autoSize = false;
        this.text.multiLine = true;
        this.text.text = this.data.message;
        
        this.textContainer.addChildList([
            this.title,
            this.text
        ]);

        this.createButtons();
    }

    private function createButtons():Void {
        if (this.data.buttons == null) return;

        var buttons:Array<CrappUIButton> = [];

        for (item in this.data.buttons) {
            var button:CrappUIButton = new CrappUIButton();
            if (!StringKit.isEmpty(item.variant)) button.variant = item.variant;
            button.label = item.label;
            button.actions.onClick = () -> {
                this.close();
                if (item.action != null) item.action();
            }

            buttons.push(button);
        }

        this.buttonContainer.addChildList(buttons);
    }

    override function paint() {
        super.paint();

        var style:CrappUIStyle = CrappUIStyle.fromData(this.style);
        var space:Float = style.space * 1.3;

        this.bgColor = style.color;

        this.textContainer.vLayoutGap = style.space;

        this.container.left = space;
        this.container.right = space;
        this.container.top = space;
        this.container.bottom = space;

        var maxWidth:Float = 400;
        var minHeight:Float = 130;

        this.corners = style.getCornersArray(0.8);

        this.z = 3;
        this.width = Math.min(maxWidth, style.size * 25);

        this.text.width = this.width - style.space * 2;

        this.height = Math.max(
            minHeight, 
            this.textContainer.height + this.buttonContainer.height + space * 2 + style.space * 3 + 5
        );
    }

    static public function openMessage(message:String, ?title:String):CrappUIDialog {
        var dialog:CrappUIDialog = null;
        
        dialog = new CrappUIDialog({
            message: message,
            title: title,
            buttons: [{
                label: 'FECHAR'
            }]
        });

        dialog.open();

        return dialog;
    }

    static public function openDialog(data:CrappUIDialogData):CrappUIDialog {
        var dialog = new CrappUIDialog(data);
        dialog.open();

        return dialog;
    }

}