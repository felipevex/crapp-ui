package crapp.ui.display.modal;

import crapp.ui.display.layout.CrappUILayotable;
import priori.event.PriEvent;
import crapp.ui.controller.CrappUIModalController;
import priori.view.PriDisplay;

class CrappUIModal extends CrappUILayotable {

    @:isVar public var allowCloseModal(get, set):Bool = true;
    @:isVar public var allowCloseModalWithEsc(get, set):Bool = true;
    
    public function new() {
        super();
    }

    public function open():Void CrappUIModalController.use().add(this);
    public function close():Void CrappUIModalController.use().remove(this);

    private function get_allowCloseModal():Bool return this.allowCloseModal;
    private function set_allowCloseModal(value:Bool):Bool return this.allowCloseModal = value;
    
    private function get_allowCloseModalWithEsc():Bool return this.allowCloseModalWithEsc;
    private function set_allowCloseModalWithEsc(value:Bool):Bool return this.allowCloseModalWithEsc = value;
    
    private function onCloseModal():Void {
        this.kill();
    }

    private function onOpenModal():Void {
        
    }

    static public function dispatchCloseModalHelper(dispatcher:PriDisplay):Void {
        dispatcher.dispatchEvent(new PriEvent(PriEvent.CLOSE, false, true));
    }
}