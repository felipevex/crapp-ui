package crapp.ui.display;

import crapp.ui.style.data.CrappUIStyleData;
import crapp.ui.style.CrappUIStyleManager;
import priori.app.PriApp;
import priori.event.PriEvent;
import priori.style.shadow.PriShadowStyle;
import priori.style.border.PriBorderStyle;
import priori.view.builder.PriBuilder;
import tricks.layout.LayoutElement;
import tricks.layout.LayoutAlignment;
import tricks.layout.LayoutDistribution;
import tricks.layout.LayoutSize;
import crapp.ui.resource.CrappUIActionsResource;
import crapp.ui.style.CrappUIEvents;
import crapp.ui.style.CrappUIStyle;
import crapp.ui.style.CrappUISizeReference;
import crapp.ui.composite.CrappUICompositeManager;
import crapp.ui.interfaces.ICrappUIStyleObject;

class CrappUIDisplay extends PriBuilder implements ICrappUIStyleObject {
    
    @:noCompletion 
    private var _z:Float = 0;
    public var z(get, set):Float;

    private var styleManager:CrappUIStyleManager;

    public var theme(get, set):String;
    public var tag(get, set):String;
    public var variant(get, set):String;
    public var style(get, set):CrappUIStyleData;
    // public var parentStyle(get, null):CrappUIStyle;

    /**
     * indica que o elemento tem um constraint horizontal para valores de left e right
     */
    public var hasHorizontalConstraint(get, null):Bool;
    
    /**
      * indica que o elemento tem um constraint vertical para valores de top e bottom
      */
    public var hasVerticalConstraint(get, null):Bool;

    @:isVar public var actions(get, null):CrappUIActionsResource;

    public var layout(get, set):LayoutElement<CrappUIDisplay>;
    @:isVar public var vLayoutSize(default, set):LayoutSize = LayoutSize.FIXED;
    @:isVar public var hLayoutSize(default, set):LayoutSize = LayoutSize.FIXED;
    @:isVar public var hLayoutDistribution(default, set):LayoutDistribution = LayoutDistribution.NONE;
    @:isVar public var vLayoutDistribution(default, set):LayoutDistribution = LayoutDistribution.NONE;
    @:isVar public var hLayoutAlignment(default, set):LayoutAlignment = LayoutAlignment.NONE;
    @:isVar public var vLayoutAlignment(default, set):LayoutAlignment = LayoutAlignment.NONE;
    @:isVar public var hLayoutGap(default, set):Float = 0.0;
    @:isVar public var vLayoutGap(default, set):Float = 0.0;
    
    public var composite:CrappUICompositeManager;

    public function new() {
        this.composite = new CrappUICompositeManager(this);
        this.styleManager = new CrappUIStyleManager();
        
        super();

        this.styleManager.start(this);
    }

    @:noCompletion
    override private function ___onResize(e:PriEvent):Void {
        super.___onResize(e);
        if (this.parent != null) this.parent.dispatchEvent(new CrappUIEvent(CrappUIEvent.UPDATE_DISPLAY));
    }

    public function isPortraitDisplay():Bool {
        if (PriApp.g().width >= PriApp.g().height) return false;
        return true;
    }

    public function isLandscapeDisplay():Bool {
        return !this.isPortraitDisplay();
    }

    private function get_z():Float return this._z;
    private function set_z(value:Float):Float {
        var val:Float = value;
        
        if (value == null || value < 0.1) val = 0;
        else val = value;

        if (val == this.z) return value;
        else this._z = val;

        this.dh.styles.set("z-index", Std.string(this.dh.depth + Math.floor(this._z)));
        if (this.dh.elementBorder != null) this.dh.elementBorder.style.zIndex = Std.string(this.dh.depth + Math.floor(this._z));
        
        if (val > 0) {
            // hard shadow
            var keyLight:PriShadowStyle = new PriShadowStyle()
                .setVerticalOffset(0.2 + val * 0.9)
                .setBlur(0.2 + val * 0.8 + (val*val) * 0.04)
                .setOpacity((val + 14 + val * 0.4 - (val*val*0.05)) / 100)
                .setSpread(0.3 - val * 0.1);

            // soft shadow
            var ambientLight:PriShadowStyle = new PriShadowStyle()
                .setVerticalOffset(0)
                .setBlur(val * 2)
                .setOpacity((val + 5 + val * 0.11 - (val*val*0.03)) / 100)
                .setSpread(0);

            this.shadow = [keyLight, ambientLight];
        } else {
            this.shadow = null;
        }

        return value;
    }

