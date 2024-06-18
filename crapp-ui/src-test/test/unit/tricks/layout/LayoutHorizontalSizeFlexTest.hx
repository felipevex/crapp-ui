package test.unit.tricks.layout;

import tricks.layout.LayoutSize;
import tricks.layout.LayoutDistribution;
import tricks.layout.LayoutAlignment;
import utest.Assert;
import tricks.layout.LayoutElement;
import tricks.layout.Layout;
import utest.Test;

class LayoutHorizontalSizeFlexTest extends Test {

    function test_layout_should_distribution_SIDE_align_MIN_with_child_size_FLEX_():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 400;
        element.height = 400;

        element.children.push(Layout.createElement());
        
        element.children.push(Layout.createElement());
        element.children[1].horizontal = { size: LayoutSize.FLEX };

        element.children.push(Layout.createElement());

        var expectedChildX_A:Float = 0;
        var expectedChildX_B:Float = 100;
        var expectedChildX_C:Float = 300;

        var expectedChildWidth_A:Float = 100;
        var expectedChildWidth_B:Float = 200;
        var expectedChildWidth_C:Float = 100;

        // ACT
        element.horizontal = {
            alignment: LayoutAlignment.MIN,
            distribution: LayoutDistribution.SIDE
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildX_A, element.children[0].x);
        Assert.equals(expectedChildX_B, element.children[1].x);
        Assert.equals(expectedChildX_C, element.children[2].x);

