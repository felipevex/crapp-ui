package crapp.ui.route;

import priori.event.PriEvent;
import priori.event.PriEventDispatcher;
import crapp.ui.display.CrappUIDisplay;
import helper.kits.StringKit;
import crapp.ui.route.browser.RouteBrowserHost;
import crapp.ui.display.app.CrappUIScene;
import priori.app.PriApp;
import util.kit.path.Path;

/**
 * Classe CrappUIRouteManager é responsável por gerenciar as rotas e escopos
 * da aplicação. Esta classe implementa o padrão Singleton, garantindo que apenas
 * uma instância seja utilizada durante a execução do programa.
 *
 * Suas principais responsabilidades incluem:
 *   - Registrar novas rotas juntamente com suas cenas associadas.
 *   - Navegar entre as rotas definidas (anterior, próxima, substituir e recarregar).
 *   - Gerenciar os escopos de acesso das rotas.
 *   - Instanciar e destruir cenas de forma apropriada conforme as alterações nas rotas.
 *
 * Eventos Emitidos:
 *   - PriEvent.CHANGE: Este evento é disparado na função onRouteChange() sempre
 *     que a rota é alterada e uma nova cena é instanciada.
 */
class CrappUIRouteManager extends PriEventDispatcher {
    
    // SINGLETON
    private static var _singleton:CrappUIRouteManager;

    /**
     * Retorna a instância única de CrappUIRouteManager.
     * 
     * @return instância do CrappUIRouteManager.
     */
    public static function use():CrappUIRouteManager {
        if (_singleton == null) _singleton = new CrappUIRouteManager();
        return _singleton;
    }

    // CLASS

    private var host:RouteBrowserHost;
    private var routes:Array<RouteItem>;

    private var routeHolder:CrappUIDisplay;

    private var scopes:Array<String>;

    private var scene:CrappUIScene<Dynamic>;

    public var holder(get, null):CrappUIDisplay;

    private function new() {
        super();

        this.host = new RouteBrowserHost();
        this.host.onRouteChange = this.onRouteChange;

        this.reset();
    }

    /**
     * Reinicia as rotas e escopos, além de destruir a cena atual.
     */
    public function reset():Void {
        this.routes = [];
        this.scopes = [];
        this.killScene();

        if (this.routeHolder != null) {
            routeHolder.removeFromParent();
            routeHolder.kill();
            routeHolder = null;
        }

        routeHolder = new CrappUIDisplay();
        routeHolder.left = 0;
        routeHolder.top = 0;
        routeHolder.right = 0;
        routeHolder.bottom = 0;

        PriApp.g().addChild(routeHolder);
    }

    inline private function killScene():Void {
        if (this.scene != null) {
            this.scene.removeFromParent();
            this.scene.kill();
            this.scene = null;
        }
    }

    inline private function get_holder():CrappUIDisplay return this.routeHolder;

    /**
     * Registra uma nova rota no gerenciador de rotas.
     * 
     * @param path  Caminho da rota.
     * @param scene Classe da cena associada à rota.
     * @param scope (Opcional) Escopo da rota.
     */
    public function register<T>(path:Path<T>, scene:Class<CrappUIScene<T>>, ?scope:String):Void {
        if (path == null || scene == null) return;

        this.routes.push({path: path, scene: scene, scope: scope});
    }

    private function findRouteByPath(path:String):RouteItem {
        var starRoute:RouteItem = null;

        for (route in this.routes) {
            if (route.path == '**') starRoute = route;
            if (!route.path.match(path).matched) continue;
            
            if (StringKit.isEmpty(route.scope) || this.hasScope(route.scope)) return route;
        }

        return starRoute;
    }

    private function onRouteChange():Void {
        if (this.routes.length == 0) return;

        var path:String = this.host.getPath();
        var route:RouteItem = this.findRouteByPath(path);

        if (route == null) return;

        this.instantiateScene(route);

        this.dispatchEvent(new PriEvent(PriEvent.CHANGE, false, false));
    }

    /**
     * Verifica se o escopo informado existe na sessão.
     *
     * @param scope Escopo a ser verificado.
     * @return True se o escopo existir, caso contrário false.
     */
    public function hasScope(scope:String):Bool return this.scopes.indexOf(scope) >= 0;

    /**
     * Adiciona um novo escopo à sessão.
     *
     * @param scope Escopo a ser adicionado.
     */
    public function addScope(scope:String):Void {
        if (scope == null || this.scopes.indexOf(scope) >= 0) return;
        this.scopes.push(scope);
    }

    /**
     * Remove o escopo especificado da sessão.
     *
     * @param scope Escopo a ser removido.
     */
    public function removeScope(scope:String):Void {
        if (scope == null) return;
        this.scopes.remove(scope);
    }

    private function instantiateScene(route:RouteItem):Void {
        this.killScene();

        if (route == null) return;

        this.scene = Type.createInstance(route.scene, []);
        this.scene.left = 0;
        this.scene.top = 0;
        this.scene.right = 0;
        this.scene.bottom = 0;

        this.holder.addChild(this.scene);   
    }

    /**
     * Navega para a rota anterior.
     */
    inline public function navigateBack():Void this.host.navigateBack();

    /**
     * Navega para a próxima rota.
     */
    inline public function navigateForward():Void this.host.navigateForward();

    /**
     * Navega para a rota especificada.
     *
     * @param path Caminho para onde navegar.
     */
    inline public function navigate(path:String):Void this.host.navigate(path);
    
    /**
     * Recarrega a rota atual. Caso a cena já esteja instanciada, ela será recriada.
     */
    inline public function reload():Void this.onRouteChange();

    /**
     * Substitui a rota atual pela rota especificada.
     *
     * @param path Caminho para substituir a rota atual.
     */
    inline public function replace(path:String):Void this.host.replace(path);
    
    /**
     * Extrai o parâmetro da rota atual.
     *
     * @return Parâmetro extraído da rota ou null parâmetros.
     */
    public function routeParam():Null<Dynamic> {
        if (this.routes.length == 0) return null;

        var path:String = this.host.getPath();
        var route:RouteItem = this.findRouteByPath(path);
        
        return route.path.extract(path);
    }
}

private typedef RouteItem = {
    var path:Path<Dynamic>;
    var scene:Class<CrappUIScene<Dynamic>>;
    var scope:String;
}