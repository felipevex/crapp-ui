package crapp.ui.display.layout;

import tricks.layout.LayoutSize;
import priori.event.PriEvent;
import tricks.layout.Layout;
import tricks.layout.LayoutElement;

class CrappUILayotable extends CrappUIDisplay {

    private var invalid:Bool;

    public function new() {
        this.invalid = false;
        super();
    }
    
    override function get_layout():LayoutElement<CrappUIDisplay> {
        var layout = super.get_layout();
        layout.isContainer = true;

        for (i in 0 ... this.numChildren) {
            var child = this.getChild(i);
            if (!Std.isOfType(child, CrappUIDisplay)) continue;

            layout.children.push((cast(child, CrappUIDisplay)).layout);
        }
        
        if (layout.children.length == 0) {
            if (layout.horizontal.size == LayoutSize.FIT) {
                layout.horizontal.size = LayoutSize.FIXED;
                layout.width = 10;
            }
            if (layout.vertical.size == LayoutSize.FIT) {
                layout.vertical.size = LayoutSize.FIXED;
                layout.height = 10;
            }
        }

        return layout;
    }

    override function set_layout(value:LayoutElement<CrappUIDisplay>):LayoutElement<CrappUIDisplay> {
        this.invalid = true;

        var layout = super.set_layout(value);

        if (layout.children != null) for (i in 0 ... layout.children.length) {
            this.layout.children[i].ref.layout = layout.children[i];
        }
        
        this.invalid = false;
        return layout;
    }
    
    override function paint() {
        if (this.invalid) return;

        var layoutElement:LayoutElement<CrappUIDisplay> = this.layout;
        var layout:Layout = new Layout();
        layout.organize(layoutElement);

        this.layout = layoutElement;
    }

    override function addChildList(childList:Array<Dynamic>):Void {
        for (child in childList) child.addEventListener(PriEvent.RESIZE, this.onChildResize);
        super.addChildList(childList);
    }

    override function removeChildList(childList:Array<Dynamic>):Void {
        for (child in childList) child.removeEventListener(PriEvent.RESIZE, this.onChildResize);
        super.removeChildList(childList);
    }

    private function onChildResize(event:PriEvent):Void {
        if (this.invalid) return;

        this.updateDisplay();
    }
}