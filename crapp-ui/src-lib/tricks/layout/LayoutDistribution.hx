package tricks.layout;

enum abstract LayoutDistribution(String) from String to String {
    var NONE = 'NONE';
    var SIDE = 'SIDE';
    var JUSTIFY = 'JUSTIFY';
    // var SPACE_AROUND = 'SPACE_AROUND';
    // var SPACE_EVENLY = 'SPACE_EVENLY';
}