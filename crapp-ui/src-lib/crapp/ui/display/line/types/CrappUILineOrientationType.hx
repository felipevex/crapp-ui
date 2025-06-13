package crapp.ui.display.line.types;

enum abstract CrappUILineOrientationType(String) to String {

    var HORIZONTAL;
    var VERTICAL;

    @:from
    public static function fromString(value:String):CrappUILineOrientationType {
        if (value == null) return HORIZONTAL;

        switch (value.toLowerCase()) {
            case "horizontal" | "h": return HORIZONTAL;
            case "vertical" | "v" : return VERTICAL;
            case _ : return HORIZONTAL;
        }
    }
}