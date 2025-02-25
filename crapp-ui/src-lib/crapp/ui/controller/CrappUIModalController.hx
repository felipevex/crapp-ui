package crapp.ui.controller;

import crapp.ui.route.CrappUIRouteManager;
import priori.style.filter.PriFilterStyle;
import tricks.layout.LayoutAlignment;
import crapp.ui.display.layout.CrappUILayout;
import crapp.ui.display.CrappUIDisplay;
import crapp.ui.display.modal.CrappUIModal;
import priori.event.PriEvent;
import priori.types.PriTransitionType;
import priori.system.PriKey;
import priori.event.PriKeyboardEvent;
import priori.event.PriTapEvent;
import priori.app.PriApp;

@:access(crapp.ui.display.modal.CrappUIModal)
class CrappUIModalController {

    public static var USE_BLUR:Bool = false;
    public static var BLUR_STRENGTH:Int = 5;
    public static var BACKGROUND_ALPHA:Float = 0.3;
    public static var BACKGROUND_COLOR:Int = 0x000000;
    
    private static var _singleton:CrappUIModalController;

    public static function use():CrappUIModalController {
        if (_singleton == null) _singleton = new CrappUIModalController();
        return _singleton;
    }

    private var modals:Array<CrappUIModalElement> = [];
    private var modalContainer:CrappUILayout;

    private function new() {
        this.modalContainer = new CrappUILayout();
        this.modalContainer.left = 0;
        this.modalContainer.top = 0;
        this.modalContainer.right = 0;
        this.modalContainer.bottom = 0;

        this.modalContainer.hLayoutAlignment = LayoutAlignment.CENTER;
        this.modalContainer.vLayoutAlignment = LayoutAlignment.CENTER;

        CrappUIRouteManager.use().addEventListener(PriEvent.CHANGE, this.onChangeScene);
    }

    private function onChangeScene(e:PriEvent):Void {
        this.closeAllModals();
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
        item.background.bgColor = BACKGROUND_COLOR;
        item.background.allowTransition(PriTransitionType.ALPHA, 0.1);

        item.modal.alpha = 0;
        item.modal.allowTransition(PriTransitionType.ALPHA, 0.15);

        for (o in this.modals) {
            if (o.modal == item.modal) this.enableModal(o);
            else this.disableModal(o);
        }

        this.blockSceneHolder();

        this.modalContainer.addChildList([
            item.background,
            item.modal
        ]);

        this.updateContainer();
        item.modal.onOpenModal();

        haxe.Timer.delay(function():Void {
            item.background.alpha = BACKGROUND_ALPHA;
            item.modal.alpha = 1;
        }, 5);
    }

    inline private function blockSceneHolder():Void {
        PriApp.g().setFocus();
        
        CrappUIRouteManager.use().holder.disabled = true;
        if (USE_BLUR) CrappUIRouteManager.use().holder.filter = new PriFilterStyle().setBlur(BLUR_STRENGTH);
    }

    inline private function releaseSceneHolder():Void {
        CrappUIRouteManager.use().holder.disabled = false;
        CrappUIRouteManager.use().holder.filter = null;
    }

    inline private function disableModal(modal:CrappUIModalElement):Void {
        if (modal.modal.disabled) return;

        modal.modal.disabled = true;
        if (USE_BLUR) modal.modal.filter = new PriFilterStyle().setBlur(BLUR_STRENGTH);
    }

    inline private function enableModal(modal:CrappUIModalElement):Void {
        if (!modal.modal.disabled) return;

        modal.modal.disabled = false;
        modal.modal.filter = null;
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

        if (this.modals.length == 0) this.releaseSceneHolder();
        else this.enableModal(this.modals[this.modals.length-1]);

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
        if (Std.is(e.target, CrappUIModal)) {
            var o:CrappUIModal = cast e.target;
            this.remove(o);
        }
    }
}

private typedef CrappUIModalElement = {
    var background:CrappUIDisplay;
    var modal:CrappUIModal;
}