        Assert.equals(expectedChildWidth_A, element.children[0].width);
        Assert.equals(expectedChildWidth_B, element.children[1].width);
        Assert.equals(expectedChildWidth_C, element.children[2].width);
    }

    function test_layout_should_distribution_NONE_align_MIN_with_child_size_FLEX_():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 400;
        element.height = 400;

        element.children.push(Layout.createElement());
        
        element.children.push(Layout.createElement());
        element.children[1].x = 50;
        element.children[1].horizontal = { size: LayoutSize.FLEX };

        element.children.push(Layout.createElement());

        var expectedChildX_A:Float = 0;
        var expectedChildX_B:Float = 0;
        var expectedChildX_C:Float = 0;

        var expectedChildWidth_A:Float = 100;
        var expectedChildWidth_B:Float = 400;
        var expectedChildWidth_C:Float = 100;

        // ACT
        element.horizontal = {
            alignment: LayoutAlignment.MIN,
            distribution: LayoutDistribution.NONE
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildX_A, element.children[0].x);
        Assert.equals(expectedChildX_B, element.children[1].x);
        Assert.equals(expectedChildX_C, element.children[2].x);

        Assert.equals(expectedChildWidth_A, element.children[0].width);
        Assert.equals(expectedChildWidth_B, element.children[1].width);
        Assert.equals(expectedChildWidth_C, element.children[2].width);
    }

    function test_layout_should_distribution_NONE_align_NONE_with_child_size_FLEX_():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 400;
        element.height = 400;

        element.children.push(Layout.createElement());
        
        element.children.push(Layout.createElement());
        element.children[1].x = 50;
        element.children[1].horizontal = { size: LayoutSize.FLEX };

        element.children.push(Layout.createElement());
        element.children[2].x = 50;

        var expectedChildX_A:Float = 0;
        var expectedChildX_B:Float = 0;
        var expectedChildX_C:Float = 50;

        var expectedChildWidth_A:Float = 100;
        var expectedChildWidth_B:Float = 400;
        var expectedChildWidth_C:Float = 100;

        // ACT
        element.horizontal = {
            alignment: LayoutAlignment.NONE,
            distribution: LayoutDistribution.NONE
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildX_A, element.children[0].x);
        Assert.equals(expectedChildX_B, element.children[1].x);
        Assert.equals(expectedChildX_C, element.children[2].x);

        Assert.equals(expectedChildWidth_A, element.children[0].width);
        Assert.equals(expectedChildWidth_B, element.children[1].width);
        Assert.equals(expectedChildWidth_C, element.children[2].width);
    }

    function test_layout_should_distribution_JUSTIFY_align_NONE_with_child_size_FLEX_():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 400;
        element.height = 400;

        element.children.push(Layout.createElement());
        
        element.children.push(Layout.createElement());
        element.children[1].x = 50;
        element.children[1].horizontal = { size: LayoutSize.FLEX };

        element.children.push(Layout.createElement());
        element.children[2].x = 50;

        var expectedChildX_A:Float = 0;
        var expectedChildX_B:Float = 100;
        var expectedChildX_C:Float = 300;

        var expectedChildWidth_A:Float = 100;
        var expectedChildWidth_B:Float = 200;
        var expectedChildWidth_C:Float = 100;

        // ACT
        element.horizontal = {
            alignment: LayoutAlignment.NONE,
            distribution: LayoutDistribution.JUSTIFY
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildX_A, element.children[0].x);
        Assert.equals(expectedChildX_B, element.children[1].x);
        Assert.equals(expectedChildX_C, element.children[2].x);

        Assert.equals(expectedChildWidth_A, element.children[0].width);
        Assert.equals(expectedChildWidth_B, element.children[1].width);
        Assert.equals(expectedChildWidth_C, element.children[2].width);
    }

    function test_layout_should_distribution_JUSTIFY_gap_10_with_child_size_FLEX_():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 400;
        element.height = 400;

        element.children.push(Layout.createElement());
        
        element.children.push(Layout.createElement());
        element.children[1].horizontal = { size: LayoutSize.FLEX };

        element.children.push(Layout.createElement());

        var expectedChildX_A:Float = 0;
        var expectedChildX_B:Float = 110;
        var expectedChildX_C:Float = 300;

        var expectedChildWidth_A:Float = 100;
        var expectedChildWidth_B:Float = 180;
        var expectedChildWidth_C:Float = 100;

        // ACT
        element.horizontal = {
            gap : 10,
            distribution: LayoutDistribution.JUSTIFY
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildX_A, element.children[0].x);
        Assert.equals(expectedChildX_B, element.children[1].x);
        Assert.equals(expectedChildX_C, element.children[2].x);

        Assert.equals(expectedChildWidth_A, element.children[0].width);
        Assert.equals(expectedChildWidth_B, element.children[1].width);
        Assert.equals(expectedChildWidth_C, element.children[2].width);
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

        element.children[1].horizontal = { 
            size: LayoutSize.FLEX,
            distribution: LayoutDistribution.JUSTIFY
        };

        element.children[1].children[1].horizontal = {
            size: LayoutSize.FLEX
        };

        var expectedChildX_A:Float = 0;
        var expectedChildX_B:Float = 100;
        var expectedChildX_BA:Float = 0;
        var expectedChildX_BB:Float = 100;
        var expectedChildX_BC:Float = 300;
        var expectedChildX_C:Float = 500;

        var expectedChildWidth_A:Float = 100;
        var expectedChildWidth_B:Float = 400;
        var expectedChildWidth_BA:Float = 100;
        var expectedChildWidth_BB:Float = 200;
        var expectedChildWidth_BC:Float = 100;
        var expectedChildWidth_C:Float = 100;

        // ACT
        element.horizontal = {
            distribution: LayoutDistribution.JUSTIFY
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildX_A, element.children[0].x);
        Assert.equals(expectedChildX_B, element.children[1].x);
        Assert.equals(expectedChildX_BA, element.children[1].children[0].x);
        Assert.equals(expectedChildX_BB, element.children[1].children[1].x);
        Assert.equals(expectedChildX_BC, element.children[1].children[2].x);
        Assert.equals(expectedChildX_C, element.children[2].x);

        Assert.equals(expectedChildWidth_A, element.children[0].width);
        Assert.equals(expectedChildWidth_B, element.children[1].width);
        Assert.equals(expectedChildWidth_BA, element.children[1].children[0].width);
        Assert.equals(expectedChildWidth_BB, element.children[1].children[1].width);
        Assert.equals(expectedChildWidth_BC, element.children[1].children[2].width);
        Assert.equals(expectedChildWidth_C, element.children[2].width);
    }

}