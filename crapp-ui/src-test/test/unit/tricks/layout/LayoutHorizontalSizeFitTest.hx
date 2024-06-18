package test.unit.tricks.layout;

import tricks.layout.LayoutSize;
import tricks.layout.LayoutDistribution;
import tricks.layout.LayoutAlignment;
import utest.Assert;
import tricks.layout.LayoutElement;
import tricks.layout.Layout;
import utest.Test;

class LayoutHorizontalSizeFitTest extends Test {

    function test_layout_get_the_size_from_children_with_distribution_NONE():Void {
        // ARRANGE
        var layout:Layout = new Layout();

        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 300;
        element.height = 300;

        element.children.push(Layout.createElement());
        element.children[0].x = 50;

        element.children.push(Layout.createElement());
        element.children[1].x = 100;

        var expectedChildX_A:Float = 50;
        var expectedChildX_B:Float = 100;
        var expectedElementWidth:Float = 200;

        // ACT
        element.horizontal = {
            size : LayoutSize.FIT,
            distribution: LayoutDistribution.NONE
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildX_A, element.children[0].x);
        Assert.equals(expectedChildX_B, element.children[1].x);
        Assert.equals(expectedElementWidth, element.width);
    }

    function test_layout_get_the_size_from_children_with_distribution_SIDE():Void {
        // ARRANGE
        var layout:Layout = new Layout();

        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 300;
        element.height = 300;

        element.children.push(Layout.createElement());
        element.children.push(Layout.createElement());

        var expectedChildX_A:Float = 0;
        var expectedChildX_B:Float = 100;
        var expectedElementWidth:Float = 200;

        // ACT
        element.horizontal = {
            size : LayoutSize.FIT,
            distribution: LayoutDistribution.SIDE
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildX_A, element.children[0].x);
        Assert.equals(expectedChildX_B, element.children[1].x);
        Assert.equals(expectedElementWidth, element.width);
    }

    function test_layout_get_the_size_from_children_with_no_children_has_zero_size():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 300;
        element.height = 300;
        element.children = null;

        var expectedElementWidth:Float = 0;

        // ACT
        element.horizontal = {
            size : LayoutSize.FIT
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedElementWidth, element.width);
    }

    function test_layout_should_align_children_with_different_sizes_and_positions_on_center_and_size_fits():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 200;
        element.height = 200;

        element.children.push(Layout.createElement());
        element.children[0].x = 80;
        element.children[0].y = 10;
        element.children[0].width = 50;
        
        element.children.push(Layout.createElement());
        element.children[1].x = 10;
        element.children[1].y = 30;
        element.children[1].width = 30;
        
        var expectedChildX_A:Float = 0;
        var expectedChildY_A:Float = 10;
        var expectedChildX_B:Float = 10;
        var expectedChildY_B:Float = 30;
        var expectedContainerWidth:Float = 50;

        // ACT
        element.horizontal = {
            alignment: LayoutAlignment.CENTER,
            size : LayoutSize.FIT
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildX_A, element.children[0].x);
        Assert.equals(expectedChildY_A, element.children[0].y);

        Assert.equals(expectedChildX_B, element.children[1].x);
        Assert.equals(expectedChildY_B, element.children[1].y);

        Assert.equals(expectedContainerWidth, element.width);
    }

    function test_layout_should_children_fit_horizontal_with_flex_vertical_child():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 200;
        element.height = 200;

        element.children.push(Layout.createElement());
        element.children[0].width = 50;
        element.children[0].vertical = {
            size: LayoutSize.FLEX
        }
        
        element.children.push(Layout.createElement());
        element.children[1].width = 50;
        
        var expectedChildX_A:Float = 0;
        var expectedChildY_A:Float = 0;
        var expectedChildX_B:Float = 50;
        var expectedChildY_B:Float = 0;
        var expectedContainerWidth:Float = 100;

        // ACT
        element.horizontal = {
            alignment: LayoutAlignment.CENTER,
            distribution: LayoutDistribution.SIDE,
            size : LayoutSize.FIT
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildX_A, element.children[0].x);
        Assert.equals(expectedChildY_A, element.children[0].y);

        Assert.equals(expectedChildX_B, element.children[1].x);
        Assert.equals(expectedChildY_B, element.children[1].y);

        Assert.equals(expectedContainerWidth, element.width);
    }
}