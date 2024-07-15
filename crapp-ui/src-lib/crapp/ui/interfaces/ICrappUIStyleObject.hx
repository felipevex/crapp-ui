package crapp.ui.interfaces;

import crapp.ui.style.CrappUIStyleManager;
import crapp.ui.style.data.CrappUIStyleData;
import crapp.ui.style.CrappUIEvents;
import priori.view.PriDisplay;

interface ICrappUIStyleObject {

    private var styleManager:CrappUIStyleManager;
    
    public var style(get, set):CrappUIStyleData;
    public var theme(get, set):String;
    public var tag(get, set):String;
    public var variant(get, set):String;
    
    public var parent(get, null):PriDisplay;
    
    public function addEventListener(event:String, listener:Dynamic->Void):Void;
    private function propagateCrappUIEvent(event:CrappUIEvents):Void;

    public function updateDisplay():Void;
}