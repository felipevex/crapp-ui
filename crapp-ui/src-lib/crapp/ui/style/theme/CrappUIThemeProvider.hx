package crapp.ui.style.theme;

import crapp.ui.style.types.CrappUIStyleFontWeightType;
import crapp.ui.event.CrappUIEventType;
import haxe.ds.StringMap;
import helper.kits.StringKit;
import crapp.ui.style.data.CrappUIStyleData;
import crapp.ui.style.data.CrappUIThemeData;

class CrappUIThemeProvider {
    
    private static var THEME:CrappUIThemeProvider;
    private static var DEFAULT_STYLE:CrappUIStyleData;
    
    public static function get():CrappUIThemeProvider {
        if (THEME == null) THEME = new CrappUIThemeProvider();
        return THEME;
    }

    private var themes:StringMap<ThemeDataFast>;

    private function new() {
        this.themes = new StringMap<ThemeDataFast>();
        this.setDefaultStyle({});
    }

    public function setDefaultStyle(style:CrappUIStyleData):Void {
        var result:CrappUIStyleData = {
            color : 0xFFFFFF,
            on_color : 0x4A6DE5,
            size : 13.0,
            space : 10,
            font_family : 'Saira, Open Sans',
            font_weight : CrappUIStyleFontWeightType.NORMAL,
            corners : 6,
            on_focus_weight : 0.06
        };

        result = this.mergeStyles(result, style);

        DEFAULT_STYLE = result;
    }

    private function getDefaultStyle():CrappUIStyleData {
        return DEFAULT_STYLE;
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
            
            result.children.set(tag.tag.toLowerCase(), tagFast);

            if (tag.variants == null) continue;
            for (variant in tag.variants) {
                var variantFast:ThemeDataFast = {
                    data : variant,
                    children : new StringMap<ThemeDataFast>()
                };

                tagFast.children.set(variant.variant.toLowerCase(), variantFast);
            }
        }

        return result;
    }

    public function setTheme(theme:CrappUIThemeData):Void {
        this.themes.set(theme.theme, this.convertToThemeFast(theme));
        #if js
        priori.app.PriApp.g().dispatchEvent(new priori.event.PriEvent(CrappUIEventType.STYLE_CHANGE, true, false));
        #end
    }
    public function hasTheme(theme:String):Bool return this.themes.exists(theme);

    public function getStyleBreaked(theme:String, tag:String, variant:String):Array<CrappUIStyleData> {
        var result:Array<CrappUIStyleData> = [];

        var themeFast:ThemeDataFast = StringKit.isEmpty(theme) ? null : this.themes.get(theme);
        result.push(themeFast == null ? null : themeFast.data);

        var tagFast:ThemeDataFast = themeFast == null || StringKit.isEmpty(tag) ? null : themeFast.children.get(tag.toLowerCase());
        result.push(tagFast == null ? null : tagFast.data);

        var variantFast:ThemeDataFast = tagFast == null || StringKit.isEmpty(variant) ? null : tagFast.children.get(variant.toLowerCase());
        result.push(variantFast == null ? null : variantFast.data);
        
        return result;
    }

    public function getStyleData(?theme:String, ?tag:String, ?variant:String, ?includeDefault:Bool = true):CrappUIStyleData {
        var breaks:Array<CrappUIStyleData> = this.getStyleBreaked(theme, tag, variant);
        var result:CrappUIStyleData = this.crush(breaks, includeDefault);
        
        return result;
    }

    public function crush(styles:Array<CrappUIStyleData>, ?includeDefault:Bool = true):CrappUIStyleData {
        var result:CrappUIStyleData = includeDefault ? this.getDefaultStyle() : {};

        for (style in styles) if (style != null) result = this.mergeStyles(result, style);
        return result;
    }

    inline private function mergeStyles(mergeFrom:CrappUIStyleData, mergeWith:CrappUIStyleData):CrappUIStyleData {
        return {
            color : mergeWith.color != null ? mergeWith.color : mergeFrom.color,
            on_color : mergeWith.on_color != null ? mergeWith.on_color : mergeFrom.on_color,
            size : mergeWith.size != null ? mergeWith.size : mergeFrom.size,
            space : mergeWith.space != null ? mergeWith.space : mergeFrom.space,
            font_family : mergeWith.font_family != null ? mergeWith.font_family : mergeFrom.font_family,
            font_weight : mergeWith.font_weight != null ? mergeWith.font_weight : mergeFrom.font_weight,
            corners : mergeWith.corners != null ? mergeWith.corners : mergeFrom.corners,
            on_focus_weight : mergeWith.on_focus_weight != null ? mergeWith.on_focus_weight : mergeFrom.on_focus_weight
        };
    }

}

private typedef ThemeDataFast = {
    var data:CrappUIStyleData;
    var children:StringMap<ThemeDataFast>;
}