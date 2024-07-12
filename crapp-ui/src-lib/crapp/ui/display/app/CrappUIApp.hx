package crapp.ui.display.app;

import crapp.ui.style.CrappUIEvents;
import priori.event.PriEvent;
import crapp.ui.style.CrappUIStyle;
import crapp.ui.controller.CrappUIStyleController;
import crapp.ui.interfaces.ICrappUIStyleObject;
import priori.scene.view.PriPreloaderView;
import crapp.ui.controller.CrappUIModalController;
import priori.scene.PriSceneManager;
import priori.app.PriApp;

@:autoBuild(priori.view.builder.PriBuilderMacros.build())
@:autoBuild(crapp.ui.macros.CrappUIMacroApp.build())
class CrappUIApp extends PriApp implements ICrappUIStyleObject {

    private var styleController:CrappUIStyleController;
    public var style(get, set):CrappUIStyle;
    public var parentStyle(get, null):CrappUIStyle;

    @:noCompletion private var __delayedStart:Bool = true;
    
    public var sceneContainer:CrappUIDisplay;
    public var overlayContainer:CrappUIDisplay;

    public var customPreloader:Class<PriPreloaderView>;
    
    public function new() {
        this.styleController = new CrappUIStyleController();

        super();

        this.styleController.start(this);
        

        this.startSceneContainer();
        this.startOverlay();

        this.addChildList([
            this.sceneContainer,
            this.overlayContainer
        ]);

        this.__priAppInclude();

        PriSceneManager.use().preload(
            this.customPreloader,
            this.__on_preloader_error,
            this.__on_preloader_success
        );
    }

    @:noCompletion private function startSceneContainer():Void {
        if (this.sceneContainer != null) return;

        this.sceneContainer = new CrappUIDisplay();
        this.sceneContainer.left = 0;
        this.sceneContainer.top = 0;
        this.sceneContainer.right = 0;
        this.sceneContainer.bottom = 0;
        PriSceneManager.use().holder = this.sceneContainer;
    }

    @:noCompletion private function startOverlay():Void {
        this.overlayContainer = CrappUIModalController.use().getContainer();
        this.overlayContainer.visible = false;
    }

    public function onLoad():Void {}
    public function onError():Void {}

    override private function startApplication():Void {
        if (!__delayedStart) {
            this.__priBuilderSetup();
            this.__priBuilderPaint();
            super.startApplication();
        }
    }

    @:noCompletion private function __priBuilderSetup():Void {}
    @:noCompletion private function __priBuilderPaint():Void {}
    @:noCompletion private function __priAppInclude():Void {}
    @:noCompletion private function __priAppRoutes():Void {}

    @:noCompletion private function __on_preloader_error():Void {}
    @:noCompletion private function __on_preloader_success():Void {
        this.__delayedStart = false;
        this.__priAppRoutes();
        this.onLoad();
        this.startApplication();
        
        PriSceneManager.singleton().navigateToCurrent();
    }

    function get_parentStyle():CrappUIStyle return this.styleController.getParentStyle();
    function get_style():CrappUIStyle return this.styleController.getStyle();
	function set_style(value:CrappUIStyle):CrappUIStyle return this.styleController.setStyle(value);

    private function propagateCrappUIEvent(event:CrappUIEvents):Void {
        var event:PriEvent = new PriEvent(event, true, false);
        this.dispatchEvent(event);
    }

    public function updateDisplay():Void {
        
    }

}