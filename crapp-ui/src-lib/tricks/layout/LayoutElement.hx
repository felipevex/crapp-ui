package tricks.layout;

typedef LayoutElement<T> = {
    @:optional var ref:T;
    
    var x:Float;
    var y:Float;
    var width:Float;
    var height:Float;
    
    @:optional var isContainer:Bool;
    @:optional var children:Array<LayoutElement<T>>;
    // var padding:LayoutBox;
    // var box:LayoutBox;
    @:optional var horizontal:LayoutBehavior;
    @:optional var vertical:LayoutBehavior;
}