package front.scene.stack;

import crapp.ui.display.stack.CrappUIStackChild;
import crapp.ui.display.text.CrappUIText;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.stack.CrappUIStack />
    </imports>
    <view>
        <private:CrappUIStack 
            id="stack"
            width="300" 
            centerX:Paint="this.width/2" 
            centerY:Paint="this.height/2" 
        />
    </view>
</priori>
')
class SceneStack extends CrappUIScene {
    
    override function setup() {
        
        var data:Array<StackChildData> = [
            { id: 1, name: "Item 1" },
            { id: 2, name: "Item 2" },
            { id: 3, name: "Item 3" },
            { id: 4, name: "Item 4" },
            { id: 5, name: "Item 5" },
            { id: 6, name: "Item 6" },
            { id: 7, name: "Item 7" },
            { id: 8, name: "Item 8" },
            { id: 9, name: "Item 9" },
            { id: 10, name: "Item 10" },
            { id: 11, name: "Item 11" },
            { id: 12, name: "Item 12" },
            { id: 13, name: "Item 13" },
            { id: 14, name: "Item 14" },
            { id: 15, name: "Item 15" },
            { id: 16, name: "Item 16" },
            { id: 17, name: "Item 17" },
            { id: 18, name: "Item 18" },
            { id: 19, name: "Item 19" },
            { id: 20, name: "Item 20" }
        ];

        

        this.stack.setDefaultStackChidlClass(StackChild);
        this.stack.addStacks(data);
        

        haxe.Timer.delay(this.stack.clearStack, 4000);
        haxe.Timer.delay(() -> {
            
            for (item in data) {
                this.stack.addStackItem(item, StackChild);
            }

        }, 5000);
    }
}

private typedef StackChildData = {
    var id:Int;
    var name:String;
}

private class StackChild extends CrappUIStackChild<StackChildData> {

    private var label:CrappUIText;

    override function setup() {
        super.setup();

        this.height = 30;
        this.label = new CrappUIText();

        this.addChildList([
            this.label
        ]);
    }

    override function paint() {
        super.paint();

        this.label.centerY = this.height / 2;
        this.label.x = 10;
    }

    override function updateData():Void {
        this.label.text = this.data.name;
    }

}