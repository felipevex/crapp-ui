package crapp.ui.form;

import crapp.ui.display.modal.dialog.CrappUIDialog;
import crapp.ui.form.rules.CrappUIFormRules;
import crapp.ui.display.input.CrappUIInput;

/**
    Esta classe gerencia formulários e suas validações dentro do framework CrappUI.

    #### Responsabilidades:
    - **Gerenciamento de campos**: Mantém uma coleção de campos de entrada (`CrappUIInput`) e suas regras de validação.
    - **Validação de formulário**: Executa validações em todos os campos e regras personalizadas.
    - **Tratamento de erros**: Coleta e exibe mensagens de erro quando necessário.
    - **Feedback para usuário**: Pode mostrar diálogos com mensagens de erro.

    #### Exemplos de uso:
    ```haxe
    // Criando um formulário básico com título personalizado
    var form = new CrappUIForm("Formulário de Cadastro");

    // Adicionar campos de entrada ao formulário com regras de validação
    var nomeInput = new CrappUITextInput();
    nomeInput.label = "Nome";

    var emailInput = new CrappUITextInput();
    emailInput.label = "Email";

    form.addFieldRule(nomeInput, REQUIRED);
    form.addFieldRule(emailInput, REQUIRED);
    form.addFieldRule(emailInput, IS_EMAIL);

    // Verificar se há erros no formulário e exibi-los em uma caixa de diálogo
    if (form.hasErrors(true)) {
        // Formulário tem erros, exibidos em diálogo
        return;
    }

    // Processar o formulário válido...
    // (Seu codigo de processamento aqui)
    ```
**/
class CrappUIForm {

    private var fields:Array<CrappUIInput<Dynamic>>;
    private var validators:Array<()->Void>;

    /**
    Título do formulário usado para exibição em mensagens de erro.

    @default 'Form'
    **/
    public var title:String = 'Form';

    /**
    Cria uma nova instância de `CrappUIForm`.

    @param title Título opcional para o formulário
    **/
    public function new(?title:String) {
        if (this.title != null) this.title = title;

        this.fields = [];
        this.validators = [];
    }

    /**
    Adiciona uma regra de validação a um campo do formulário. Se o campo ainda não estiver
    registrado no formulário, ele será adicionado automaticamente.

    @param field O campo de entrada a ser validado
    @param rule A regra de validação a ser aplicada ao campo
    **/
    public function addFieldRule<T>(field:CrappUIInput<T>, rule:CrappUIFormRules):Void {
        if (this.fields.indexOf(field) == -1) this.fields.push(field);

        field.addValidation(rule);
    }

    public function addFieldValidation<T>(field:CrappUIInput<T>, rule:(value:T)->Void):Void {
        if (this.fields.indexOf(field) == -1) this.fields.push(field);
        field.addValidation(rule);
    }

    /**
    Adiciona uma função de validação personalizada ao formulário. Esta função deve lançar uma exceção
    quando a validação falhar, e a mensagem da exceção será exibida como erro.

    @param validator Função que executa validação personalizada
    **/
    public function addValidationRule(validator:()->Void):Void {
        this.validators.push(validator);
    }

    /**
    Verifica se o formulário contém erros de validação e, opcionalmente,
    exibe uma caixa de diálogo com as mensagens de erro.

    @param showError Se verdadeiro, exibe um diálogo com as mensagens de erro
    @return Verdadeiro se há erros, falso caso contrário
    **/
    public function hasErrors(showError:Bool = false):Bool {
        var hasError:Bool = false;

        var errors = this.getErrors();

        if (errors.length > 0) {
            hasError = true;

            if (showError) {
                var message:String = '';

                for (error in errors) {
                    if (error.field != null) message += '- ' + error.field + ': ' + error.message + '\n';
                    else message += '- ' + error.message + '\n';
                }

                CrappUIDialog.openMessage(message, this.title).actions.onClose = () -> {
                    for (field in this.fields) {
                        if (field.hasError()) {
                            field.setFocus();
                            break;
                        }
                    }
                };
            }
        }

        return hasError;
    }

    /**
    Coleta todos os erros de validação dos campos e validadores do formulário.
    Executa a validação em todos os campos e tenta executar todos os validadores personalizados.

    @return Um array de objetos de erro contendo campo (opcional) e mensagem
    **/
    public function getErrors():Array<{?field:String, message:String}> {
        var errors:Array<{field:String, message:String}> = [];

        for (field in this.fields) {
            field.validateAndDisplayError();
            if (field.hasError()) errors.push({field: field.label, message: field.getErrorMessage()});
        }

        for (validator in this.validators) {
            try {
                validator();
            } catch (e:Dynamic) {
                errors.push({field: null, message: Std.string(e)});
            }
        }

        return errors;
    }


}