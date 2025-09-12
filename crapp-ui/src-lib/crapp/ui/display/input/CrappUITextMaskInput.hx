package crapp.ui.display.input;

/**
   A classe `CrappUITextMaskInput` tem como finalidade gerenciar a entrada de texto com máscara no componente de UI.
   #### Responsabilidades:
   - **Gerenciar Entrada de Texto com Máscara**: controla e valida a entrada de dados utilizando máscaras através da biblioteca IMask e herda funcionalidades de `CrappUITextInput`.
   - **Aplicação de Máscaras**: permite definir padrões de máscara para formatação automática da entrada (ex: CPF, telefone, data).
   - **Valores Mascarados e Não-Mascarados**: fornece acesso tanto ao valor formatado com máscara quanto ao valor limpo sem formatação.
   #### Eventos Emitidos:
   - **PriEvent.CHANGE**: emitido quando o valor da entrada é alterado (herdado de `CrappUITextInput`).
   - **PriEvent.RESIZE**: emitido quando há alteração no tamanho do componente após a renderização (herdado de `CrappUITextInput`).
   #### Ações Acionadas:
   - **actions.onSubmit**: acionada quando a tecla `ENTER` é pressionada (herdado de `CrappUITextInput`).
   - **actions.onChange**: acionada quando ocorre uma alteração instantânea no valor (herdado de `CrappUITextInput`).
   - **actions.onDelayedChange**: acionada após um atraso na alteração do valor, permitindo validações automáticas (herdado de `CrappUITextInput`).
**/
class CrappUITextMaskInput extends CrappUITextInput {

    private var maskController:IMask;
    private var maskOptions:Dynamic;

    /**
     * Propriedade pública que retorna o valor limpo sem a formatação da máscara.
     * @return String - o valor do campo sem a formatação da máscara
     */
    public var valueUnmasked(get, never):String;

    /**
       Propriedade pública que retorna o valor formatado com a máscara aplicada.
       @return String - o valor do campo com a formatação da máscara
    **/
    public var valueMasked(get, never):String;

    /**
       Propriedade pública que define o padrão da máscara a ser aplicada no campo de entrada.
       Utiliza a sintaxe da biblioteca IMask para definição de máscaras do tipo Pattern Mask.

       #### Definições de Caracteres:
       - **0** - qualquer dígito
       - **a** - qualquer letra
       - **\*** - qualquer caractere
       - **[]** - torna a entrada opcional
       - **{}** - inclui parte fixa no valor não mascarado
       - **`** - previne que símbolos sejam movidos para trás
       - **outros caracteres** - são considerados fixos na máscara
       - **\\\\** - escape para tratar caracteres de definição como fixos (Ex: \\\\0 trata o "0" como caractere fixo)

       #### Exemplos de Uso:
       ```haxe
       // CPF
       mask = "000.000.000-00";

       // Telefone com DDD
       mask = "(00) 00000-0000";

       // CEP
       mask = "00000-000";

       // Data
       mask = "00/00/0000";

       // Placa de carro (formato antigo)
       mask = "aaa-0000";

       // Placa de carro (formato Mercosul)
       mask = "aaa0a00";

       // Exemplo complexo com partes opcionais
       mask = "{#}000[aaa]/NIC-`*[**]";
       ```

       @see https://imask.js.org/guide.html#pattern - documentação oficial do IMask.js
    **/
    @:isVar public var mask(default, set):String = '';

    /**
       Método sobrescrito para configuração inicial do componente.
       Inicializa o controlador de máscara IMask e configura as opções padrão.
    **/
    override function setup() {
        super.setup();

        var element = @:privateAccess(PriFormInputText) this.input._baseElement[0];

        this.maskOptions = { mask : '' }
        this.maskController = new IMask(element, this.maskOptions);
    }

    /**
       Setter privado para a propriedade `mask`.
       Atualiza o padrão da máscara e aplica as novas configurações ao controlador.
       @param value - o novo padrão de máscara a ser aplicado
       @return String - o valor definido
    **/
    private function set_mask(value:String):String {
        if (value == null) return value;

        this.mask = value;
        this.maskOptions = {
            mask : value
        }

        this.updateMaskController();
        return value;
    }

    /**
       Método privado responsável por atualizar as configurações do controlador de máscara.
       Aplica as novas opções definidas em `maskOptions` ao `maskController`.
    **/
    private function updateMaskController():Void {
        this.maskController.updateOptions(this.maskOptions);
    }

    private function get_valueUnmasked():String return this.maskController.unmaskedValue;

    /**
       Getter privado para a propriedade `valueMasked`.
       @return String - o valor formatado com a máscara aplicada
    **/
    private function get_valueMasked():String return this.maskController.value;

    /**
       Getter sobrescrito que retorna o valor limpo com formatação da máscara.
       @return String - o valor com a formatação da máscara
    **/
    override private function get_value():String return this.valueMasked;

    /**
       Setter sobrescrito para definir o valor do campo.
       Aplica o valor e atualiza o controlador de máscara para manter a sincronização.
       @param value - o novo valor a ser definido
       @return String - o valor definido
    **/
	override private function set_value(value:String):String {
        var result = super.set_value(value);
        this.maskController.updateValue();
        this.maskController.updateControl(null);
        return result;
	}

}

/**
   Classe externa que representa a biblioteca IMask para controle de máscaras em campos de entrada.
   Fornece funcionalidades para aplicação, atualização e controle de máscaras em elementos HTML.
**/
@:native("IMask")
private extern class IMask {

    /**
       Propriedade que retorna o valor formatado com a máscara aplicada.
    **/
    public var value:String;

    /**
       Propriedade que retorna o valor limpo sem a formatação da máscara.
    **/
    public var unmaskedValue:String;

    /**
       Construtor da classe IMask.
       @param element - elemento HTML onde a máscara será aplicada
       @param maskOptions - opções de configuração da máscara
    **/
    public function new(element:Dynamic, maskOptions:Dynamic);

    /**
       Atualiza o valor do campo mantendo a máscara aplicada.
    **/
    public function updateValue():Void;

    /**
       Atualiza as opções de configuração da máscara.
       @param maskOptions - novas opções de configuração
    **/
    public function updateOptions(maskOptions:Dynamic):Void;

    /**
       Atualiza o controle da máscara e posição do cursor.
       @param cursorPos - posição do cursor (pode ser null)
    **/
    public function updateControl(cursorPos:Dynamic):Void;
}