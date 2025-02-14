package crapp.ui.display.frame;

import priori.event.PriEvent;
import priori.view.PriFrame;


class CrappUIFrame extends CrappUIDisplay {

    public var src(get, set):String;
    
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


    inline private function set_src(value:String):String return this.frame.url = value;
	inline private function get_src():String return this.frame.url;

    inline private function reDispatch(e:PriEvent):Void this.dispatchEvent(new PriEvent(e.type));

}