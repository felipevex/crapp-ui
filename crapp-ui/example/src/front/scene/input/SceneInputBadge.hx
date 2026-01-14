package front.scene.input;

import priori.geom.PriColor;
import crapp.ui.display.input.CrappUIBadgeInput;
import util.kit.nothing.Nothing;
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
            <private:CrappUIBadgeInput id="input1" label="Fruits" width="500" />
            <private:CrappUIBadgeInput id="input2" label="Label Transformation" hLayoutSize="FLEX" />
            <private:CrappUIBadgeInput id="input3" label="Colored Labels" hLayoutSize="FLEX" />
            <private:CrappUIBadgeInput id="input4" label="On Change Print" hLayoutSize="FLEX" />
            <private:CrappUIBadgeInput id="input5" label="Pre defined Option Data" hLayoutSize="FLEX" />
            <private:CrappUIBadgeInput id="input6" label="Pre defined Option Data and cannot create new ones" hLayoutSize="FLEX" />
        </private:CrappUILayout>
    </view>
</priori>
')
class SceneInputBadge extends CrappUIScene<Nothing> {

    override function setup() {

        var colors:Array<PriColor> = [
            0xe67d7d, 0xec933a, 0xFFF200, 0x56E03B, 0x17f6d8, 0x56a1ec, 0x7e54f1, 0xb460de, 0xe75ca9, 0xf36067,
            0xc45a5a, 0xca7521, 0xC2B809, 0x1DA80E, 0x0baa95, 0x2165a9, 0x4d27b6, 0x7d24a9, 0xac2c72, 0xb3262d,
            0x8d2a2a, 0x975412, 0x727E08, 0x16680D, 0x0d6f62, 0x103e6b, 0x301086, 0x561178, 0x690c3f, 0x740b11,
            0x777777, 0x959595, 0x4F4F4F, 0x3B3B3B
        ];


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

        this.input3.colors = colors;

        this.input4.actions.onChange = () -> {
            trace('Current Badges: ' + this.input4.value);
        };


        this.input5.data = [
            "FIAT",
            "Ford",
            "Chevrolet",
            "Volkswagen",
            "Honda",
            "Toyota",
            "Hyundai",
            "Nissan",
            "Renault",
            "Peugeot",
            "Citroën"
        ];

        this.input6.data = this.input5.data;
        this.input6.allowCreateValues = false;

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