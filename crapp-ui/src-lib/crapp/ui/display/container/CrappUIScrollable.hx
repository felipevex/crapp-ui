package crapp.ui.display.container;

import crapp.ui.composite.builtin.ScrollerComposite;
import crapp.ui.display.layout.CrappUILayotable;

class CrappUIScrollable extends CrappUILayotable {
    
    override function setup() {
        super.setup();

        this.composite.add(ScrollerComposite);
    }
}