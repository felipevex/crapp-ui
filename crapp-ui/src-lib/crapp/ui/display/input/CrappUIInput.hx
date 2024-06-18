package crapp.ui.display.input;

class CrappUIInput<T> extends CrappUIStylableDisplay {
    
    public var value(get, set):T;
	
	private function get_value():T throw new haxe.exceptions.NotImplementedException();
	private function set_value(value:T):T throw new haxe.exceptions.NotImplementedException();
	
}