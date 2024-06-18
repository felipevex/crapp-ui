package test.unit.tricks.layout;

import tricks.layout.LayoutSize;
import tricks.layout.LayoutDistribution;
import tricks.layout.LayoutAlignment;
import utest.Assert;
import tricks.layout.LayoutElement;
import tricks.layout.Layout;
import utest.Test;

class LayoutVerticalDistributionJustifyTest extends Test {

    function test_layout_should_align_children_verticaly_to_justify_all_elements():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 300;
        element.height = 300;

        element.children.push(Layout.createElement());
        element.children.push(Layout.createElement());
        element.children.push(Layout.createElement());

        var expectedChildY_A:Float = 0;
        var expectedChildY_B:Float = 100;
        var expectedChildY_C:Float = 200;

        // ACT
        element.vertical = {
            alignment: LayoutAlignment.CENTER,
            distribution: LayoutDistribution.JUSTIFY
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildY_A, element.children[0].y);
        Assert.equals(expectedChildY_B, element.children[1].y);
        Assert.equals(expectedChildY_C, element.children[2].y);
    }

    function test_layout_should_justify_one_element_putting_on_center():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 300;
        element.height = 300;

        element.children.push(Layout.createElement());

        var expectedChildY:Float = 100;

        // ACT
        element.vertical = {
            alignment: LayoutAlignment.CENTER,
            distribution: LayoutDistribution.JUSTIFY
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildY, element.children[0].y);
    }

    function test_layout_should_justify_one_element_putting_on_center_on_both_directions():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 300;
        element.height = 300;

        element.children.push(Layout.createElement());
        element.children[0].x = 200;
        element.children[0].y = 100;

        var expectedChildX_A:Float = 0;
        var expectedChildY_A:Float = 100;
        var expectedElementWidth:Float = 100;
        var expectedElementHeight:Float = 300;

        // ACT
        element.vertical = {
            alignment: LayoutAlignment.CENTER,
            distribution: LayoutDistribution.JUSTIFY
        }

        element.horizontal = {
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