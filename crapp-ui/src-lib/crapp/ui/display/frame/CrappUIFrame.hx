package crapp.ui.display.frame;

import js.html.Window;
import priori.event.PriEvent;
import priori.view.PriFrame;

@:access(priori.view.PriFrame)
@priori('
<priori>
    <view />
</priori>
')
class CrappUIFrame extends CrappUIDisplay {

    public var src(get, set):String;
    public var window(get, null):Window;
    
    private var frame:PriFrame;
    
    override function setup() {
        super.setup();

        this.frame = new PriFrame();
        this.frame.addEventListener(PriEvent.COMPLETE, this.reDispatch);
        this.frame.addEventListener(PriEvent.ERROR, this.reDispatch);

        this.addChildList([
            this.frame
        ]);
    }

    override function paint() {
        super.paint();

        this.frame.width = this.width;
        this.frame.height = this.height;
    }

    inline private function get_window():Window return this.frame._iframe.contentWindow;

    inline private function set_src(value:String):String return this.frame.url = value;
	inline private function get_src():String return this.frame.url;

    inline private function reDispatch(e:PriEvent):Void this.dispatchEvent(new PriEvent(e.type));

}