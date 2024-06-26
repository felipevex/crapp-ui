package crapp.ui.resource;

typedef CrappUIActionsResource = {
    @:optional var onClick:()->Void;
    @:optional var onSubmit:()->Void;
    @:optional var onChange:()->Void;
    @:optional var onDelayedChange:()->Void;
    @:optional var onFocusIn:()->Void;
    @:optional var onFocusOut:()->Void;
}
