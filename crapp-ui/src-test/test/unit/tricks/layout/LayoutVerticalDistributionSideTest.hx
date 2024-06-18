package test.unit.tricks.layout;

import tricks.layout.LayoutDistribution;
import tricks.layout.LayoutAlignment;
import utest.Assert;
import tricks.layout.LayoutElement;
import tricks.layout.Layout;
import utest.Test;

class LayoutVerticalDistributionSideTest extends Test {

    function test_layout_should_align_children_verticaly():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 200;
        element.height = 200;

        element.children.push(Layout.createElement());
        element.children.push(Layout.createElement());

        var expectedChildY_A:Float = 50;
        var expectedChildY_B:Float = 50;

        // ACT
        element.vertical = {
            alignment: LayoutAlignment.CENTER,
            distribution: LayoutDistribution.NONE
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildY_A, element.children[0].y);
        Assert.equals(expectedChildY_B, element.children[1].y);
    }

    function test_layout_should_align_children_center_verticaly_side_by_side():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 300;
        element.height = 300;

        element.children.push(Layout.createElement());
        element.children.push(Layout.createElement());

        var expectedChildY_A:Float = 50;
        var expectedChildY_B:Float = 150;

        // ACT
        element.vertical = {
            alignment: LayoutAlignment.CENTER,
            distribution: LayoutDistribution.SIDE
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildY_A, element.children[0].y);
        Assert.equals(expectedChildY_B, element.children[1].y);
    }

    function test_layout_should_align_children_min_verticaly_side_by_side():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 300;
        element.height = 300;

        element.children.push(Layout.createElement());
        element.children.push(Layout.createElement());

        var expectedChildY_A:Float = 0;
        var expectedChildY_B:Float = 100;

        // ACT
        element.vertical = {
            alignment: LayoutAlignment.MIN,
            distribution: LayoutDistribution.SIDE
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildY_A, element.children[0].y);
        Assert.equals(expectedChildY_B, element.children[1].y);
    }

    function test_layout_should_align_children_max_verticaly_side_by_side():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 300;
        element.height = 300;

        element.children.push(Layout.createElement());
        element.children.push(Layout.createElement());

        var expectedChildY_A:Float = 100;
        var expectedChildY_B:Float = 200;

        // ACT
        element.vertical = {
            alignment: LayoutAlignment.MAX,
            distribution: LayoutDistribution.SIDE
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildY_A, element.children[0].y);
        Assert.equals(expectedChildY_B, element.children[1].y);
    }

}