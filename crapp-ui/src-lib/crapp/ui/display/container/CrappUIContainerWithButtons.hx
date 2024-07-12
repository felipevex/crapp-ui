package crapp.ui.display.container;

import tricks.layout.LayoutSize;
import crapp.ui.style.CrappUIStyle;
import priori.fontawesome.FontAwesomeIconType;
import crapp.ui.display.button.CrappUIButtonIcon;

class CrappUIContainerWithButtons extends CrappUIDisplay {
    
    private var controlButtons:Array<CrappUIButtonIcon>;

    public var headerHeight(default, set):Float = 40;

    public function new() {
        this.controlButtons = [];

        super();

        this.hLayoutSize = LayoutSize.FIT;
    }

    private function set_headerHeight(value:Float):Float {
        this.headerHeight = value;
        this.updateDisplay();
        return value;
    }

    public function addControlButton(label:String, icon:FontAwesomeIconType, color:Int, action:()->Void):Void {
        var button:CrappUIButtonIcon = new CrappUIButtonIcon(icon);
        button.tooltip = label;
        button.iconColor = color;
        button.width = 30;
        button.height = 20;
        button.actions.onClick = action;

        this.controlButtons.push(button);
        this.addChild(button);

        this.updateDisplay();
    }

    override function paint() {
        var style:CrappUIStyle = this.style;
        var lastX:Float = this.width - style.space;
        
        for (button in this.controlButtons) {
            button.width = 30;
            button.height = 20;
            button.maxX = lastX;
            button.centerY = this.headerHeight/2;

            lastX = button.x - style.space;
        }
    }

}