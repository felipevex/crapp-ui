package crapp.ui.style.types;

import priori.style.font.PriFontStyleAlign;

enum abstract CrappUIStyleFontAlignType(String) {
    
    var LEFT = "LEFT";
    var CENTER = "CENTER";
    var RIGHT = "RIGHT";

    inline public function toString():String return this;

    @:from
    private static function fromString(value:String):CrappUIStyleFontAlignType {
        if (value == null) return CrappUIStyleFontAlignType.LEFT;

        return switch (value.toLowerCase()) {
            case 'left' | 'l': return LEFT;
            case 'center' | 'c': return CENTER;
            case 'right' | 'r': return RIGHT;
            case _: return LEFT;
        }
    }

    @:from
    private static function fromPriFontStyleAlign(value:PriFontStyleAlign):CrappUIStyleFontAlignType {
        if (value == null) return null;

        return switch (value) {
            case PriFontStyleAlign.LEFT: return LEFT;
            case PriFontStyleAlign.CENTER: return CENTER;
            case PriFontStyleAlign.RIGHT: return RIGHT;
            case _: return LEFT;
        }
    }

    @:to
    private function toPriFontStyleAlign():PriFontStyleAlign {
        if (this == null) return null;
        
        return switch (this.toLowerCase()) {
            case 'center': return PriFontStyleAlign.CENTER;
            case 'right': return PriFontStyleAlign.RIGHT;
            case 'left': return PriFontStyleAlign.LEFT;
            case _: return PriFontStyleAlign.LEFT;
        }
    }
}