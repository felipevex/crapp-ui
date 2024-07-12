package crapp.ui.controller;

import crapp.ui.display.CrappUIDisplay;
import helper.kits.ArrayKit;
import crapp.ui.display.modal.CrappUIModal;
import priori.event.PriEvent;
import priori.scene.PriSceneManager;
import priori.types.PriTransitionType;
import priori.system.PriKey;
import priori.event.PriKeyboardEvent;
import priori.event.PriTapEvent;
import priori.app.PriApp;

@:access(crapp.ui.display.modal.CrappUIModal)
class CrappUIModalController {
    
    private static var _singleton:CrappUIModalController;

    public static function use():CrappUIModalController {
        if (_singleton == null) _singleton = new CrappUIModalController();
        return _singleton;
    }

    private var modals:Array<CrappUIModalElement> = [];
    private var modalContainer:CrappUIDisplay;

    private function new() {
        this.modalContainer = new CrappUIDisplay();
        this.modalContainer.left = 0;
        this.modalContainer.top = 0;
        this.modalContainer.right = 0;
        this.modalContainer.bottom = 0;
    }

    private function showModalContainer():Void {
        PriApp.g().addChild(this.modalContainer);
    }

    private function hideModalContainer():Void {
        PriApp.g().removeChild(this.modalContainer);
    }

    public function getContainer():CrappUIDisplay {
        return this.modalContainer;
    }

    public function closeTopMostModal():Void {
        if (this.modals.length > 0) this.remove(this.modals[this.modals.length - 1].modal);
    }

    public function closeAllModals():Void {
        while (this.modals.length > 0) this.remove(this.modals[0].modal);
    }

    public function tryToCloseParentModal(element:CrappUIDisplay):Void {
        if (element == null) return;
        element.dispatchEvent(new PriEvent(PriEvent.CLOSE, false, true));
    }

    public function add(modal:CrappUIModal):Void {
        if (modal == null) return;
        
        modal.removeEventListener(PriEvent.CLOSE, this.onCloseModal);
        modal.addEventListener(PriEvent.CLOSE, this.onCloseModal);

        var currentIndex:Int = -1;
        for (i in 0 ... this.modals.length) if (this.modals[i].modal == modal) currentIndex = i;

        var item:CrappUIModalElement = currentIndex >= 0
            ? this.modals[currentIndex]
            : {
                modal : modal,
                background : new CrappUIDisplay()
            };

        if (currentIndex >= 0) this.modals.remove(item);
        this.modals.push(item);

        item.background.removeEventListener(PriTapEvent.TAP, this.onTapBackground);
        item.background.addEventListener(PriTapEvent.TAP, this.onTapBackground);
        item.background.pointer = false;
        item.background.alpha = 0.0;
        item.background.left = 0;
        item.background.right = 0;
        item.background.top = 0;
        item.background.bottom = 0;
        item.background.bgColor = 0x000000;
        item.background.allowTransition(PriTransitionType.ALPHA, 0.2);
        item.background.z = 8;

        item.modal.alpha = 0;
        item.modal.allowTransition(PriTransitionType.ALPHA, 0.3);

        for (o in this.modals) {
            if (o.modal == item.modal) item.modal.disabled = false;
            else o.modal.disabled = true;
        }

        PriApp.g().setFocus();
        PriSceneManager.use().holder.disabled = true;

        this.modalContainer.addChildList([
            item.background,
            item.modal
        ]);

        this.updateContainer();
        item.modal.onOpenModal();

        haxe.Timer.delay(function():Void {
            item.background.alpha = 0.3;
            item.modal.alpha = 1;
        }, 5);
    }

    public function remove(modal:CrappUIModal):Void {
        if (modal == null) return;

        modal.removeEventListener(PriEvent.CLOSE, this.onCloseModal);

        var index:Int = -1;
        for (i in 0 ... this.modals.length) {
            if (this.modals[i].modal == modal) {
                index = i;
                break;
            }
        }
        
        if (index == -1) return;

        var item:CrappUIModalElement = this.modals[index];

        item.background.removeEventListener(PriTapEvent.TAP, this.onTapBackground);

        this.modalContainer.removeChildList([
            item.modal,
            item.background
        ]);

        this.modals.remove(item);

        if (this.modals.length == 0) PriSceneManager.use().holder.disabled = false;
        else this.modals[this.modals.length-1].modal.disabled = false;

        item.modal.onCloseModal();
        item.background.kill();

        this.updateContainer();
    }

    private function updateContainer():Void {
        if (this.modalContainer.numChildren == 0) this.hideModalContainer();
        else {
            PriApp.g().removeEventListener(PriKeyboardEvent.KEY_UP, this.onKeyUp);
            PriApp.g().addEventListener(PriKeyboardEvent.KEY_UP, this.onKeyUp);

            this.showModalContainer();
        }
    }

    private function onKeyUp(e:PriKeyboardEvent):Void {
        if (e.keycode == PriKey.ESC) {
            if (
                this.modals.length > 0 &&
                this.modals[this.modals.length - 1].modal.allowCloseModal &&
                this.modals[this.modals.length - 1].modal.allowCloseModalWithEsc
            ) {
                this.remove(this.modals[this.modals.length - 1].modal);
            } 
        }
    }

    private function onTapBackground(e:PriTapEvent):Void {
        var currentIndex:Int = -1;
        for (i in 0 ... this.modals.length) {
            if (
                this.modals[i].background == e.currentTarget &&
                this.modals[i].modal.allowCloseModal
            ) {
                currentIndex = i;
                break;
            }
        }

        if (currentIndex > -1) this.remove(this.modals[currentIndex].modal);
    }

    private function onCloseModal(e:PriEvent):Void {
        if (Std.is(e.target, PriEvent)) {
            var o:CrappUIModal = cast e.target;
            this.remove(o);
        }
    }
}

private typedef CrappUIModalElement = {
    var background:CrappUIDisplay;
    var modal:CrappUIModal;
}