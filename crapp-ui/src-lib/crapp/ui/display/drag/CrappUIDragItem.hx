package crapp.ui.display.drag;

import crapp.ui.display.layout.CrappUILayout;

class CrappUIDragItem extends CrappUILayout {
    
    @:isVar public var dragAnchor(get, set):CrappUIDisplay;

    private function get_dragAnchor():CrappUIDisplay {
        if (this.dragAnchor == null) return this;
        else return this.dragAnchor;
    }

    private function set_dragAnchor(value:CrappUIDisplay):CrappUIDisplay return this.dragAnchor = value;

}