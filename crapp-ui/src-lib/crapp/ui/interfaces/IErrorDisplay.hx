package crapp.ui.interfaces;

interface IErrorDisplay extends ICrappUIStyleObject {

    public function displayError(error:String):Void;
    public function clearError():Void;
    
}