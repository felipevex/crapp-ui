package crapp.ui.display.button;

import crapp.ui.types.CrappUIHorizontalPositionType;
import crapp.ui.display.icon.types.CrappUIIconType;
import crapp.ui.style.CrappUISizeReference;
import crapp.ui.display.icon.CrappUIIcon;

/**
    A classe `CrappUIButtonIconText` representa um botão interativo que combina um ícone e um texto, permitindo a exibição de ambos de forma alinhada e estilizada na interface do usuário.
    #### Responsabilidades:
    - **Renderização de Botão com Ícone e Texto**: Gerencia a exibição visual de um botão que contém tanto um ícone quanto um rótulo textual, ajustando o layout conforme necessário.
    - **Controle de Rotação do Ícone**: Permite ativar ou desativar a rotação animada do ícone, útil para indicar carregamento ou outras ações visuais.
    - **Gerenciamento de Layout**: Ajusta automaticamente o tamanho e a posição do ícone e do rótulo conforme as propriedades do botão.
    #### Eventos Emitidos:
    - Nenhum evento definido
    #### Ações Acionadas:
    - **actions.onClick**: Acionada quando o botão é clicado pelo usuário.
**/
@priori('
<priori>
    <view />
</priori>
')
class CrappUIButtonIconText extends CrappUIButton {

    /**
        Define o ícone exibido no botão.
        @return O ícone atualmente exibido.
        @param value Novo ícone a ser exibido no botão.
    **/
    public var icon(get, set):CrappUIIconType;

    /**
        Define a velocidade de rotação do ícone, em graus por atualização.
        @default 0.5
    **/
    public var rotationSpeed:Float = 0.5;

    /**
        Indica se o ícone deve rotacionar automaticamente.
        @default false
    **/
    @:isVar public var rotateIcon(default, set):Bool = false;

    private var iconDisplay:CrappUIIcon;

    /**
        Define a posição horizontal do ícone em relação ao texto do botão.
        Pode ser LEFT (ícone à esquerda do texto) ou RIGHT (ícone à direita do texto).
        @default CrappUIHorizontalPositionType.LEFT
    **/
    @:isVar public var iconPosition(default, set):CrappUIHorizontalPositionType = CrappUIHorizontalPositionType.LEFT;

    private function set_rotateIcon(value:Bool):Bool {
        if (value == null) return value;

        this.rotateIcon = value;

        if (value) this.doRotateIcon();
        else this.iconDisplay.rotation = 0;

        return value;
    }

    private function set_iconPosition(value:CrappUIHorizontalPositionType):CrappUIHorizontalPositionType {
        this.iconPosition = value;
        this.updateDisplay();
        return value;
    }

    private function doRotateIcon():Void {
        if (this.isKilled()) return;
        else if (!this.rotateIcon) {
            this.iconDisplay.rotation = 0;
            return;
        }

        this.iconDisplay.rotation += this.rotationSpeed;
        haxe.Timer.delay(this.doRotateIcon, Math.round(40/1000));
    }

    override function setup() {
        super.setup();

        this.iconDisplay = new CrappUIIcon();
        this.iconDisplay.tag = null;
        this.iconDisplay.size = CrappUISizeReference.EXTRA;

        this.addChild(this.iconDisplay);
    }


    override private function paint_drawThisSize(autoSize:Bool, space:Float):Void {
        this.height = this.displayLabel.height + space * 2;

        if (autoSize) this.width = this.iconDisplay.width + this.displayLabel.width + space * 4.5;
    }

    override private function paint_drawLabelPosition(autoSize:Bool, space:Float):Void {
        this.iconDisplay.centerY = this.height / 2 + 1;
        this.displayLabel.centerY = this.height/2 + 1;

        switch (this.iconPosition) {
            case CrappUIHorizontalPositionType.LEFT: {
                this.iconDisplay.x = space * 1.25;
                this.displayLabel.x = this.iconDisplay.maxX + space * 1.5;
            }

            case CrappUIHorizontalPositionType.RIGHT: {
                this.displayLabel.x = space * 1.5;
                this.iconDisplay.maxX = this.width - space * 1.25;
            }
        }
    }

    override private function set_autoSize(value:Bool):Bool {
        this.autoSize = value;
        this.updateDisplay();
        return value;
    }

    private function get_icon():CrappUIIconType return this.iconDisplay.icon;
    private function set_icon(value:CrappUIIconType):CrappUIIconType {
        this.iconDisplay.icon = value;
        this.updateDisplay();
        return value;
    }

}