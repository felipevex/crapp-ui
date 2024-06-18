package test.unit.tricks.layout;

import tricks.layout.LayoutSize;
import tricks.layout.LayoutDistribution;
import tricks.layout.LayoutAlignment;
import utest.Assert;
import tricks.layout.LayoutElement;
import tricks.layout.Layout;
import utest.Test;

class LayoutVerticalSizeFlexTest extends Test {

    function test_layout_should_distribution_SIDE_align_MIN_with_child_size_FLEX_():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 400;
        element.height = 400;

        element.children.push(Layout.createElement());
        
        element.children.push(Layout.createElement());
        element.children[1].vertical = { size: LayoutSize.FLEX };

        element.children.push(Layout.createElement());

        var expectedChildY_A:Float = 0;
        var expectedChildY_B:Float = 100;
        var expectedChildY_C:Float = 300;

        var expectedChildHeight_A:Float = 100;
        var expectedChildHeight_B:Float = 200;
        var expectedChildHeight_C:Float = 100;

        // ACT
        element.vertical = {
            alignment: LayoutAlignment.MIN,
            distribution: LayoutDistribution.SIDE
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildY_A, element.children[0].y);
        Assert.equals(expectedChildY_B, element.children[1].y);
        Assert.equals(expectedChildY_C, element.children[2].y);

