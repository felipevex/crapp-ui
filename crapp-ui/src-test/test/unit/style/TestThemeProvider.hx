package test.unit.style;

import crapp.ui.style.types.CrappUIStyleFontWeightType;
import crapp.ui.style.data.CrappUIThemeData;
import crapp.ui.style.data.CrappUIStyleData;
import utest.Assert;
import crapp.ui.style.theme.CrappUIThemeProvider;
import utest.Test;

@:access(crapp.ui.style.theme.CrappUIThemeProvider)
class TestThemeProvider extends Test {

    function test_provider_merge_style_data() {
        // ARRANGE
        var provider = CrappUIThemeProvider.get();
        
        var valueMergeFrom:CrappUIStyleData = {
            color : 0xFFFFFF,
            on_color : 0x4A6DE5,
            size : 13.0,
            space : 10,
            font_family : 'Saira, Open Sans',
            font_weight: CrappUIStyleFontWeightType.NORMAL,
            corners : 6,
            on_focus_weight : 0.06,
            prevent_border : false
        }

        var valueMergeWith:CrappUIStyleData = {
            color : 0xFFFFFF,
            on_color : 0xE54AB4,
            size : 15.0
        }
        
        var expected:CrappUIStyleData = {
            color : 0xFFFFFF,
            on_color : 0xE54AB4,
            size : 15.0,
            space : 10,
            font_family : 'Saira, Open Sans',
            font_weight: CrappUIStyleFontWeightType.NORMAL,
            corners : 6,
            on_focus_weight : 0.06,
            prevent_border : false
        }

        var result:CrappUIStyleData;

        // ACT
        result = provider.mergeStyles(valueMergeFrom, valueMergeWith);

        // ASSERT
        Assert.same(expected, result);
    }
    
    function test_provider_get_the_most_basic_style_data() {
        // ARRANGE
        var provider = CrappUIThemeProvider.get();
        
        var expected:CrappUIStyleData = {
            color : 0xFFFFFF,
            on_color : 0x4A6DE5,
            size : 13.0,
            space : 10,
            font_family : 'Saira, Open Sans',
            font_weight: CrappUIStyleFontWeightType.NORMAL,
            corners : 6,
            on_focus_weight : 0.06,
            prevent_border : false
        }

        var result:CrappUIStyleData;

        // ACT
        result = provider.getStyleData();

        // ASSERT
        Assert.same(expected, result);
    }

    function test_provider_get_basic_theme_from_new_theme() {
        // ARRANGE
        var provider = CrappUIThemeProvider.get();
        
        var valueThemeName:String = 'new';
        var valueThemeNew:CrappUIThemeData = {
            theme : "new",

            color : 0x30B921,
            on_color : 0xA12051,
            
            tags : []
        }

        var expected:CrappUIStyleData = {
            color : 0x30B921,
            on_color : 0xA12051,
            size : 13.0,
            space : 10,
            font_family : 'Saira, Open Sans',
            font_weight: CrappUIStyleFontWeightType.NORMAL,
            corners : 6,
            on_focus_weight : 0.06,
            prevent_border : false
        }

        var result:CrappUIStyleData;

        // ACT
        provider.setTheme(valueThemeNew);
        result = provider.getStyleData(valueThemeName);

        // ASSERT
        Assert.same(expected, result);
    }

    function test_provider_get_basic_theme_from_new_theme_on_undefined_tag() {
        // ARRANGE
        var provider = CrappUIThemeProvider.get();
        
        var valueThemeName:String = 'new';
        var valueTagName:String = 'tag';

        var valueThemeNew:CrappUIThemeData = {
            theme : "new",

            color : 0x30B921,
            on_color : 0xA12051,
            
            tags : []
        }

        var expected:CrappUIStyleData = {
            color : 0x30B921,
            on_color : 0xA12051,
            size : 13.0,
            space : 10,
            font_family : 'Saira, Open Sans',
            font_weight: CrappUIStyleFontWeightType.NORMAL,
            corners : 6,
            on_focus_weight : 0.06,
            prevent_border : false
        }

        var result:CrappUIStyleData;

        // ACT
        provider.setTheme(valueThemeNew);
        result = provider.getStyleData(valueThemeName, valueTagName);

        // ASSERT
        Assert.same(expected, result);
    }

    function test_provider_get_basic_theme_from_new_theme_on_created_tag() {
        // ARRANGE
        var provider = CrappUIThemeProvider.get();
        
        var valueThemeName:String = 'new';
        var valueTagName:String = 'tag';

        var valueThemeNew:CrappUIThemeData = {
            theme : "new",

            color : 0x30B921,
            on_color : 0xA12051,
            
            tags : [
                {
                    tag : 'tag',
                    size : 15.0,
                }
            ]
        }

        var expected:CrappUIStyleData = {
            color : 0x30B921,
            on_color : 0xA12051,
            size : 15.0,
            space : 10,
            font_family : 'Saira, Open Sans',
            font_weight: CrappUIStyleFontWeightType.NORMAL,
            corners : 6,
            on_focus_weight : 0.06,
            prevent_border : false
        }

        var result:CrappUIStyleData;

        // ACT
        provider.setTheme(valueThemeNew);
        result = provider.getStyleData(valueThemeName, valueTagName);

        // ASSERT
        Assert.same(expected, result);
    }

    function test_provider_get_basic_theme_from_new_theme_on_created_tag_and_variant() {
        // ARRANGE
        var provider = CrappUIThemeProvider.get();
        
        var valueThemeName:String = 'new';
        var valueTagName:String = 'tag';
        var valueVariantName:String = 'variant';

        var valueThemeNew:CrappUIThemeData = {
            theme : "new",

            color : 0x30B921,
            on_color : 0xA12051,
            
            tags : [
                {
                    tag : 'tag',
                    size : 15.0,
                    variants: [
                        {
                            variant : 'variant',
                            color: 0x000000
                        }
                    ]
                }
            ]
        }

        var expected:CrappUIStyleData = {
            color : 0x000000,
            on_color : 0xA12051,
            size : 15.0,
            space : 10,
            font_family : 'Saira, Open Sans',
            font_weight: CrappUIStyleFontWeightType.NORMAL,
            corners : 6,
            on_focus_weight : 0.06,
            prevent_border : false
        }

        var result:CrappUIStyleData;

        // ACT
        provider.setTheme(valueThemeNew);
        result = provider.getStyleData(valueThemeName, valueTagName, valueVariantName);

        // ASSERT
        Assert.same(expected, result);
    }

}