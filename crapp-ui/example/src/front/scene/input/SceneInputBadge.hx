package front.scene.input;

import crapp.ui.display.input.CrappUIBadgeInput;
import util.kit.nothing.Nothing;
import crapp.ui.style.theme.CrappUIThemeProvider;
import helper.kits.StringKit;
import crapp.ui.display.app.CrappUIScene;

@priori('
<priori>
    <imports>
        <crapp.ui.display.input.CrappUIBadgeInput />
        <crapp.ui.display.layout.CrappUILayout />
    </imports>
    <view>
        <private:CrappUILayout hLayoutAlignment="CENTER" vLayoutDistribution="SIDE" vLayoutGap="10" left="10" right="10" top="10" bottom="10" >
            <private:CrappUIBadgeInput />
            <private:CrappUIBadgeInput label="Badge Input" />
            <private:CrappUIBadgeInput width="500" />
            <private:CrappUIBadgeInput id="input1" label="Fruits" width="500" />
            <private:CrappUIBadgeInput id="input2" label="Label Transformation" width="500" />
        </private:CrappUILayout>
    </view>
</priori>
')
class SceneInputBadge extends CrappUIScene<Nothing> {

    override function setup() {

        this.input1.value = [
            "Apple",
            "Banana",
            "Orange",
            "Apple"     // Itens duplicados serão ignorados
        ];

        this.input2.badgeLabelTransformation = (value:String) -> {
            // Transformação personalizada: remove espaços e converte para minúsculas
            if (value == null) return "";
            value = StringKit.trim(value); // Remove espaços em branco nas extremidades
            value = StringKit.replace(value, [" "], "-"); // Substitui espaços internos por hífens
            value = value.toLowerCase(); // Torna minúsculo
            return value;
        };
        this.input2.value = ["Hello World"];



        // this.theme = "InputTheme";

        // this.inputChange.actions.onChange = () -> this.inputChange.label = this.inputChange.value;
        // this.inputChangeDelay.actions.onDelayedChange = () -> this.inputChangeDelay.label = this.inputChangeDelay.value;

        // this.red.style = {
        //     color: 0xFF0000,
        //     on_color: 0xFFFFFF
        // };

        // this.noborder.style = {
        //     prevent_border : true
        // };

        // haxe.Timer.delay(() -> {
        //     this.small.style = {
        //         size: 10
        //     }
        // }, 2000);

        // this.email.addValidation((value:String) -> {
        //     if (!StringKit.isEmail(value)) throw "Invalid Email";
        // });

        // CrappUIThemeProvider.get().setTheme({
        //     theme : "InputTheme",
        //     tags: [
        //         {
        //             tag : "TEXT_ICON",
        //             variants : [
        //                 {
        //                     variant: "ERROR",
        //                     color: 0xFF0000,
        //                     on_color: 0xFFFFFF,
        //                     size : 10
        //                 }
        //             ]
        //         }
        //     ]
        // });
    }

}