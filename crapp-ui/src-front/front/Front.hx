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
        <route scene="front.scene.button.SceneButton" route="button" />
        <route scene="front.scene.input.SceneInputText" route="input/text" />
        <route scene="front.scene.style.SceneStyle" route="style" />
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