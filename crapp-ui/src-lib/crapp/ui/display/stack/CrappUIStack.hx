package crapp.ui.display.stack;

import priori.style.border.PriBorderStyle;
import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import crapp.ui.display.line.CrappUILine;
import crapp.ui.style.CrappUISizeReference;
import crapp.ui.style.CrappUIStyle;
import crapp.ui.display.layout.CrappUILayout;


@priori('
<priori>
    <imports>
        
    </imports>
    <view tag:L="CrappUIStyleDefaultTagType.STACK"
        vLayoutAlignment="MIN" 
        vLayoutDistribution="SIDE" 
        vLayoutGap="0" 
        vLayoutSize="FIT" 
        defaultChild:L="CrappUIStackChild"
    >
    </view>
</priori>
')
class CrappUIStack extends CrappUILayout {

    private var stackLength:Int = 0;

    @:isVar public var defaultChild(default, set):Class<CrappUIStackChild<Any>>;
    public var data(null, set):Array<Any>;
    
    private function set_defaultChild(value:Class<CrappUIStackChild<Any>>):Class<CrappUIStackChild<Any>> {
        if (value == null) return value;
        this.defaultChild = value;
        return value;
    }

    private function set_data(value:Array<Any>):Array<Any> {
        if (value == null) return value;
        this.clearStack();
        this.addStacks(value);
        return value;
    }

    override private function paint():Void {
        super.paint();
        this.updateStack();

        var style:CrappUIStyle = CrappUIStyle.fromData(this.style);
        
        this.paintBorder(style);
        this.paintCorners(style, CrappUISizeReference.SMALL);
    }

    override private function paintBorder(style:CrappUIStyle):Void {
        this.border = style.preventBorder
            ? null 
            : new PriBorderStyle(2, style.onColor.color);
    }

    private function updateStack():Void {

    }

    public function addStacks<T>(data:Array<T>, ?stackChildClass:Class<CrappUIStackChild<T>>):Void {
        for (data in data) this.addStackItem(
            data, 
            stackChildClass == null 
                ? cast this.defaultChild 
                : stackChildClass
        );
    }

    public function addStackItem<T>(data:T, stackChildClass:Class<CrappUIStackChild<T>>):Void {
        var display:CrappUIStackChild<T> = this.createStackChild(stackChildClass);
        display.data = data;

        this.stackLength ++;
        if (this.stackLength >= 2) this.addLine();

        this.addChildList([display]);
    }

    private function createStackChild<T>(stackChildClass:Class<CrappUIStackChild<T>>):CrappUIStackChild<T> {
        var display:CrappUIStackChild<T> = Type.createInstance(stackChildClass, []);
        display.left = 0;
        display.right = 0;
        return display;
    }

    private function addLine():Void {
        var line:CrappUILine = new CrappUILine();
        line.tag = null;
        line.orientation = HORIZONTAL;
        line.thickness = 2;
        line.left = 0;
        line.right = 0;

        this.addChildList([line]);
    }

    public function clearStack():Void {
        this.stackLength = 0;
        this.removeAllChildren();
    }
}