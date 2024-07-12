package crapp.ui.composite;

import crapp.ui.display.CrappUIDisplay;
import haxe.ds.StringMap;

class CrappUICompositeManager {
    
    private var map:StringMap<Int>;
    private var composites:Array<CrappUIComposite>;
    
    private var display:CrappUIDisplay;
    private var i:Int;

    public function new(display:CrappUIDisplay) {
        this.i = 0;

        this.display = display;

        this.map = new StringMap<Int>();
        this.composites = [];
    }

    public function reset():Void this.i = 0;
    
    public function hasNext():Bool return i < this.composites.length;
    public function next():CrappUIComposite return this.composites[i++];
    
    public function add(composite:Class<CrappUIComposite>):Void {
        var compositeClassName:String = Type.getClassName(composite);

        if (this.map.exists(compositeClassName)) return;

        var compositeInstance:CrappUIComposite = Type.createInstance(composite, []);
        compositeInstance.display = this.display;
        
        this.map.set(compositeClassName, this.composites.length);
        this.composites.push(compositeInstance);

        compositeInstance.setup();
    }

    public function get<T:Class<R>, R:CrappUIComposite>(composite:T):R {
        var compositeClassName:String = Type.getClassName(composite);
        return cast this.composites[this.map.get(compositeClassName)];
    }

}