package crapp.ui.display.list;

import crapp.ui.display.layout.CrappUILayout;

@priori('
<priori>
    <view />
</priori>
')
class CrappUIListChild<T> extends CrappUILayout {

    @:isVar public var data(default, set):T;

    public var list(get, never):CrappUIList<T>;
    public var index:Int;
    
    public function new() {
        this.index = 0;
        super();
    }

    private function get_list():CrappUIList<T> return this.parent == null ? null : cast this.parent;

    private function updateData():Void {
        
    }

    private function set_data(value:T):T {
        if (value == this.data) return value;

        this.data = value;
        this.updateData();
        this.updateDisplay();

        return value;
    }
}
