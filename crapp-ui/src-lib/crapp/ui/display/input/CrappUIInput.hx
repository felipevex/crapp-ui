package crapp.ui.display.input;

import priori.types.PriTransitionType;
import priori.fontawesome.FontAwesomeIconType;
import crapp.ui.display.text.CrappUITextIcon;
import helper.kits.StringKit;

class CrappUIInput<T> extends CrappUIDisplay {
    
    public var value(get, set):T;
	public var autoValidation:Bool = true;

	private var validatorsErrorMessage:String;
	private var validators:Array<(value:T)->Void>;
	private var displayError:CrappUITextIcon;

	public function new() {
		this.validators = [];
		this.validatorsErrorMessage = '';

		super();
	}

	private function createErrorMessage():Void {
		if (this.displayError != null) return;

		this.displayError = new CrappUITextIcon();
		this.displayError.visible = false;
		this.displayError.right = 0;
		this.displayError.top = 0;
		this.displayError.variant = "ERROR";
		this.displayError.icon = FontAwesomeIconType.EXCLAMATION_TRIANGLE;
		
		this.addChild(this.displayError);
	}
	
	private function get_value():T throw new haxe.exceptions.NotImplementedException();
	private function set_value(value:T):T throw new haxe.exceptions.NotImplementedException();

	public function addValidation(validator:(value:T)->Void):Void this.validators.push(validator);

	private function validate():Void {
        var value:T = this.value;

        for (validator in this.validators) {
            try {
                validator(value);
				this.validatorsErrorMessage = "";
            } catch (e:Dynamic) {
				this.validatorsErrorMessage = Std.string(e);

				if (!StringKit.isEmpty(this.validatorsErrorMessage)) {
					throw this.validatorsErrorMessage;
					break;
				}
            }
        }
    }

	public function validateAndDisplayError():Void {
		try {
			this.validate();
			if (this.displayError != null) this.displayError.visible = false;
		} catch (e:String) {
			this.createErrorMessage();
			this.displayError.text = this.getErrorMessage();

			if (!this.displayError.visible) {
				this.displayError.visible = true;

				this.displayError.allowTransition(PriTransitionType.Y, null);
				this.displayError.y = - this.displayError.height;
				
				haxe.Timer.delay(() -> {
					this.displayError.allowTransition(PriTransitionType.Y, 0.12);
					this.displayError.top = 0;
				}, 0);
				
			}
		}
	}

	public function hasError():Bool {
		try {
			this.validate();
			return false;
		} catch (e:String) {
			return true;
		}
	}

	public function getErrorMessage():String return this.validatorsErrorMessage;
}