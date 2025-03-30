package crapp.ui.display.modal;

import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import crapp.ui.display.layout.CrappUILayout;
import priori.event.PriEvent;
import crapp.ui.controller.CrappUIModalController;
import priori.view.PriDisplay;

/**
 * Componente responsável por criar elementos modais ou overlays que se sobrepõem à
 * interface da aplicação. A classe gerencia a abertura e o fechamento dos modais,
 * integrando-se com o controlador CrappUIModalController.
 */
 @priori('
<priori>
    <view tag:L="CrappUIStyleDefaultTagType.MODAL" />
</priori>
')
class CrappUIModal extends CrappUILayout {

    /**
     * Determina se o modal pode ser fechado manualmente via ações do usuário.
     */
    @:isVar public var allowCloseModal(get, set):Bool = true;

    /**
     * Permite que o modal seja fechado ao pressionar a tecla Escape.
     */
    @:isVar public var allowCloseModalWithEsc(get, set):Bool = true;
    
    /**
     * Abre o modal.
     *
     * Registra o modal no controlador, fazendo com que ele seja exibido sobre a cena atual.
     */
    public function open():Void CrappUIModalController.use().add(this);

    /**
     * Fecha o modal.
     *
     * Remove o modal do controlador, encerrando sua exibição.
     */
    public function close():Void CrappUIModalController.use().remove(this);

    // Métodos privados de acesso (getters e setters) e de tratamento de eventos são internos.

    private function get_allowCloseModal():Bool return this.allowCloseModal;
    private function set_allowCloseModal(value:Bool):Bool return this.allowCloseModal = value;
    
    private function get_allowCloseModalWithEsc():Bool return this.allowCloseModalWithEsc;
    private function set_allowCloseModalWithEsc(value:Bool):Bool return this.allowCloseModalWithEsc = value;
    
    /**
     * Método chamado para tratar o evento de fechamento do modal.
     *
     * Internamente, encerra e destrói o modal.
     */
    private function onCloseModal():Void {
        this.kill();
    }

    /**
     * Método chamado quando o modal é aberto.
     *
     * Pode ser sobrescrito para adicionar lógica durante a abertura do modal.
     */
    private function onOpenModal():Void {
        
    }

    /**
     * Dispara um evento de fechamento no objeto dispatcher informado.
     * 
     * @param dispatcher Objeto do tipo PriDisplay que receberá o evento.
     */
    static public function dispatchCloseModalHelper(dispatcher:PriDisplay):Void {
        dispatcher.dispatchEvent(new PriEvent(PriEvent.CLOSE, false, true));
    }
}