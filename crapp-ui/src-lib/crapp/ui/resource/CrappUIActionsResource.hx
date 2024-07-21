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
}
