package crapp.ui.display.image;

import priori.style.filter.PriFilterStyle;
import priori.event.PriEvent;
import priori.view.PriImage;
import crapp.ui.display.CrappUIDisplay;
import crapp.ui.display.image.types.CrappUIImageEffectType;
import crapp.ui.display.image.types.CrappUIImageResizeType;

@priori('
<priori>
    <view />
</priori>
')
class CrappUIImage extends CrappUIDisplay {
    
    public var resize(default, set):CrappUIImageResizeType = AUTO_HEIGHT;
    public var effect(default, set):CrappUIImageEffectType = NONE;

    public var src(default, set):String;
    
    private var image:PriImage;

    override function setup() {
        super.setup();
        this.bgColor = 0xf3f3f3;
    }

    override function paint() {
        super.paint();
        this.updateSize();
    }

    private function set_resize(value:CrappUIImageResizeType):CrappUIImageResizeType {
        if (value == null || value == this.resize) return value;

        this.resize = value;
        this.updateSize();
        return value;
    }

    private function set_effect(value:CrappUIImageEffectType):CrappUIImageEffectType {
        if (value == null || value == this.effect) return value;

        this.effect = value;
        this.updateEffect();

        return value;
    }

    private function set_src(value:String):String {
        if (value == null || value == this.src) return value;

        this.src = value;

        if (this.image != null) {
            this.image.removeFromParent();
            this.image.kill();
        }

        this.image = new PriImage();
        this.image.clipping = false;
        this.image.addEventListener(PriEvent.COMPLETE, this.onComplete);
        this.image.addEventListener(PriEvent.ERROR, this.onError);
        this.image.loadURL(value);

        return value;
    }

    private function onError(e:PriEvent):Void {
        this.image.removeFromParent();
        this.image.kill();
        
        if (this.actions.onError != null) this.actions.onError();
    }

    private function onComplete(e:PriEvent):Void {
        this.addChild(this.image);
        this.updateSize();
        this.updateEffect();

        if (this.actions.onLoad != null) this.actions.onLoad();
    }

    private function updateSize():Void {
        if (this.image == null) return;

        this.bgColor = null;

        switch (this.resize) {
            case AUTO_HEIGHT : {
                this.image.resizeToWidth(this.width);
                this.height = this.image.height;
            }
            case AUTO_WIDTH : {
                this.image.resizeToHeight(this.height);
                this.width = this.image.width;
            }
            case STRETCH : {
                this.image.width = this.width;
                this.image.height = this.height;
            }
            case FILL: this.image.resizeToZoom(this.width, this.height);
            case FIT: this.image.resizeToLetterBox(this.width, this.height);
            case REAL: {
                this.image.imageScaleX = 1;
                this.image.imageScaleY = 1;
                this.width = this.image.width;
                this.height = this.image.height;
            }

            case _ : {}
        }

        this.image.centerX = this.width / 2;
        this.image.centerY = this.height / 2;
    }

    private function updateEffect():Void {
        if (this.image == null) return;

        var filter:PriFilterStyle = new PriFilterStyle();

        switch (this.effect) {
            case NONE: filter = null;
            case GRAYSCALE: filter.grayscale = 1;
        }

        this.image.filter = filter;
    }

}