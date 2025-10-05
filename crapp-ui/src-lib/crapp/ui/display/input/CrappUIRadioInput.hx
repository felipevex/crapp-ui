package crapp.ui.display.input;

import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import priori.event.PriEvent;
import priori.event.PriTapEvent;

/**
    A classe `CrappUIRadioInput` tem como finalidade fornecer um componente de interface gráfica para entrada de dados do tipo radio button, permitindo ao usuário selecionar uma única opção dentro de um grupo de opções mutuamente exclusivas. O componente estende a funcionalidade de `CrappUICheckInput` e adiciona o comportamento específico de agrupamento, onde apenas um elemento por grupo pode estar selecionado simultaneamente.

    #### Responsabilidades:
    - **Gerenciamento de Grupo**: Controla e mantém a associação do radio button a um grupo específico identificado por nome
    - **Exclusividade de Seleção**: Garante que apenas um radio button por grupo esteja selecionado, desabilitando automaticamente os outros quando um é selecionado
    - **Sincronização de Estado**: Sincroniza o estado de seleção com outros radio buttons do mesmo grupo através do `CrappUIRadioGroupManager`
    - **Proxy de Grupo**: Fornece acesso simplificado às operações do grupo através da propriedade `group`
    - **Ciclo de Vida**: Gerencia adequadamente a adição e remoção do componente em grupos quando é anexado ou removido da aplicação
**/
@priori('
<priori>
    <view tag:L="CrappUIStyleDefaultTagType.RADIO" >
    </view>
</priori>
')
class CrappUIRadioInput<T> extends CrappUICheckInput<T> {

    /**
        Nome do grupo ao qual este radio button pertence. Radio buttons com o mesmo `groupName`
        formam um grupo mutuamente exclusivo, onde apenas um pode estar selecionado por vez.
        Quando alterado, o radio button é automaticamente removido do grupo anterior e
        adicionado ao novo grupo especificado.
    **/
    @:isVar public var groupName(default, set):String;

    /**
        Propriedade somente leitura que fornece acesso ao proxy do grupo deste radio button.
        Retorna uma instância de `CrappUIRadioGroupProxy` que permite manipular o valor
        selecionado do grupo de forma simplificada. Retorna `null` se `groupName` não estiver definido.
    **/
    public var group(get, never):CrappUIRadioGroupProxy<T>;

    override function setup():Void {
        super.setup();

        this.addEventListener(PriEvent.ADDED_TO_APP, this.onAddToApp);
        this.addEventListener(PriEvent.REMOVED_FROM_APP, this.onRemoveFromApp);

    }

    private function get_group():CrappUIRadioGroupProxy<T> {
        if (this.groupName == null) return null;
        return new CrappUIRadioGroupProxy<T>(this.groupName);
    }

    private function onAddToApp(e:PriEvent):Void {
        CrappUIRadioGroupManager.get().addToGroup(this.groupName, this);
        if (this.isSelected) this.setOtherRadiosAsOff();
    }

    private function onRemoveFromApp(e:PriEvent):Void {
        CrappUIRadioGroupManager.get().removeFromGroup(this.groupName, this);
    }

    private function set_groupName(value:String):String {
        CrappUIRadioGroupManager.get().removeFromGroup(this.groupName, this);

        this.groupName = value;

        if (this.hasApp()) {
            if (this.isSelected) this.setOtherRadiosAsOff();
            CrappUIRadioGroupManager.get().addToGroup(value, this);
        }

        return value;
    }

    override private function onTap(e:PriTapEvent):Void {
        var oldValue:T = CrappUIRadioGroupManager.get().getGroupValue(this.groupName);
        this.isSelected = true;
        var newValue:T = CrappUIRadioGroupManager.get().getGroupValue(this.groupName);

        if (oldValue != newValue) CrappUIRadioGroupManager.get().dispatchChange(this.groupName);
    }

    override private function set_isSelected(value:Bool):Bool {
        if (value == null) return value;

        if (value == true && this.hasApp()) this.setOtherRadiosAsOff();

        this.isSelected = value;
        this.updateSelectedIcon();

        return value;
    }

    private function setOtherRadiosAsOff():Void {
        var items = CrappUIRadioGroupManager.get().getItems(this.groupName);
        for (item in items) if (item != this && item.isSelected) item.isSelected = false;
    }

    override private function updateSelectedIcon():Void {
        this.iconDisplay.icon = this.isSelected
            ? DOT_CIRCLE_REGULAR
            : CIRCLE_REGULAR;
    }

    override private function onKeyboardActionable():Void {
        this.onTap(null);
    }

}


private typedef AnyRadio = CrappUIRadioInput<Dynamic>;
private class CrappUIRadioGroupManager {

    private static var instance:CrappUIRadioGroupManager;
    static public function get():CrappUIRadioGroupManager {
        if (instance == null) instance = new CrappUIRadioGroupManager();
        return instance;
    }

    private var groups:Map<String, Array<AnyRadio>>;

    public function new() {
        this.groups = new Map();
    }

    public function addToGroup(group:String, radio:AnyRadio):Void {
        if (group == null || radio == null) return;

        if (!this.groups.exists(group)) this.groups.set(group, []);
        var items:Array<AnyRadio> = this.groups.get(group);
        if (items.indexOf(radio) == -1) items.push(radio);
    }

    public function removeFromGroup(group:String, radio:AnyRadio):Void {
        if (group == null || radio == null) return;

        if (!this.groups.exists(group)) return;
        var items:Array<AnyRadio> = this.groups.get(group);
        var index:Int = items.indexOf(radio);
        if (index != -1) items.splice(index, 1);
    }

    public function getItems(group:String):Array<AnyRadio> {
        if (group == null || !this.groups.exists(group)) return [];
        return this.groups.get(group);
    }

    public function dispatchChange(group:String):Void {
        if (group == null) return;

        var items = this.getItems(group);
        for (item in items) if (item.actions.onChange != null) item.actions.onChange();
    }

    public function getGroupValue(group:String):Dynamic {
        if (group == null) return null;

        var items = this.getItems(group);
        for (item in items) if (item.isSelected) return item.value;

        return null;
    }
}

private class CrappUIRadioGroupProxy<T> {

    public var value(get, set):T;

    private var groupName:String;

    public function new(groupName:String) {
        this.groupName = groupName;
    }

    private function get_value():T return CrappUIRadioGroupManager.get().getGroupValue(this.groupName);

    private function set_value(value:T):T {
        var items = CrappUIRadioGroupManager.get().getItems(this.groupName);
        for (item in items) item.isSelected = (item.value == value);
        return value;
    }


}