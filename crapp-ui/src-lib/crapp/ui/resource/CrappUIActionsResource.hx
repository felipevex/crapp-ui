package crapp.ui.resource;

typedef CrappUIActionsResource = {
    @:optional var onClick:()->Void;
    @:optional var onSubmit:()->Void;
    @:optional var onChange:()->Void;
    @:optional var onDelayedChange:()->Void;
    @:optional var onFocusIn:()->Void;
    @:optional var onFocusOut:()->Void;
    @:optional var onLoad:()->Void;
    @:optional var onError:()->Void;
    @:optional var onResize:()->Void;
    @:optional var onDragEnter:()->Void;
    @:optional var onDragLeave:()->Void;
    @:optional var onClose:()->Void;
    @:optional var onOpen:()->Void;

    @:optional var delay:Int;
}
