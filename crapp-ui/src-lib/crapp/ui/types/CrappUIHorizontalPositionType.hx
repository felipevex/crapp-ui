package crapp.ui.types;

enum abstract CrappUIHorizontalPositionType(String) to String {

    var LEFT;
    var RIGHT;

    @:from
    public static function fromString(value:String):CrappUIHorizontalPositionType {
        if (value == null) return LEFT;

        switch (value.toLowerCase()) {
            case "left" | "h": return LEFT;
            case "right" | "v" : return RIGHT;
            case _ : return LEFT;
        }
    }
}