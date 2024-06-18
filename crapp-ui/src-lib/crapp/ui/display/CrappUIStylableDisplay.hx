package crapp.ui.display;

import crapp.ui.interfaces.ICrappUIStyleObject;
import crapp.ui.controller.CrappUIStyleController;
import crapp.ui.style.CrappUISizeReference;
import priori.style.border.PriBorderStyle;
import crapp.ui.resource.CrappUIActionsResource;
import tricks.layout.LayoutElement;
import tricks.layout.LayoutAlignment;
import tricks.layout.LayoutDistribution;
import tricks.layout.LayoutSize;
import crapp.ui.style.CrappUIStyle;

class CrappUIStylableDisplay extends CrappUIDisplay implements ICrappUIStyleObject {

    private var styleController:CrappUIStyleController;
    public var style(get, set):CrappUIStyle;
    public var parentStyle(get, null):CrappUIStyle;

    /**
     * indica que o elemento tem um constraint horizontal para valores de left e right
     */
    public var hasHorizontalConstraint(get, null):Bool;
    
    /**
      * indica que o elemento tem um constraint vertical para valores de top e bottom
      */
    public var hasVerticalConstraint(get, null):Bool;

    @:isVar public var actions(get, set):CrappUIActionsResource;

    public var layout(get, set):LayoutElement<CrappUIStylableDisplay>;
    @:isVar public var vLayoutSize(default, set):LayoutSize = LayoutSize.FIXED;
    @:isVar public var hLayoutSize(default, set):LayoutSize = LayoutSize.FIXED;
    @:isVar public var hLayoutDistribution(default, set):LayoutDistribution = LayoutDistribution.NONE;
    @:isVar public var vLayoutDistribution(default, set):LayoutDistribution = LayoutDistribution.NONE;
    @:isVar public var hLayoutAlignment(default, set):LayoutAlignment = LayoutAlignment.NONE;
    @:isVar public var vLayoutAlignment(default, set):LayoutAlignment = LayoutAlignment.NONE;
    @:isVar public var hLayoutGap(default, set):Float = 0.0;
    @:isVar public var vLayoutGap(default, set):Float = 0.0;
    
    public function new() {
        this.styleController = new CrappUIStyleController();
        
        super();

        this.styleController.start(this);
    }

    private function get_actions():CrappUIActionsResource {
        if (this.actions == null) this.actions = {};
        return this.actions;
    }
    
    private function set_actions(value:CrappUIActionsResource):CrappUIActionsResource {
        if (value == null) this.actions = {};
        else this.actions = value;
        return value;
    }

    function get_parentStyle():CrappUIStyle return this.styleController.getParentStyle();
    function get_style():CrappUIStyle return this.styleController.getStyle();
	function set_style(value:CrappUIStyle):CrappUIStyle return this.styleController.setStyle(value);

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

    function get_layout():LayoutElement<CrappUIStylableDisplay> {
		var layout:LayoutElement<CrappUIStylableDisplay> = {
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

    function set_layout(value:LayoutElement<CrappUIStylableDisplay>):LayoutElement<CrappUIStylableDisplay> {
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
        this.bgColor = style.background.color;
    }

    inline private function paintBorder(style:CrappUIStyle):Void {
        this.border = new PriBorderStyle(2, style.primary.color.mix(style.background.color, 0.5));
    }

    inline private function paintCorners(style:CrappUIStyle, size:CrappUISizeReference):Void {
        this.corners = [Math.round(style.corners * size.toFloat())];
    }
}