/**
   A classe CrappUIModalController tem como finalidade gerenciar a exibição, o comportamento e a remoção dos modais na aplicação.
   #### Responsabilidades:
   - Gerenciar a adição e remoção de modais sobrepostos na interface.
   - Controlar as transições visuais e efeitos (como alteração de alfa e aplicação de blur) durante a exibição dos modais.
   - Integrar os modais com o gerenciamento de foco e com o sistema de rotas da aplicação.
**/
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

    /**
       Esta variável indica se deve ser aplicado um efeito de blur no conteudo em background quando um modal for acionado.
       @default false
    **/
    public static var USE_BLUR:Bool = false;

    /**
       Determina a intensidade do efeito de blur.
       @default 5
    **/
    public static var BLUR_STRENGTH:Int = 5;

    /**
       Define o nível de transparência do fundo dos modais.
       @default 0.3
    **/
    public static var BACKGROUND_ALPHA:Float = 0.3;

    /**
       Define a cor de fundo utilizada nos elementos de exibição dos modais.
       @default 0x000000
    **/
    public static var BACKGROUND_COLOR:Int = 0x000000;
    
    private static var _singleton:CrappUIModalController;

    /**
       Retorna a instância única (singleton) do controlador de modais.
       @return Instância de CrappUIModalController
    **/
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

    /**
       Retorna o container de exibição utilizado para agregar os modais.
       @return Instância de CrappUIDisplay que contém os modais
    **/
    public function getContainer():CrappUIDisplay {
        return this.modalContainer;
    }

    /**
       Fecha o modal que está no topo da pilha de modais.
    **/
    public function closeTopMostModal():Void {
        if (this.modals.length > 0) this.remove(this.modals[this.modals.length - 1].modal);
    }

    /**
       Fecha todos os modais atualmente abertos.
    **/
    public function closeAllModals():Void {
        while (this.modals.length > 0) this.remove(this.modals[0].modal);
    }

    /**
       Tenta fechar o modal pai associado ao elemento de exibição informado.
       @param element Objeto do tipo CrappUIDisplay que pode possuir um modal pai
    **/
    public function tryToCloseParentModal(element:CrappUIDisplay):Void {
        if (element == null) return;
        element.dispatchEvent(new PriEvent(PriEvent.CLOSE, false, true));
    }

    /**
       Adiciona um novo modal à pilha de modais e inicia sua exibição com as transições e efeitos configurados.
       @param modal Instância de CrappUIModal a ser exibida
    **/
    public function add(modal:CrappUIModal):Void {
        if (modal == null) return;
        
        modal.removeEventListener(PriEvent.CLOSE, this.onCloseModal);
        modal.addEventListener(PriEvent.CLOSE, this.onCloseModal);

        var currentIndex:Int = -1;
        for (i in 0 ... this.modals.length) if (this.modals[i].modal == modal) {
            currentIndex = i;
            break;
        }

        var item:CrappUIModalElement = currentIndex >= 0
            ? this.modals[currentIndex]
            : this.createModalStructure(modal);

        if (currentIndex >= 0) {
            this.modals.remove(item);
            item.content.alpha = 0.0;
        }

        this.modals.push(item);
        
        for (o in this.modals) {
            if (o.modal == item.modal) this.enableModal(o);
            else this.disableModal(o);
        }

        item.content.alpha = 1.0;

        this.blockSceneHolder();

        this.modalContainer.addChild(item.content);

        this.updateContainer();
        item.modal.onOpenModal();

        haxe.Timer.delay(function():Void {
            item.background.alpha = BACKGROUND_ALPHA;
            item.modal.alpha = 1;
        }, 5);
    }

    private function createModalStructure(modal):CrappUIModalElement {
        var result:CrappUIModalElement = {
            modal : modal,
            content : new CrappUILayout(),
            background : new CrappUIDisplay()
        }

        result.background.addEventListener(PriTapEvent.TAP, this.onTapBackground);
        result.background.pointer = false;
        result.background.bgColor = BACKGROUND_COLOR;
        result.background.alpha = BACKGROUND_ALPHA;
        result.background.left = 0;
        result.background.right = 0;
        result.background.top = 0;
        result.background.bottom = 0;


        result.content.hLayoutAlignment = LayoutAlignment.CENTER;
        result.content.vLayoutAlignment = LayoutAlignment.CENTER;
        result.content.alpha = 0.0;
        result.content.allowTransition(PriTransitionType.ALPHA, 0.18);
        result.content.left = 0;
        result.content.right = 0;
        result.content.top = 0;
        result.content.bottom = 0;
        result.content.addChildList([
            result.background,
            result.modal
        ]);

        return result;
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
        if (modal.content.disabled) return;

        modal.content.disabled = true;
        if (USE_BLUR) modal.content.filter = new PriFilterStyle().setBlur(BLUR_STRENGTH);
    }

    inline private function enableModal(modal:CrappUIModalElement):Void {
        if (!modal.content.disabled) return;

        modal.content.disabled = false;
        modal.content.filter = null;
    }

    /**
       Remove o modal especificado da pilha, encerrando sua exibição e revertendo as configurações de foco e filtro do fundo.
       @param modal Instância de CrappUIModal a ser removida
    **/
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

        item.content.removeFromParent();
        item.modal.removeFromParent();

        item.content.kill();
        item.background.kill();

        this.modals.remove(item);

        if (this.modals.length == 0) this.releaseSceneHolder();
        else this.enableModal(this.modals[this.modals.length-1]);

        item.modal.onCloseModal();

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
    var content:CrappUILayout;
    var modal:CrappUIModal;
}