package test.unit.tricks.layout;

import tricks.layout.LayoutSize;
import tricks.layout.LayoutDistribution;
import tricks.layout.LayoutAlignment;
import utest.Assert;
import tricks.layout.LayoutElement;
import tricks.layout.Layout;
import utest.Test;

class LayoutHorizontalDistributionJustifyTest extends Test {

    function test_layout_should_align_children_horizontaly_to_justify_all_elements():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 300;
        element.height = 300;

        element.children.push(Layout.createElement());
        element.children.push(Layout.createElement());
        element.children.push(Layout.createElement());

        var expectedChildX_A:Float = 0;
        var expectedChildX_B:Float = 100;
        var expectedChildX_C:Float = 200;

        // ACT
        element.horizontal = {
            alignment: LayoutAlignment.CENTER,
            distribution: LayoutDistribution.JUSTIFY
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildX_A, element.children[0].x);
        Assert.equals(expectedChildX_B, element.children[1].x);
        Assert.equals(expectedChildX_C, element.children[2].x);
    }

    function test_layout_should_justify_one_element_putting_on_center():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 300;
        element.height = 300;

        element.children.push(Layout.createElement());

        var expectedChildX_A:Float = 100;

        // ACT
        element.horizontal = {
            alignment: LayoutAlignment.CENTER,
            distribution: LayoutDistribution.JUSTIFY
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildX_A, element.children[0].x);
    }

    function test_layout_should_justify_one_element_putting_on_center_on_both_directions():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 300;
        element.height = 300;

        element.children.push(Layout.createElement());
        element.children[0].x = 100;
        element.children[0].y = 200;

        var expectedChildX_A:Float = 100;
        var expectedChildY_A:Float = 0;
        var expectedElementWidth:Float = 300;
        var expectedElementHeight:Float = 100;

        // ACT
        element.horizontal = {
            alignment: LayoutAlignment.CENTER,
            distribution: LayoutDistribution.JUSTIFY
        }

        element.vertical = {
            size : LayoutSize.FIT,
            alignment: LayoutAlignment.CENTER
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildX_A, element.children[0].x);
        Assert.equals(expectedChildY_A, element.children[0].y);
        Assert.equals(expectedElementWidth, element.width);
        Assert.equals(expectedElementHeight, element.height);
    }

}