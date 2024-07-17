package crapp.ui.display.modal.dialog.data;

typedef CrappUIDialogData = {
    var message:String;

    @:optional var title:String;
    @:optional var buttons:Array<CrappUIDialogButtonData>;
}