package front.scene.menu;

import crapp.ui.style.data.CrappUIStyleData;
import crapp.ui.style.CrappUIStyle;
import crapp.ui.display.menu.CrappUIContextMenu;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.button.CrappUIButtonIcon />
        <crapp.ui.display.layout.CrappUILayotable />
    </imports>
    <view>
        <private:CrappUIButtonIcon id="b1" centerX:Paint="this.width/2" centerY:Paint="this.height/2" />
        <private:CrappUIButtonIcon id="b2" x="20" y="20" />
        <private:CrappUIButtonIcon id="b3" maxX:Paint="this.width - 20" maxY:Paint="this.height - 20" />
        <private:CrappUIButtonIcon id="b4" maxX:Paint="this.width - 20" y="20" />
        <private:CrappUIButtonIcon id="b5" x="20" maxY:Paint="this.height - 20" />
    </view>
</priori>
')
class SceneContextMenu extends CrappUIScene {
    
    override function setup() {
        super.setup();
    }

    override function paint() {
        super.paint();

        b1.actions.onClick = openFastMenu.bind(b1);
        b2.actions.onClick = openContextMenu.bind(b2);
        b3.actions.onClick = openContextMenu.bind(b3);
        b4.actions.onClick = openContextMenu.bind(b4);
        b5.actions.onClick = openContextMenu.bind(b5);
    }

    private function openContextMenu(ref):Void {
        var style:CrappUIStyleData = {
            on_color: 0xFF0000
        }
        
        var menu:CrappUIContextMenu = new CrappUIContextMenu();
        menu.addMenu('Color Red', ()-> {this.bgColor = 0xff0000;});
        menu.addMenu('Color Green', ()-> {this.bgColor = 0x00ff00;});
        menu.addMenu('Color Blue', ()-> {this.bgColor = 0x0000ff;});
        menu.addMenu('Reset', ()-> {this.bgColor = 0xffffff;}, style);

        menu.openAt(ref);
    }

    private function openFastMenu(ref):Void {
        var style:CrappUIStyleData = {
            on_color: 0xFF0000
        }

        CrappUIContextMenu.open(ref, [
            {label: 'FAST - Color Red', action: ()-> {this.bgColor = 0xff0000;}},
            {label: 'FAST - Color Green', action: ()-> {this.bgColor = 0x00ff00;}},
            {label: 'FAST - Color Blue', action: ()-> {this.bgColor = 0x0000ff;}},
            {label: 'FAST - Reset', action: ()-> {this.bgColor = 0xffffff;}, style : style}
        ]);
    }

}