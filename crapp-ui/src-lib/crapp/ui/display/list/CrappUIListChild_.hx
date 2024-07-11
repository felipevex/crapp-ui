package crapp.ui.display.list;

import crapp.ui.display.layout.CrappUILayotable;

class CrappUIListChild<T> extends CrappUILayotable {

    @:isVar public var data(default, set):T;
    public var index:Int;
    
    public function new() {
        this.index = 0;
        super();
    }

    private function updateData():Void {
        throw "Not implemented";
    }

    private function set_data(value:T):T {
        if (value == this.data) return value;

        this.data = value;
        this.updateData();
        this.updateDisplay();

        return value;
    }
}
