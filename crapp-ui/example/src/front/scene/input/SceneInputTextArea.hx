package front.scene.input;

import util.kit.nothing.Nothing;
import crapp.ui.style.theme.CrappUIThemeProvider;
import helper.kits.StringKit;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.input.CrappUITextAreaInput />
        <crapp.ui.display.layout.CrappUILayout />
    </imports>
    <view>
        <private:CrappUILayout hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" left="10" right="10" top="10" bottom="10" >
            <private:CrappUITextAreaInput />
            <private:CrappUITextAreaInput width="100" />
            <private:CrappUITextAreaInput value="Value Pre Defined" />
            <private:CrappUITextAreaInput label="Write your label here" />
            <private:CrappUITextAreaInput label="Disabled" disabled=":true" />
            <private:CrappUITextAreaInput id="inputChange" label="TEST INPUT CHANGE" />
            <private:CrappUITextAreaInput id="inputChangeDelay" label="TEST CHANGE WITH DELAY" />
            <private:CrappUITextAreaInput id="red" />
            <private:CrappUITextAreaInput id="small" />
            <private:CrappUITextAreaInput id="email" label="TEST EMAIL ERROR" />
            <private:CrappUITextAreaInput id="noborder" label="NO BORDER" />
            <private:CrappUILayout vLayoutSize="FIT" hLayoutSize="FLEX" hLayoutDistribution="SIDE" hLayoutGap="10" >
                <private:CrappUITextAreaInput hLayoutSize="FLEX" />
                <private:CrappUITextAreaInput hLayoutSize="FLEX" />
                <private:CrappUITextAreaInput hLayoutSize="FLEX" />
            </private:CrappUILayout>
        </private:CrappUILayout>
    </view>
</priori>
')
class SceneInputTextArea extends CrappUIScene<Nothing> {
    
    override function setup() {

        this.theme = "InputTheme";

        this.inputChange.actions.onChange = () -> {
            trace(this.inputChange.value);
            this.inputChange.label = this.inputChange.value;
        }
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