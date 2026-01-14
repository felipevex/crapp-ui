package front.route;

import crapp.ui.route.CrappUIRouteManager;
import util.kit.nothing.Nothing;
import util.kit.path.Path;

class FrontRoute {

    static public var pathInit:Path<Nothing> = '**';
    static public var pathSceneHome:Path<Nothing> = 'home';
    static public var pathSceneText:Path<Nothing> = 'text';
    static public var pathSceneTextIcon:Path<Nothing> = 'text/icon';
    static public var pathSceneButton:Path<Nothing> = 'button/button';
    static public var pathSceneButtonIconText:Path<Nothing> = 'button/icon/text';
    static public var pathSceneButtonIcon:Path<Nothing> = 'button/icon';
    static public var pathSceneButtonSurface:Path<Nothing> = 'button/surface';
    static public var pathSceneInputText:Path<Nothing> = 'input/text';
    static public var pathSceneInputTextMask:Path<Nothing> = 'input/text/mask';
    static public var pathSceneInputTextArea:Path<Nothing> = 'input/textarea';
    static public var pathSceneInputSelect:Path<Nothing> = 'input/select';
    static public var pathSceneInputRadio:Path<Nothing> = 'input/radio';
    static public var pathSceneInputCheck:Path<Nothing> = 'input/check';
    static public var pathSceneInputRate:Path<Nothing> = 'input/rate';
    static public var pathSceneInputToggle:Path<Nothing> = 'input/toggle';
    static public var pathSceneInputBadge:Path<Nothing> = 'input/badge';
    static public var pathSceneStyle:Path<Nothing> = 'style';
    static public var pathSceneScrollerComposite:Path<Nothing> = 'composite/scroller';
    static public var pathSceneList:Path<Nothing> = 'list';
    static public var pathSceneStack:Path<Nothing> = 'stack';
    static public var pathSceneMenu:Path<Nothing> = 'menu';
    static public var pathSceneContextMenu:Path<Nothing> = 'menu/context';
    static public var pathSceneImage:Path<Nothing> = 'image';
    static public var pathSceneSurface:Path<Nothing> = 'container/surface';
    static public var pathSceneLineHorizontal:Path<Nothing> = 'line/horizontal';
    static public var pathSceneLineVertical:Path<Nothing> = 'line/vertical';
    static public var pathSceneModal:Path<Nothing> = 'modal';
    static public var pathSceneDialog:Path<Nothing> = 'modal/dialog';
    static public var pathSceneIcon:Path<Nothing> = 'icon';
    static public var pathSceneFrame:Path<Nothing> = 'frame';
    static public var pathSceneRoute:Path<Nothing> = 'route';
    static public var pathSceneRouteParametric:Path<{id:Int, name:String}> = 'route/{id:Int}/{name:String}';
    static public var pathSceneDrag:Path<Nothing> = 'drag';
    static public var pathSceneBadge:Path<Nothing> = 'badge';
    static public var pathSceneBadgeContainer:Path<Nothing> = 'badge/container';

    static public function registerAllScenes():Void {

        CrappUIRouteManager.use().register(pathInit, front.scene.home.SceneHome);
        CrappUIRouteManager.use().register(pathSceneHome, front.scene.home.SceneHome);
        CrappUIRouteManager.use().register(pathSceneText, front.scene.text.SceneText);
        CrappUIRouteManager.use().register(pathSceneTextIcon, front.scene.text.SceneTextIcon);
        CrappUIRouteManager.use().register(pathSceneButton, front.scene.button.SceneButton);
        CrappUIRouteManager.use().register(pathSceneButtonIconText, front.scene.button.SceneButtonIconText);
        CrappUIRouteManager.use().register(pathSceneButtonIcon, front.scene.button.SceneButtonIcon);
        CrappUIRouteManager.use().register(pathSceneButtonSurface, front.scene.button.SceneButtonSurface);
        CrappUIRouteManager.use().register(pathSceneInputText, front.scene.input.SceneInputText);
        CrappUIRouteManager.use().register(pathSceneInputTextMask, front.scene.input.SceneInputTextMask);
        CrappUIRouteManager.use().register(pathSceneInputTextArea, front.scene.input.SceneInputTextArea);
        CrappUIRouteManager.use().register(pathSceneInputSelect, front.scene.input.SceneInputSelect);
        CrappUIRouteManager.use().register(pathSceneInputRadio, front.scene.input.SceneInputRadio);
        CrappUIRouteManager.use().register(pathSceneInputCheck, front.scene.input.SceneInputCheck);
        CrappUIRouteManager.use().register(pathSceneInputRate, front.scene.input.SceneInputRate);
        CrappUIRouteManager.use().register(pathSceneInputToggle, front.scene.input.SceneInputToggle);
        CrappUIRouteManager.use().register(pathSceneInputBadge, front.scene.input.SceneInputBadge);
        CrappUIRouteManager.use().register(pathSceneStyle, front.scene.style.SceneStyle);
        CrappUIRouteManager.use().register(pathSceneScrollerComposite, front.scene.composite.SceneScrollerComposite);
        CrappUIRouteManager.use().register(pathSceneList, front.scene.list.SceneList);
        CrappUIRouteManager.use().register(pathSceneStack, front.scene.stack.SceneStack);
        CrappUIRouteManager.use().register(pathSceneContextMenu, front.scene.menu.SceneContextMenu);
        CrappUIRouteManager.use().register(pathSceneMenu, front.scene.menu.SceneMenu);
        CrappUIRouteManager.use().register(pathSceneImage, front.scene.image.SceneImage);
        CrappUIRouteManager.use().register(pathSceneSurface, front.scene.container.SceneSurface);
        CrappUIRouteManager.use().register(pathSceneLineHorizontal, front.scene.line.SceneLineHorizontal);
        CrappUIRouteManager.use().register(pathSceneLineVertical, front.scene.line.SceneLineVertical);
        CrappUIRouteManager.use().register(pathSceneModal, front.scene.modal.SceneModal);
        CrappUIRouteManager.use().register(pathSceneDialog, front.scene.modal.SceneDialog);
        CrappUIRouteManager.use().register(pathSceneIcon, front.scene.icon.SceneIcon);
        CrappUIRouteManager.use().register(pathSceneFrame, front.scene.frame.SceneFrame);
        CrappUIRouteManager.use().register(pathSceneRoute, front.scene.route.SceneRoute);
        CrappUIRouteManager.use().register(pathSceneRouteParametric, front.scene.route.SceneRouteParametric);
        CrappUIRouteManager.use().register(pathSceneDrag, front.scene.drag.SceneDrag);
        CrappUIRouteManager.use().register(pathSceneBadge, front.scene.badge.SceneBadge);
        CrappUIRouteManager.use().register(pathSceneBadgeContainer, front.scene.badge.SceneBadgeContainer);

    }
}