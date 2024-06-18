package test.unit.tricks.layout;

import tricks.layout.LayoutSize;
import tricks.layout.LayoutAlignment;
import utest.Assert;
import tricks.layout.LayoutElement;
import tricks.layout.Layout;
import utest.Test;

class LayoutHorizontalAlignmentTest extends Test {

    function test_layout_should_align_children_horizontaly():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 200;
        element.height = 200;
        element.children.push(Layout.createElement());

        var expectedChildX:Float = 50;
        var expectedChildY:Float = 0;

        // ACT
        element.horizontal = {
            alignment: LayoutAlignment.CENTER
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildX, element.children[0].x);
        Assert.equals(expectedChildY, element.children[0].y);
    }

    function test_layout_should_align_two_children_with_different_sizes_on_center():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 200;
        element.height = 200;

        element.children.push(Layout.createElement());
        element.children.push(Layout.createElement());
        
        var valueChildwidth_A:Float = 50;
        var valueChildwidth_B:Float = 80;

        var expectedChildX_A:Float = 75;
        var expectedChildY_A:Float = 0;
        var expectedChildX_B:Float = 60;
        var expectedChildY_B:Float = 0;

        // ACT
        element.children[0].width = valueChildwidth_A;
        element.children[1].width = valueChildwidth_B;

        element.horizontal = {
            alignment: LayoutAlignment.CENTER
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildX_A, element.children[0].x);
        Assert.equals(expectedChildY_A, element.children[0].y);

        Assert.equals(expectedChildX_B, element.children[1].x);
        Assert.equals(expectedChildY_B, element.children[1].y);
    }

    function test_layout_should_align_children_on_right():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 200;
        element.height = 200;

        element.children.push(Layout.createElement());
        element.children.push(Layout.createElement());
        
        var expectedChildX:Float = 100;
        var expectedChildY:Float = 0;

        // ACT
        element.horizontal = {
            alignment: LayoutAlignment.MAX
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildX, element.children[0].x);
        Assert.equals(expectedChildY, element.children[0].y);
    }

    function test_layout_should_align_children_on_left() {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 200;
        element.height = 200;

        element.children.push(Layout.createElement());
        element.children.push(Layout.createElement());
        
        var expectedChildX:Float = 0;
        var expectedChildY:Float = 0;

        // ACT
        element.horizontal = {
            alignment: LayoutAlignment.MIN
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildX, element.children[0].x);
        Assert.equals(expectedChildY, element.children[0].y);
    }

    function test_layout_should_keep_children_on_original_position() {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 200;
        element.height = 200;

        element.children.push(Layout.createElement());
        element.children[0].x = 20;

        element.children.push(Layout.createElement());
        element.children[1].x = 50;
        
        var expectedChildX_A:Float = 20;
        var expectedChildX_B:Float = 50;

        // ACT
        element.horizontal = {
            alignment: LayoutAlignment.NONE
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildX_A, element.children[0].x);
        Assert.equals(expectedChildX_B, element.children[1].x);
    }

}