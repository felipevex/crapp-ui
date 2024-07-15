package crapp.ui.style.theme;

import haxe.ds.StringMap;
import helper.kits.StringKit;
import crapp.ui.style.data.CrappUIStyleData;
import crapp.ui.style.data.CrappUIThemeData;

class CrappUIThemeProvider {
    
    private static var THEME:CrappUIThemeProvider;
    
    public static function get():CrappUIThemeProvider {
        if (THEME == null) THEME = new CrappUIThemeProvider();
        return THEME;
    }

    private var themes:StringMap<ThemeDataFast>;

    private function new() {
        this.themes = new StringMap<ThemeDataFast>();
        this.startDefaultTheme();
    }

    private function convertToThemeFast(theme:CrappUIThemeData):ThemeDataFast {
        var result:ThemeDataFast = {
            data : theme,
            children : new StringMap<ThemeDataFast>()
        };

        if (theme.tags == null) return result;

        for (tag in theme.tags) {
            var tagFast:ThemeDataFast = {
                data : tag,
                children : new StringMap<ThemeDataFast>()
            };
            
            result.children.set(tag.tag, tagFast);

            if (tag.variants == null) continue;
            for (variant in tag.variants) {
                var variantFast:ThemeDataFast = {
                    data : variant,
                    children : new StringMap<ThemeDataFast>()
                };

                tagFast.children.set(variant.variant, variantFast);
            }
        }

        return result;
    }

    public function setTheme(theme:CrappUIThemeData):Void this.themes.set(theme.theme, this.convertToThemeFast(theme));
    public function hasTheme(theme:String):Bool return this.themes.exists(theme);

    private function startDefaultTheme():Void {
        var defaultTheme:CrappUIThemeData = createDefaultTheme();
        this.setTheme(defaultTheme);
    }

    private function createDefaultStyleData():CrappUIStyleData {
        return {
            color : 0xFFFFFF,
            on_color : 0x4A6DE5,
            size : 13.0,
            space : 10,
            font_family : 'Saira, Open Sans',
            corners : 6,
            on_focus_weight : 0.06
        };
    }

    private function createDefaultTheme():CrappUIThemeData {
        var defaultStyle:CrappUIStyleData = this.createDefaultStyleData();
        
        var theme:CrappUIThemeData = {
            theme : 'default',

            color : defaultStyle.color,
            on_color : defaultStyle.on_color,
            size : defaultStyle.size,
            space : defaultStyle.space,
            font_family : defaultStyle.font_family,
            corners : defaultStyle.corners,
            on_focus_weight : defaultStyle.on_focus_weight,

            tags : []
        };

        return theme;
    }

    public function getStyleData(?theme:String, ?tag:String, ?variant:String, ?includeDefault:Bool = true):CrappUIStyleData {
        if (includeDefault && (StringKit.isEmpty(theme) || !this.hasTheme(theme))) theme = 'default';

        var result:CrappUIStyleData = includeDefault ? this.createDefaultStyleData() : {};

        var themeFast:ThemeDataFast = StringKit.isEmpty(theme) ? null : this.themes.get(theme);
        var tagFast:ThemeDataFast = themeFast == null || StringKit.isEmpty(tag) ? null : themeFast.children.get(tag);
        var variantFast:ThemeDataFast = tagFast == null || StringKit.isEmpty(variant) ? null : tagFast.children.get(variant);
        
        result = themeFast == null ? result : this.mergeStyles(result, themeFast.data);
        result = tagFast == null ? result : this.mergeStyles(result, tagFast.data);
        result = variantFast == null ? result : this.mergeStyles(result, variantFast.data);
        
        return result;
    }

    public function crush(styles:Array<CrappUIStyleData>):CrappUIStyleData {
        var result:CrappUIStyleData = this.createDefaultStyleData();
        for (style in styles) result = this.mergeStyles(result, style);
        return result;
    }

    private function mergeStyles(mergeFrom:CrappUIStyleData, mergeWith:CrappUIStyleData):CrappUIStyleData {
        return {
            color : mergeWith.color != null ? mergeWith.color : mergeFrom.color,
            on_color : mergeWith.on_color != null ? mergeWith.on_color : mergeFrom.on_color,
            size : mergeWith.size != null ? mergeWith.size : mergeFrom.size,
            space : mergeWith.space != null ? mergeWith.space : mergeFrom.space,
            font_family : mergeWith.font_family != null ? mergeWith.font_family : mergeFrom.font_family,
            corners : mergeWith.corners != null ? mergeWith.corners : mergeFrom.corners,
            on_focus_weight : mergeWith.on_focus_weight != null ? mergeWith.on_focus_weight : mergeFrom.on_focus_weight
        };
    }

}

private typedef ThemeDataFast = {
    var data:CrappUIStyleData;
    var children:StringMap<ThemeDataFast>;
}