package crapp.ui.style.types;

import priori.style.font.PriFontStyleWeight;

enum abstract CrappUIStyleFontWeightType(String) {

    var LIGHTER;
    var LIGHT;
    var NORMAL;
    var BOLD;
    var BOLDER;

    @:to
    public function toPriWheight():PriFontStyleWeight {
        if (this == null) return null;

        return switch (this.toLowerCase()) {
            case 'lighter': return PriFontStyleWeight.THICK100;
            case 'light': return PriFontStyleWeight.THICK300;
            case 'normal': return PriFontStyleWeight.THICK400;
            case 'bold': return PriFontStyleWeight.THICK700;
            case 'bolder': return PriFontStyleWeight.THICK900;
            
            case _: return PriFontStyleWeight.THICK400;
        }
    }

    @:from
    public static function fromPriWheight(value:PriFontStyleWeight):CrappUIStyleFontWeightType {
        if (value == null) return null;
        
        return switch (value) {
            case PriFontStyleWeight.LIGHTER | PriFontStyleWeight.THICK100: return CrappUIStyleFontWeightType.LIGHTER;
            case PriFontStyleWeight.THICK200 | PriFontStyleWeight.THICK300: return CrappUIStyleFontWeightType.LIGHT;
            case PriFontStyleWeight.NORMAL | PriFontStyleWeight.THICK400 | PriFontStyleWeight.THICK500: return CrappUIStyleFontWeightType.NORMAL;
            case PriFontStyleWeight.BOLD | PriFontStyleWeight.THICK600 | PriFontStyleWeight.THICK700: return CrappUIStyleFontWeightType.BOLD;
            case PriFontStyleWeight.BOLDER | PriFontStyleWeight.THICK800 | PriFontStyleWeight.THICK900: return CrappUIStyleFontWeightType.BOLDER;
        }
    }
    
    @:from
    public static function fromString(value:String):CrappUIStyleFontWeightType {
        if (value == null) return CrappUIStyleFontWeightType.NORMAL;

        return switch (value.toLowerCase()) {
            case 'lighter' | 'lr': return CrappUIStyleFontWeightType.LIGHTER;
            case 'light' | 'l': return CrappUIStyleFontWeightType.LIGHT;
            case 'normal' | 'n' | 'regular': return CrappUIStyleFontWeightType.NORMAL;
            case 'bold' | 'b': return CrappUIStyleFontWeightType.BOLD;
            case 'bolder' | 'br': return CrappUIStyleFontWeightType.BOLDER;

            case _: return CrappUIStyleFontWeightType.NORMAL;
        }
    }
}