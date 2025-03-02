package crapp.ui.form.rules;

import helper.kits.StringKit;

enum abstract CrappUIFormRules(String) {

    var REQUIRED;
    var IS_EMAIL;
    
    @:to
    private function toValidator<T>():(value:T)->Void {
        return switch (cast this) {
            
            case REQUIRED : (value:T) -> {
                if (value == null || StringKit.trim(Std.string(value)).length == 0) throw 'Campo obrigatório';
            }

            case IS_EMAIL : (value:T) -> {
                if (value != null && !StringKit.isEmail(Std.string(value))) throw 'Email inválido';
            }

        }
    }
}