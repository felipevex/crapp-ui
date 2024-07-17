package crapp.ui.display.modal.dialog.data;

typedef CrappUIDialogButtonData = {
    var label:String;

    @:optional var action:()->Void; // null actions close the dialog
    @:optional var variant:String;
}