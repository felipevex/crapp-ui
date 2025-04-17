package front.scene.drag;

import crapp.ui.display.drag.CrappUIDragAlignHelper;
import helper.kits.NumberKit;
import crapp.ui.display.drag.CrappUIDragItem;
import crapp.ui.display.drag.CrappUIDrag;
import util.kit.nothing.Nothing;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.drag.CrappUIDrag />
    </imports>
    <view>
        <CrappUIDrag id="dragSpace" type="<DragItem>" left="200" right="200" bottom="100" bgColor="0xCCCCCC" top="100" />
    </view>
</priori>
')
class SceneDrag extends CrappUIScene<Nothing> {
    
    override function setup() {
        super.setup();

        this.dragSpace.dragAlign = CrappUIDragAlignHelper.rowDistribution.bind(20);

        this.dragSpace.addDragItem(new DragItem());
        this.dragSpace.addDragItem(new DragItem());
        this.dragSpace.addDragItem(new DragItem());
        this.dragSpace.addDragItem(new DragItem());
        this.dragSpace.addDragItem(new DragItem());

        // this.dragSpace.items --> retorna a lista de itens com a nova ordenação.
    }

}


class DragItem extends CrappUIDragItem {
    
    override function setup() {
        super.setup();

        this.height = 70 + Math.random() * 120;
        this.bgColor = NumberKit.getRandom(0xFFFFFF);
    }

    override function paint() {
        super.paint();

        
    }
}