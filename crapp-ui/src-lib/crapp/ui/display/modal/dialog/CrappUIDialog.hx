package crapp.ui.display.modal.dialog;

import crapp.ui.display.button.CrappUIButton;
import tricks.layout.LayoutSize;
import helper.kits.StringKit;
import crapp.ui.style.CrappUISizeReference;
import crapp.ui.display.modal.dialog.data.CrappUIDialogData;
import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import crapp.ui.style.CrappUIStyle;
import crapp.ui.display.text.CrappUIText;

/**
 * Esta classe é responsável por criar um modal de diálogo para apresentação de mensagens,
 * com um título opcional e botões que podem executar ações definidas pelo usuário.
 *
 * Exemplo de uso:
 * ```
 * // Diálogo simples com mensagem e título opcional:
 * CrappUIDialog.openMessage("Mensagem de Exemplo", "Título Opcional");
 *
 * // Diálogo customizado com botões e ações:
 * CrappUIDialog.openDialog({
 *     message: "Deseja prosseguir?",
 *     title: "Confirmação",
 *     buttons: [
 *         { label: "SIM", action: () -> { trace("ação para confirmar"); } },
 *         { label: "NÃO", action: () -> { trace("ação para cancelar"); } }
 *     ]
 * });
 * }
 * ```
 */
@priori('
<priori>
    <imports>
        <crapp.ui.display.button.CrappUIButton />
        <crapp.ui.display.layout.CrappUILayout />
    </imports>
    <view tag:L="CrappUIStyleDefaultTagType.DIALOG" allowCloseModal=":false" allowCloseModalWithEsc=":false" >
        <private:CrappUILayout id="container" vLayoutGap="10" vLayoutDistribution="SIDE" >
            
            <private:CrappUILayout id="textContainer" hLayoutSize="FLEX" vLayoutDistribution="SIDE" vLayoutSize="FIT" >
                <!-- TEXTS -->
            </private:CrappUILayout>

            <private:CrappUILayout hLayoutSize="FLEX" vLayoutSize="FLEX" >
            </private:CrappUILayout>

            <private:CrappUILayout id="buttonContainer" hLayoutSize="FLEX" hLayoutGap="10" hLayoutAlignment="MAX" vLayoutAlignment="CENTER" hLayoutDistribution="SIDE" vLayoutSize="FIT" >
                <!-- BUTTONS -->
            </private:CrappUILayout>

        </private:CrappUILayout>
    </view>
</priori>
')
class CrappUIDialog extends CrappUIModal {
    
    private var data:CrappUIDialogData;

    private var title:CrappUIText;
    private var text:CrappUIText;
    
    private function new(data:CrappUIDialogData) {
        this.data = data;
        super();
    }

    /**
     * Inicializa o diálogo configurando seus elementos principais: 
     * - Se um título for definido, é criado um componente de texto para o título.
     * - Cria o corpo do diálogo com a mensagem passada.
     * - Adiciona os componentes ao container de texto e cria os botões se estes estiverem definidos.
     */
    override function setup() {
        super.setup();

        if (!StringKit.isEmpty(this.data.title)) {
            this.title = new CrappUIText();
            this.title.hLayoutSize = LayoutSize.FLEX;
            this.title.size = CrappUISizeReference.EXTRA;
            this.title.selectable = true;
            this.title.tag = null;
            this.title.autoSize = false;
            this.title.text = this.data.title;
        }

        this.text = new CrappUIText();
        this.text.hLayoutSize = LayoutSize.FLEX;
        this.text.selectable = true;
        this.text.tag = null;
        this.text.autoSize = false;
        this.text.multiLine = true;
        this.text.text = this.data.message;
        
        this.textContainer.addChildList([
            this.title,
            this.text
        ]);

        this.createButtons();
    }

    private function createButtons():Void {
        if (this.data.buttons == null) return;

        var buttons:Array<CrappUIButton> = [];

        for (item in this.data.buttons) {
            var button:CrappUIButton = new CrappUIButton();
            if (!StringKit.isEmpty(item.variant)) button.variant = item.variant;
            button.label = item.label;
            button.actions.onClick = () -> {
                this.close();
                if (item.action != null) item.action();
            }

            buttons.push(button);
        }

        this.buttonContainer.addChildList(buttons);
    }

    /**
     * Método: paint
     *
     * Responsável por aplicar os estilos e ajustar o layout do diálogo, definindo:
     * - A cor de fundo do modal.
     * - Espaçamentos internos e entre os componentes.
     * - Largura máxima e altura mínima do diálogo.
     * - Configuração dos cantos arredondados do modal.
     */
    override function paint() {
        super.paint();

        var style:CrappUIStyle = CrappUIStyle.fromData(this.style);
        var space:Float = style.space * 1.3;

        this.bgColor = style.color;

        this.textContainer.vLayoutGap = style.space;

        this.container.left = space;
        this.container.right = space;
        this.container.top = space;
        this.container.bottom = space;

        var maxWidth:Float = 400;
        var minHeight:Float = 130;

        this.corners = style.getCornersArray(0.8);

        this.z = 3;
        this.width = Math.min(maxWidth, style.size * 25);

        this.text.width = this.width - style.space * 2;

        this.height = Math.max(
            minHeight, 
            this.textContainer.height + this.buttonContainer.height + space * 2 + style.space * 3 + 5
        );
    }

    /**
     * Método estático: openMessage
     *
     * Abre um diálogo simples contendo uma mensagem e, opcionalmente, um título. Internamente, 
     * cria uma instância de CrappUIDialog com um botão padrão ("FECHAR") e exibe o diálogo.
     *
     * @param message A mensagem a ser exibida no diálogo.
     * @param title   (Opcional) O título a ser exibido no diálogo.
     * @return A instância de CrappUIDialog que foi criada e aberta.
     */
    static public function openMessage(message:String, ?title:String):CrappUIDialog {
        var dialog:CrappUIDialog = null;
        
        dialog = new CrappUIDialog({
            message: message,
            title: title,
            buttons: [{
                label: 'FECHAR'
            }]
        });

        dialog.open();

        return dialog;
    }

    /**
     * Método estático: openDialog
     *
     * Abre um diálogo customizado, permitindo a utilização de botões com ações específicas conforme 
     * definido no objeto de dados fornecido.
     *
     * @param data Objeto contendo as configurações do diálogo. Deve incluir:
     *             - message: A mensagem a ser exibida.
     *             - title: (Opcional) O título do diálogo.
     *             - buttons: Um array de objetos onde cada objeto pode conter:
     *                        - label: Texto do botão.
     *                        - action: Função a ser executada ao clicar no botão.
     *                        - variant: (Opcional) Define o estilo variante do botão.
     * @return A instância de CrappUIDialog que foi criada e aberta.
     */
    static public function openDialog(data:CrappUIDialogData):CrappUIDialog {
        var dialog = new CrappUIDialog(data);
        dialog.open();

        return dialog;
    }

}