package crapp.ui.display.stack;

import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import crapp.ui.display.line.CrappUILine;
import crapp.ui.style.CrappUISizeReference;
import crapp.ui.style.CrappUIStyle;
import crapp.ui.display.layout.CrappUILayotable;

class CrappUIStack extends CrappUILayotable {

    private var stacks:Array<CrappUIDisplay>;

    private var defaultStackChildClass:Class<Dynamic>;

    public function new() {
        this.stacks = [];

        super();
        
        this.tag = CrappUIStyleDefaultTagType.STACK;
    }

    override private function setup():Void {
        super.setup();

        this.setDefaultStackChidlClass(CrappUIStackChild);

        this.vLayoutAlignment = MIN;
        this.vLayoutDistribution = SIDE;
        this.vLayoutGap = 0;
        this.vLayoutSize = FIT;
    }

    override private function paint():Void {
        super.paint();
        this.updateStack();

        var style:CrappUIStyle = CrappUIStyle.fromData(this.style);
        
        this.paintBackground(style);
        this.paintBorder(style);
        this.paintCorners(style, CrappUISizeReference.SMALL);

        this.bgColor = 0xFFFFFF;
    }

    private function updateStack():Void {

    }

    public function setDefaultStackChidlClass<T>(stackChildClass:Class<CrappUIStackChild<T>>):Void {
        this.defaultStackChildClass = stackChildClass;
    }

    public function addStacks<T>(data:Array<T>):Void {
        for (data in data) this.addStackItem(data, cast this.defaultStackChildClass);
    }

    public function addStackItem<T>(data:T, stackChildClass:Class<CrappUIStackChild<T>>):Void {
        var display:CrappUIStackChild<T> = Type.createInstance(stackChildClass, [this.stacks.length]);
        display.left = 0;
        display.right = 0;

        display.data = data;
        this.stacks.push(display);

        if (this.stacks.length >= 2) this.addLine();

        this.addChildList([display]);
    }

    private function addLine():Void {
        var style:CrappUIStyle = CrappUIStyle.fromData(this.style);
        var line:CrappUILine = new CrappUILine();

        line.tag = null;
        line.orientation = HORIZONTAL;
        line.thickness = 2;
        line.left = 0;
        line.right = 0;
        line.style = {
            on_color: style.onColor.color.mix(style.color.color, 0.5)
        }

        this.addChildList([line]);
    }

    public function clearStack():Void {
        this.stacks = [];
        this.removeAllChildren();
    }
}