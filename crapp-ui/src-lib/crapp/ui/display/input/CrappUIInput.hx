package crapp.ui.display.input;

import crapp.ui.style.CrappUISizeReference;
import crapp.ui.composite.builtin.DisabledEffectComposite;
import priori.types.PriTransitionType;
import crapp.ui.display.text.CrappUITextIcon;
import helper.kits.StringKit;

/**
A classe `CrappUIInput` tem como finalidade gerenciar a entrada de dados, permitindo a validação dos valores atribuídos e a exibição de mensagens de erro quando necessário.
#### Responsabilidades:
- Gerenciar o fluxo de validação de entrada de dados e exibir mensagens de erro, integrando componentes visuais da `CrappUIDisplay`.
#### Eventos Emitidos:
- Nenhum evento explícito definido.
**/
@priori('
<priori>
    <view />
</priori>
')
class CrappUIInput<T> extends CrappUIDisplay {

    /**
    Valor atual da entrada.
    @default (valor não definido)
    **/
    public var value(get, set):T;

    /**
    Indica se a validação automática está habilitada.
    @default true
    **/
    public var autoValidation:Bool = true;

    /**
       Variável pública que define o rótulo exibido no campo de entrada.
       @default "LABEL"
    **/
    @:isVar public var label(default, set):String = "LABEL";

    private var validatorsErrorMessage:String;
    private var validators:Array<(value:T)->Void>;
    private var displayError:CrappUITextIcon;

    public function new() {
        this.validators = [];
        this.validatorsErrorMessage = '';
        super();
    }

    function set_label(value:String):String {
        if (value == null) return value;
        this.label = StringKit.removeBreaks(value);
        return value;
	}

    private function calculateNormalHeight():Float {
        var styleSize:Float = this.style.size;
        var styleSpace:Float = this.style.space;
        var baseSize:Float = styleSize * 1.485;
        var size:Float = baseSize + styleSpace * 2.5 + baseSize * CrappUISizeReference.SMALL;

        return size;
    }

    override function setup() {
        this.composite.add(DisabledEffectComposite);
        super.setup();
    }

    override function paint() {
        this.composite.get(DisabledEffectComposite).updateDisplay();
        super.paint();
    }

    private function createErrorMessage():Void {
        if (this.displayError != null) return;
        this.displayError = new CrappUITextIcon();
        this.displayError.visible = false;
        this.displayError.right = 0;
        this.displayError.top = 0;
        this.displayError.variant = "ERROR";
        this.displayError.icon = EXCLAMATION_TRIANGLE;
        this.addChild(this.displayError);
    }

    private function get_value():T throw new haxe.exceptions.NotImplementedException();
    private function set_value(value:T):T throw new haxe.exceptions.NotImplementedException();

    /**
    Adiciona um validador para a entrada.
    @param validator A função que realiza a validação do valor.
    **/
    public function addValidation(validator:(value:T)->Void):Void {
        this.validators.push(validator);
    }

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

    /**
    Valida o valor da entrada e exibe uma mensagem de erro se a validação falhar.
    **/
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

    /**
    Verifica se a entrada contém algum erro de validação.
    @returns true se houver erro, false caso contrário.
    **/
    public function hasError():Bool {
        try {
            this.validate();
            return false;
        } catch (e:String) {
            return true;
        }
    }

    /**
    Retorna a mensagem de erro resultante da última validação.
    @returns A mensagem de erro.
    **/
    public function getErrorMessage():String {
        return this.validatorsErrorMessage;
    }
}