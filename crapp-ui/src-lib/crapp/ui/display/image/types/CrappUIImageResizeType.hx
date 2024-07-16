package crapp.ui.display.image.types;

enum abstract CrappUIImageResizeType(String) to String {

    var AUTO_HEIGHT;
    var AUTO_WIDTH;
    var STRETCH;
    var FILL;
    var FIT;
    var REAL;

    @:from
    public static function fromString(value:String):CrappUIImageResizeType {
        if (value == null) return AUTO_HEIGHT;
        
        switch (value.toLowerCase()) {
            case "stretch" | "fixed": return STRETCH;
            case "fill" | "zoom": return FILL;
            case "fit" | "letterbox": return FIT;
            case "auto_height" | "height" | "auto" | "default" : return AUTO_HEIGHT;
            case "auto_width" | "width": return AUTO_WIDTH;
            case "real" | "original": return REAL;
            case _ : return AUTO_HEIGHT;
        }
    }

}