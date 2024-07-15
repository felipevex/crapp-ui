package crapp.ui.display.app;

import crapp.ui.style.data.CrappUIStyleData;
import crapp.ui.style.CrappUIStyleManager;
import crapp.ui.style.CrappUIEvents;
import priori.event.PriEvent;
import crapp.ui.interfaces.ICrappUIStyleObject;
import priori.scene.view.PriPreloaderView;
import crapp.ui.controller.CrappUIModalController;
import priori.scene.PriSceneManager;
import priori.app.PriApp;

@:autoBuild(priori.view.builder.PriBuilderMacros.build())
@:autoBuild(crapp.ui.macros.CrappUIMacroApp.build())
class CrappUIApp extends PriApp implements ICrappUIStyleObject {

    private var styleManager:CrappUIStyleManager;

    public var theme(get, set):String;
    public var tag(get, set):String;
    public var variant(get, set):String;
    public var style(get, set):CrappUIStyleData;

    public var sceneContainer:CrappUIDisplay;
    public var overlayContainer:CrappUIDisplay;

    public var customPreloader:Class<PriPreloaderView>;

    
    public function new() {
        this.styleManager = new CrappUIStyleManager();

        super();

        this.styleManager.start(this);
        
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

    @:noCompletion private function __priBuilderSetup():Void {}
    @:noCompletion private function __priBuilderPaint():Void {}
    @:noCompletion private function __priAppInclude():Void {}
    @:noCompletion private function __priAppRoutes():Void {}

    @:noCompletion private function __on_preloader_error():Void {}
    @:noCompletion private function __on_preloader_success():Void {
        this.onLoad();
    }

    function get_style():CrappUIStyleData return this.styleManager.getStyle();
	function set_style(value:CrappUIStyleData):CrappUIStyleData return this.styleManager.setStyle(value);

    private function propagateCrappUIEvent(event:CrappUIEvents):Void {
        var event:PriEvent = new PriEvent(event, true, false);
        this.dispatchEvent(event);
    }

    public function updateDisplay():Void {}

    public function init():Void {
        this.__priAppRoutes();
        PriSceneManager.singleton().navigateToCurrent();
    }

    function get_theme():String return this.styleManager.getTheme();
    function set_theme(value:String):String return this.styleManager.setTheme(value);
    function get_tag():String return this.styleManager.getTag();
    function set_tag(value:String):String return this.styleManager.setTag(value);
    function get_variant():String return this.styleManager.getVariant();
    function set_variant(value:String):String return this.styleManager.setVariant(value);
}