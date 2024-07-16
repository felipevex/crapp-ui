package crapp.ui.display.line.types;

enum abstract CrappUILineStyleType(String) {
    
    var SOLID;
    var DASHED;
    var DOTTED;

    @:to
    public function toString():String return Std.string(this).toLowerCase();

    @:from
    public static function fromString(value:String):CrappUILineStyleType {
        if (value == null) return SOLID;

        switch (value.toLowerCase()) {
            case "solid": return SOLID;
            case "dashed": return DASHED;
            case "dotted": return DOTTED;
            default: return SOLID;
        }
    }
    
}