package crapp.ui.display.modal.dialog;

import priori.style.font.PriFontStyleAlign;
import tricks.layout.LayoutAlignment;
import crapp.ui.style.CrappUIStyle;
import crapp.ui.display.container.CrappUISurface;
import crapp.ui.display.text.CrappUIText;

class CrappUIAlertDialog extends CrappUIModal {
    
    @:isVar public var message(default, set):String;

    private var surface:CrappUISurface;
    private var text:CrappUIText;

    override function setup() {
        super.setup();

        this.vLayoutAlignment = LayoutAlignment.CENTER;
        this.hLayoutAlignment = LayoutAlignment.CENTER;

        this.surface = new CrappUISurface();
        this.surface.tag = null;

        this.text = new CrappUIText();
        this.text.align = PriFontStyleAlign.CENTER;
        this.text.autoSize = false;
        this.text.multiLine = false;
        this.text.tag = null;
        this.text.text = 'message';

        this.addChildList([
            this.surface,
            this.text
        ]);
    }

    override function paint() {
        super.paint();

        var style:CrappUIStyle = CrappUIStyle.fromData(this.style);

        var maxWidth:Float = 400;
        var minHeihgt:Float = 200;

        this.corners = style.getCornersArray();

        this.z = 3;
        this.width = Math.min(maxWidth, style.size * 25);

        this.text.width = this.width - style.space * 2;

        this.height = Math.max(minHeihgt, this.text.height + style.space * 2);
        
        this.surface.width = this.width;
        this.surface.height = this.height;        
    }

    static public function show(message:String):Void {
        var dialog = new CrappUIAlertDialog();
        dialog.message = message;
        dialog.open();
    }

    private function set_message(value:String):String {
        if (value == null) return value;

        this.message = value;
        this.text.text = value;

        return value;
    }

}