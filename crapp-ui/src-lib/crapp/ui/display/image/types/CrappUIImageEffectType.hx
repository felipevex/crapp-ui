package crapp.ui.display.image.types;

enum abstract CrappUIImageEffectType(String) to String {
    
    var NONE;
    var GRAYSCALE;

    @:from
    public static function fromString(value:String):CrappUIImageEffectType {
        if (value == null) return NONE;

        switch (value.toLowerCase()) {
            case "grayscale" | "bw": return GRAYSCALE;
            case "none" | "default" : return NONE;
            case _ : return NONE;
        }
    }
}