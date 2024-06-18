package test.unit.tricks.layout;

import tricks.layout.LayoutSize;
import tricks.layout.LayoutDistribution;
import tricks.layout.LayoutAlignment;
import utest.Assert;
import tricks.layout.LayoutElement;
import tricks.layout.Layout;
import utest.Test;

class LayoutHorizontalGapTest extends Test {

    function test_layout_should_distribute_SIDE_with_GAP_10_align_MIN():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 400;
        element.height = 400;

        element.children.push(Layout.createElement());
        element.children.push(Layout.createElement());
        element.children.push(Layout.createElement());

        var expectedChildX_A:Float = 0;
        var expectedChildX_B:Float = 110;
        var expectedChildX_C:Float = 220;

        // ACT
        element.horizontal = {
            gap : 10,
            alignment: LayoutAlignment.MIN,
            distribution: LayoutDistribution.SIDE
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildX_A, element.children[0].x);
        Assert.equals(expectedChildX_B, element.children[1].x);
        Assert.equals(expectedChildX_C, element.children[2].x);
    }

    function test_layout_should_distribute_SIDE_with_GAP_10_align_MAX():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 400;
        element.height = 400;

        element.children.push(Layout.createElement());
        element.children.push(Layout.createElement());
        element.children.push(Layout.createElement());

        var expectedChildX_A:Float = 80;
        var expectedChildX_B:Float = 190;
        var expectedChildX_C:Float = 300;

        // ACT
        element.horizontal = {
            gap : 10,
            alignment: LayoutAlignment.MAX,
            distribution: LayoutDistribution.SIDE
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildX_A, element.children[0].x);
        Assert.equals(expectedChildX_B, element.children[1].x);
        Assert.equals(expectedChildX_C, element.children[2].x);
    }

    function test_layout_should_distribute_SIDE_with_GAP_10_align_CENTER():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 400;
        element.height = 400;

        element.children.push(Layout.createElement());
        element.children.push(Layout.createElement());
        element.children.push(Layout.createElement());

        var expectedChildX_A:Float = 40;
        var expectedChildX_B:Float = 150;
        var expectedChildX_C:Float = 260;

        // ACT
        element.horizontal = {
            gap : 10,
            alignment: LayoutAlignment.CENTER,
            distribution: LayoutDistribution.SIDE
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildX_A, element.children[0].x);
        Assert.equals(expectedChildX_B, element.children[1].x);
        Assert.equals(expectedChildX_C, element.children[2].x);
    }

    function test_layout_should_distribute_JUSTIFY_with_GAP_10():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 400;
        element.height = 400;

        element.children.push(Layout.createElement());
        element.children.push(Layout.createElement());
        element.children.push(Layout.createElement());

        var expectedChildX_A:Float = 0;
        var expectedChildX_B:Float = 150;
        var expectedChildX_C:Float = 300;

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
        
    }

    function test_layout_should_distribute_JUSTIFY_with_GAP_10_size_FIT():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 400;
        element.height = 400;

        element.children.push(Layout.createElement());
        element.children.push(Layout.createElement());
        element.children.push(Layout.createElement());

        var expectedElementSize:Float = 320;
        var expectedChildX_A:Float = 0;
        var expectedChildX_B:Float = 110;
        var expectedChildX_C:Float = 220;

        // ACT
        element.horizontal = {
            gap : 10,
            size : LayoutSize.FIT,
            distribution: LayoutDistribution.JUSTIFY
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildX_A, element.children[0].x);
        Assert.equals(expectedChildX_B, element.children[1].x);
        Assert.equals(expectedChildX_C, element.children[2].x);
        Assert.equals(expectedElementSize, element.width);
    }


}