package front;

import priori.style.font.PriFontStyle;
import crapp.ui.display.app.CrappUIApp;

@priori('
<priori>
    <!--
    <includes>
        <image id="id" path="path" />
    </includes>
    -->
    <routes>
        <route scene="front.scene.home.SceneHome" route="**" />
        <route scene="front.scene.home.SceneHome" route="home" />
        <route scene="front.scene.text.SceneText" route="text" />
        <route scene="front.scene.button.SceneButton" route="button/button" />
        <route scene="front.scene.button.SceneButtonIcon" route="button/icon" />
        <route scene="front.scene.input.SceneInputText" route="input/text" />
        <route scene="front.scene.input.SceneInputSelect" route="input/select" />
        <route scene="front.scene.style.SceneStyle" route="style" />
        <route scene="front.scene.composite.SceneScrollerComposite" route="composite/scroller" />
        <route scene="front.scene.list.SceneList" route="list" />
        <route scene="front.scene.menu.SceneContextMenu" route="menu/context" />
    </routes>
</priori>
')
class Front extends CrappUIApp {
    
    static public function main() new Front();

    public function new() {
        super();
        
        PriFontStyle.DEFAULT_FAMILY = 'Saira, Open Sans';
    }
}