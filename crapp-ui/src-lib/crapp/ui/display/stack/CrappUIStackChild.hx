package crapp.ui.display.stack;

class CrappUIStackChild<T> extends CrappUIDisplay {
    
    @:isVar public var data(default, set):T;
    
    public var index:Int;

    public function new(index:Int) {
        this.index = index;
        
        super();
    }

    private function set_data(value:T):T {
        if (value == null) return value;

        this.data = value;
        this.updateData();
        this.updateDisplay();

        return value;   
    }

    public function updateData():Void {
        
    }

}