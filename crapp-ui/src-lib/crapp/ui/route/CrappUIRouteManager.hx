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
    A classe **CrappUIRouteManager** é responsável por gerenciar as rotas e escopos da aplicação.  
    Esta classe implementa o padrão *Singleton*, garantindo que apenas uma instância seja utilizada durante a execução do programa.

    #### Responsabilidades:
    - **Registrar novas rotas**: Associa caminhos (rotas) às respectivas classes de cena.
    - **Navegar entre rotas**: Permite navegar para trás, para frente, recarregar a rota atual ou substituir a rota através do host.
    - **Gerenciar os escopos**: Controla os escopos de acesso das rotas, permitindo verificar, adicionar e remover escopos.
    - **Instanciar e destruir cenas**: Cria ou elimina cenas conforme a alteração das rotas, garantindo que a cena atual seja corretamente destruída antes de instanciar uma nova.

    #### Eventos Emitidos:
    - **PriEvent.CHANGE**: Disparado na função onRouteChange() sempre que uma nova cena é instanciada, indicando que houve mudança de rota.
*/
class CrappUIRouteManager extends PriEventDispatcher {
    
    // SINGLETON
    private static var _singleton:CrappUIRouteManager;

    /**
        Retorna a instância única de CrappUIRouteManager (padrão Singleton).

        @return instância do CrappUIRouteManager.
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

    /**
        Getter para o holder que armazena a cena instanciada.

        @return Instância de CrappUIDisplay que contém a cena atual.

        O holder (routeHolder) é o container utilizado para adicionar a cena instanciada durante a navegação.
     */
    public var holder(get, null):CrappUIDisplay;

    private function new() {
        super();

        this.host = new RouteBrowserHost();
        this.host.onRouteChange = this.onRouteChange;

        this.reset();
    }

    /**
        Reinicia as rotas e os escopos da aplicação. Essa função:
        - Limpa as rotas e escopos.
        - Destrói (mata) a cena atual, se existir.
        - Remove e recria o routeHolder, que é o container onde as cenas são adicionadas.

        Este método é fundamental para garantir que o estado do roteamento seja limpo antes de atribuir novas cenas.
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
        Registra uma nova rota no gerenciador.
        Ao registrar uma rota, a associação entre o caminho e a cena é armazenada para ser utilizada na navegação.
        @param path Caminho da rota (instância de Path<T>).
        @param scene Classe da cena associada à rota.
        @param scope (Opcional) Escopo de acesso para a rota.
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
        Verifica se o escopo informado existe na sessão atual.
        Retorna true se o escopo existir, caso contrário, retorna false.
        
        @param scope Escopo a ser verificado.
        @return True se o escopo existir; caso contrário, false.
     */
    public function hasScope(scope:String):Bool return this.scopes.indexOf(scope) >= 0;

    /**
        Adiciona um novo escopo à sessão.
        A adição de escopos permite controlar o acesso às rotas registradas de acordo com os privilégios definidos,
        adicionando o escopo se ele não for nulo e ainda não estiver presente.
    
        @param scope Escopo a ser adicionado.
     */
    public function addScope(scope:String):Void {
        if (scope == null || this.scopes.indexOf(scope) >= 0) return;
        this.scopes.push(scope);
    }

    /**
        Remove o escopo especificado da sessão.
        Esta função gerencia os privilégios de acesso removendo escopos que não são mais válidos.
    
        @param scope Escopo a ser removido.
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
        Navega para a rota anterior, utilizando a funcionalidade do host.

        Essa função é utilizada para "voltar" na navegação realizada.
     */
    inline public function navigateBack():Void this.host.navigateBack();

    /**
        Navega para a próxima rota, utilizando a funcionalidade do host.
        
        Permite avançar na navegação historicamente armazenada.
     */
    inline public function navigateForward():Void this.host.navigateForward();

    /**
        Navega para a rota especificada, alterando a rota atual para a rota informada.

        @param path Caminho para onde realizar a navegação.
     */
    inline public function navigate(path:String):Void this.host.navigate(path);
    
    /**
        Recarrega a rota atual. Caso a cena já esteja instanciada, esta será destruída e uma nova instância será criada.
        Esse método é útil para atualizar a cena sem alterar o histórico de navegação.
        
        @return void
     */
    inline public function reload():Void this.onRouteChange();

    /**
        Substitui a rota atual pela rota especificada.
        Essa funcionalidade é útil quando se deseja substituir a cena atual sem manter o histórico da rota anterior.

        @param path Caminho da nova rota que substituirá a rota atual.
        @return void
     */
    inline public function replace(path:String):Void this.host.replace(path);
    
    /**
        Extrai e retorna o parâmetro da rota atual.
        Utiliza o método extract do objeto Path associado para obter os parâmetros dinamicamente definidos na URL.
    
        @return Parâmetro extraído da rota atual ou null, caso não haja parâmetros.
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