        Assert.equals(expectedChildHeight_A, element.children[0].height);
        Assert.equals(expectedChildHeight_B, element.children[1].height);
        Assert.equals(expectedChildHeight_C, element.children[2].height);
    }

    function test_layout_should_distribution_NONE_align_MIN_with_child_size_FLEX_():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 400;
        element.height = 400;

        element.children.push(Layout.createElement());
        
        element.children.push(Layout.createElement());
        element.children[1].y = 50;
        element.children[1].vertical = { size: LayoutSize.FLEX };

        element.children.push(Layout.createElement());

        var expectedChildY_A:Float = 0;
        var expectedChildY_B:Float = 0;
        var expectedChildY_C:Float = 0;

        var expectedChildHeight_A:Float = 100;
        var expectedChildHeight_B:Float = 400;
        var expectedChildHeight_C:Float = 100;

        // ACT
        element.vertical = {
            alignment: LayoutAlignment.MIN,
            distribution: LayoutDistribution.NONE
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildY_A, element.children[0].y);
        Assert.equals(expectedChildY_B, element.children[1].y);
        Assert.equals(expectedChildY_C, element.children[2].y);

        Assert.equals(expectedChildHeight_A, element.children[0].height);
        Assert.equals(expectedChildHeight_B, element.children[1].height);
        Assert.equals(expectedChildHeight_C, element.children[2].height);
    }

    function test_layout_should_distribution_NONE_align_NONE_with_child_size_FLEX_():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 400;
        element.height = 400;

        element.children.push(Layout.createElement());
        
        element.children.push(Layout.createElement());
        element.children[1].y = 50;
        element.children[1].vertical = { size: LayoutSize.FLEX };

        element.children.push(Layout.createElement());
        element.children[2].y = 50;

        var expectedChildY_A:Float = 0;
        var expectedChildY_B:Float = 0;
        var expectedChildY_C:Float = 50;

        var expectedChildHeight_A:Float = 100;
        var expectedChildHeight_B:Float = 400;
        var expectedChildHeight_C:Float = 100;

        // ACT
        element.vertical = {
            alignment: LayoutAlignment.NONE,
            distribution: LayoutDistribution.NONE
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildY_A, element.children[0].y);
        Assert.equals(expectedChildY_B, element.children[1].y);
        Assert.equals(expectedChildY_C, element.children[2].y);

        Assert.equals(expectedChildHeight_A, element.children[0].height);
        Assert.equals(expectedChildHeight_B, element.children[1].height);
        Assert.equals(expectedChildHeight_C, element.children[2].height);
    }

    function test_layout_should_distribution_JUSTIFY_align_NONE_with_child_size_FLEX_():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 400;
        element.height = 400;

        element.children.push(Layout.createElement());
        
        element.children.push(Layout.createElement());
        element.children[1].y = 50;
        element.children[1].vertical = { size: LayoutSize.FLEX };

        element.children.push(Layout.createElement());
        element.children[2].y = 50;

        var expectedChildY_A:Float = 0;
        var expectedChildY_B:Float = 100;
        var expectedChildY_C:Float = 300;

        var expectedChildHeight_A:Float = 100;
        var expectedChildHeight_B:Float = 200;
        var expectedChildHeight_C:Float = 100;

        // ACT
        element.vertical = {
            alignment: LayoutAlignment.NONE,
            distribution: LayoutDistribution.JUSTIFY
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildY_A, element.children[0].y);
        Assert.equals(expectedChildY_B, element.children[1].y);
        Assert.equals(expectedChildY_C, element.children[2].y);

        Assert.equals(expectedChildHeight_A, element.children[0].height);
        Assert.equals(expectedChildHeight_B, element.children[1].height);
        Assert.equals(expectedChildHeight_C, element.children[2].height);
    }

    function test_layout_should_distribution_JUSTIFY_gap_10_with_child_size_FLEX_():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 400;
        element.height = 400;

        element.children.push(Layout.createElement());
        
        element.children.push(Layout.createElement());
        element.children[1].vertical = { size: LayoutSize.FLEX };

        element.children.push(Layout.createElement());

        var expectedChildY_A:Float = 0;
        var expectedChildY_B:Float = 110;
        var expectedChildY_C:Float = 300;

        var expectedChildHeight_A:Float = 100;
        var expectedChildHeight_B:Float = 180;
        var expectedChildHeight_C:Float = 100;

        // ACT
        element.vertical = {
            gap : 10,
            distribution: LayoutDistribution.JUSTIFY
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildY_A, element.children[0].y);
        Assert.equals(expectedChildY_B, element.children[1].y);
        Assert.equals(expectedChildY_C, element.children[2].y);

        Assert.equals(expectedChildHeight_A, element.children[0].height);
        Assert.equals(expectedChildHeight_B, element.children[1].height);
        Assert.equals(expectedChildHeight_C, element.children[2].height);
    }

    function test_layout_should_distribution_JUSTIFY_with_child_size_FLEX_and_sub_children_FLEX():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 600;
        element.height = 600;

        element.children.push(Layout.createElement());
        element.children.push(Layout.createElement());
        element.children.push(Layout.createElement());
        
        element.children[1].children.push(Layout.createElement());
        element.children[1].children.push(Layout.createElement());
        element.children[1].children.push(Layout.createElement());

        element.children[1].vertical = { 
            size: LayoutSize.FLEX,
            distribution: LayoutDistribution.JUSTIFY
        };

        element.children[1].children[1].vertical = {
            size: LayoutSize.FLEX
        };

        var expectedChildY_A:Float = 0;
        var expectedChildY_B:Float = 100;
        var expectedChildY_BA:Float = 0;
        var expectedChildY_BB:Float = 100;
        var expectedChildY_BC:Float = 300;
        var expectedChildY_C:Float = 500;

        var expectedChildHeight_A:Float = 100;
        var expectedChildHeight_B:Float = 400;
        var expectedChildHeight_BA:Float = 100;
        var expectedChildHeight_BB:Float = 200;
        var expectedChildHeight_BC:Float = 100;
        var expectedChildHeight_C:Float = 100;

        // ACT
        element.vertical = {
            distribution: LayoutDistribution.JUSTIFY
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildY_A, element.children[0].y);
        Assert.equals(expectedChildY_B, element.children[1].y);
        Assert.equals(expectedChildY_BA, element.children[1].children[0].y);
        Assert.equals(expectedChildY_BB, element.children[1].children[1].y);
        Assert.equals(expectedChildY_BC, element.children[1].children[2].y);
        Assert.equals(expectedChildY_C, element.children[2].y);

        Assert.equals(expectedChildHeight_A, element.children[0].height);
        Assert.equals(expectedChildHeight_B, element.children[1].height);
        Assert.equals(expectedChildHeight_BA, element.children[1].children[0].height);
        Assert.equals(expectedChildHeight_BB, element.children[1].children[1].height);
        Assert.equals(expectedChildHeight_BC, element.children[1].children[2].height);
        Assert.equals(expectedChildHeight_C, element.children[2].height);
    }

}