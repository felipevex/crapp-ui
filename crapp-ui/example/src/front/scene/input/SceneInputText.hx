package front.scene.input;

import crapp.ui.style.theme.CrappUIThemeProvider;
import helper.kits.StringKit;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.input.CrappUITextInput />
        <crapp.ui.display.layout.CrappUILayotable />
    </imports>
    <view>
        <private:CrappUILayotable hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" left="10" right="10" top="10" bottom="10" >
            <private:CrappUITextInput />
            <private:CrappUITextInput width="100" />
            <private:CrappUITextInput value="Value Pre Defined" />
            <private:CrappUITextInput label="Write your label here" />
            <private:CrappUITextInput label="Disabled" disabled=":true" />
            <private:CrappUITextInput id="inputChange" label="TEST INPUT CHANGE" />
            <private:CrappUITextInput id="inputChangeDelay" label="TEST CHANGE WITH DELAY" />
            <private:CrappUITextInput id="red" />
            <private:CrappUITextInput id="small" />
            <private:CrappUITextInput label="PASSWORD" password=":true" />
            <private:CrappUITextInput id="email" label="TEST EMAIL ERROR" />
            <private:CrappUITextInput id="noborder" label="NO BORDER" />
            <private:CrappUILayotable vLayoutSize="FIT" hLayoutSize="FLEX" hLayoutDistribution="SIDE" hLayoutGap="10" >
                <private:CrappUITextInput hLayoutSize="FLEX" />
                <private:CrappUITextInput hLayoutSize="FLEX" />
                <private:CrappUITextInput hLayoutSize="FLEX" />
            </private:CrappUILayotable>
        </private:CrappUILayotable>
    </view>
</priori>
')
class SceneInputText extends CrappUIScene {
    
    override function setup() {

        this.theme = "InputTheme";

        this.inputChange.actions.onChange = () -> this.inputChange.label = this.inputChange.value;
        this.inputChangeDelay.actions.onDelayedChange = () -> this.inputChangeDelay.label = this.inputChangeDelay.value;
        
        this.red.style = {
            color: 0xFF0000,
            on_color: 0xFFFFFF
        };

        this.noborder.style = {
            prevent_border : true
        };
        
        haxe.Timer.delay(() -> {
            this.small.style = {
                size: 10
            }
        }, 2000);
        
        this.email.addValidation((value:String) -> {
            if (!StringKit.isEmail(value)) throw "Invalid Email";
        });

        CrappUIThemeProvider.get().setTheme({
            theme : "InputTheme",
            tags: [
                {
                    tag : "TEXT_ICON",
                    variants : [
                        {
                            variant: "ERROR",
                            color: 0xFF0000,
                            on_color: 0xFFFFFF,
                            size : 10
                        }
                    ]
                }
            ]
        });
    }

}