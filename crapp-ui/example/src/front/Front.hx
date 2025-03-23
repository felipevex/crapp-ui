package front;

import front.route.FrontRoute;
import crapp.ui.fonts.CrappUIFonts;
import priori.font.PriFontProvider;
import crapp.ui.display.app.CrappUIApp;

@priori('
<priori>
    
</priori>
')
class Front extends CrappUIApp {
    
    static public function main() new Front();

    public function new() {
        super();
    }

    override function onLoad() {
        super.onLoad();

        FrontRoute.registerAllScenes();
        
        CrappUIFonts.loadSaira();
        PriFontProvider.get().load(this.init);
    }

}