package front.scene.composite;

import crapp.ui.composite.builtin.ScrollerComposite;
import crapp.ui.display.layout.CrappUILayotable;

class LayoutWithScroller extends CrappUILayotable {
    
    override function setup() {
        super.setup();

        this.composite.add(ScrollerComposite);
    }
}