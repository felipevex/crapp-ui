package crapp.ui.resource;

typedef CrappUIActionsResource = {
    @:optional var onClick:()->Void;
    @:optional var onSubmit:()->Void;
    @:optional var onChange:()->Void;
    @:optional var onDelayedChange:()->Void;
}
