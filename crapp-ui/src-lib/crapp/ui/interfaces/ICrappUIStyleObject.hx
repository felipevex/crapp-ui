package crapp.ui.interfaces;

import crapp.ui.style.CrappUIEvents;
import crapp.ui.style.CrappUIStyle;
import priori.view.PriDisplay;

interface ICrappUIStyleObject {
    
    public var style(get, set):CrappUIStyle;
    public var parent(get, null):PriDisplay;
    public var parentStyle(get, null):CrappUIStyle;

    public function addEventListener(event:String, listener:Dynamic->Void):Void;
    private function propagateCrappUIEvent(event:CrappUIEvents):Void;

    public function updateDisplay():Void;
}