    private function get_actions():CrappUIActionsResource {
        if (this.actions == null) this.actions = {};
        return this.actions;
    }

    private function propagateCrappUIEvent(event:CrappUIEvents):Void {
        var event:PriEvent = new PriEvent(event, true, false);
        this.dispatchEvent(event);
    }

    // function get_parentStyle():CrappUIStyle return this.styleManager.getParentStyle();
    function get_style():CrappUIStyleData return this.styleManager.getStyle();
	function set_style(value:CrappUIStyleData):CrappUIStyleData return this.styleManager.setStyle(value);
    
    function get_theme():String return this.styleManager.getTheme();
    function set_theme(value:String):String return this.styleManager.setTheme(value);
    function get_tag():String return this.styleManager.getTag();
    function set_tag(value:String):String return this.styleManager.setTag(value);
    function get_variant():String return this.styleManager.getVariant();
    function set_variant(value:String):String return this.styleManager.setVariant(value);
    
    override public function addChildList(childList:Array<Dynamic>):Void {
        super.addChildList(childList);
        this.updateDisplay();
    }

    override public function removeChildList(childList:Array<Dynamic>):Void {
        super.removeChildList(childList);
        this.updateDisplay();
    }

    override function set_disabled(value:Bool):Bool {
        this.mouseEnabled = !value;
        return super.set_disabled(value);
    }

    function get_layout():LayoutElement<CrappUIDisplay> {
		var layout:LayoutElement<CrappUIDisplay> = {
            ref : this,

            x : this.x,
            y : this.y,
            width : this.width,
            height : this.height,

            children : [],
            isContainer : false
        }

        layout.horizontal = {
            gap : this.hLayoutGap,
            size : this.hLayoutSize,
            alignment : this.hLayoutAlignment,
            distribution : this.hLayoutDistribution
        }
        
        layout.vertical = {
            gap : this.vLayoutGap,
            size : this.vLayoutSize,
            alignment : this.vLayoutAlignment,
            distribution : this.vLayoutDistribution
        }

        return layout;
	}

    function set_layout(value:LayoutElement<CrappUIDisplay>):LayoutElement<CrappUIDisplay> {
        if (!this.hasHorizontalConstraint) this.x = value.x;
        if (!this.hasVerticalConstraint) this.y = value.y;

        if (!this.hasHorizontalConstraint) this.width = value.width;
        if (!this.hasVerticalConstraint) this.height = value.height;
        
        return value;
    }

    function get_hasHorizontalConstraint():Bool {
        if (this.left != null || this.right != null) return true;
        return false;
	}

	function get_hasVerticalConstraint():Bool {
        if (this.top != null || this.bottom != null) return true;
        return false;
	}

	function set_hLayoutSize(value:LayoutSize):LayoutSize {
		this.hLayoutSize = value;
        this.updateDisplay();
        return value;
	}

	function set_vLayoutSize(value:LayoutSize):LayoutSize {
		this.vLayoutSize = value;
        this.updateDisplay();
        return value;
	}

	function set_hLayoutDistribution(value:LayoutDistribution):LayoutDistribution {
		this.hLayoutDistribution = value;
        this.updateDisplay();
        return value;
	}

	function set_vLayoutDistribution(value:LayoutDistribution):LayoutDistribution {
		this.vLayoutDistribution = value;
        this.updateDisplay();
        return value;
	}

	function set_hLayoutAlignment(value:LayoutAlignment):LayoutAlignment {
		this.hLayoutAlignment = value;
        this.updateDisplay();
        return value;
	}

	function set_vLayoutAlignment(value:LayoutAlignment):LayoutAlignment {
		this.vLayoutAlignment = value;
        this.updateDisplay();
        return value;
	}

    function set_hLayoutGap(value:Float):Float {
        this.hLayoutGap = value;
        this.updateDisplay();
        return value;
    }

    function set_vLayoutGap(value:Float):Float {
        this.vLayoutGap = value;
        this.updateDisplay();
        return value;
    }

    inline private function paintBackground(style:CrappUIStyle):Void {
        this.bgColor = style.color.color;
    }

    inline private function paintBorder(style:CrappUIStyle):Void {
        this.border = new PriBorderStyle(2, style.onColor.color.mix(style.color.color, 0.5));
    }

    inline private function paintCorners(style:CrappUIStyle, size:CrappUISizeReference):Void {
        this.corners = [Math.round(style.corners * size.toFloat())];
    }

    override function kill() {
        this.composite.reset();
        for (c in this.composite) c.kill();

        this.actions = null;

        super.kill();
    }
}