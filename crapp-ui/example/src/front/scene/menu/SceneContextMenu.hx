package front.scene.menu;

import util.kit.nothing.Nothing;
import crapp.ui.style.theme.CrappUIThemeProvider;
import crapp.ui.style.data.CrappUIThemeData;
import crapp.ui.display.menu.CrappUIContextMenu;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.button.CrappUIButtonIcon />
        <crapp.ui.display.layout.CrappUILayout />
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
class SceneContextMenu extends CrappUIScene<Nothing> {
    
    override function setup() {
        super.setup();

        var RED_THEME:CrappUIThemeData = {
            theme: "RED_THEME",
            tags: [
                {
                    tag : "RED",
                    on_color: 0xF42400
                }
            ]
        };

        CrappUIThemeProvider.get().setTheme(RED_THEME);
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
        var menu:CrappUIContextMenu = new CrappUIContextMenu();
        menu.theme = "RED_THEME";
        menu.addMenu('Color Red', ()-> {this.bgColor = 0xff0000;});
        menu.addMenu('Color Green', ()-> {this.bgColor = 0x00ff00;});
        menu.addMenu('Color Blue', ()-> {this.bgColor = 0x0000ff;});
        menu.addMenu('Reset', ()-> {this.bgColor = 0xffffff;}, 'RED');

        menu.openAt(ref);
    }

    private function openFastMenu(ref):Void {
        CrappUIContextMenu.open(ref, [
            {label: 'FAST - Color Red', action: ()-> {this.bgColor = 0xff0000;}},
            {label: 'FAST - Color Green', action: ()-> {this.bgColor = 0x00ff00;}},
            {label: 'FAST - Color Blue', action: ()-> {this.bgColor = 0x0000ff;}},
            {label: 'FAST - Reset', action: ()-> {this.bgColor = 0xffffff;}, tag : "RED"}
        ]).theme = "RED_THEME";
    }

}