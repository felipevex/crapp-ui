package crapp.ui.display.input;

import helper.kits.StringKit;
import crapp.ui.composite.builtin.ButtonableComposite;
import crapp.ui.composite.builtin.OverEffectComposite;
import crapp.ui.composite.builtin.DisabledEffectComposite;
import crapp.ui.display.text.CrappUIText;
import crapp.ui.display.icon.CrappUIIcon;
import crapp.ui.style.types.CrappUIStyleDefaultTagType;
import priori.event.PriEvent;
import priori.event.PriTapEvent;
import crapp.ui.style.CrappUIStyle;
import crapp.ui.display.CrappUIDisplay;

@priori('
<priori>
    <view tag:L="CrappUIStyleDefaultTagType.RADIO" >
    </view>
</priori>
')
class CrappUIRadioInput<T> extends CrappUICheckInput<T> {

    @:isVar public var groupName(default, set):String;

    override function setup():Void {
        super.setup();

        this.addEventListener(PriEvent.ADDED_TO_APP, this.onAddToApp);
        this.addEventListener(PriEvent.REMOVED_FROM_APP, this.onRemoveFromApp);

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
        this.isSelected = true;
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

}