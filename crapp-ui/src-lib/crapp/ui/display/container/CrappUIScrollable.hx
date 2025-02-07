package crapp.ui.display.container;

import crapp.ui.composite.builtin.ScrollerComposite;
import crapp.ui.display.layout.CrappUILayout;

class CrappUIScrollable extends CrappUILayout {
    
    override function setup() {
        super.setup();

        this.composite.add(ScrollerComposite);
    }
}