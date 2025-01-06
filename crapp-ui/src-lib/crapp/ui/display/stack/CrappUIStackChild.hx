package crapp.ui.display.stack;

class CrappUIStackChild<T> extends CrappUIDisplay {
    
    @:isVar public var data(default, set):T;

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