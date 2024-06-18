package test.unit.tricks.layout;

import tricks.layout.LayoutAlignment;
import utest.Assert;
import tricks.layout.LayoutElement;
import tricks.layout.Layout;
import utest.Test;

class LayoutVerticalAlignmentTest extends Test {

    function test_layout_should_align_children_horizontaly():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 200;
        element.height = 200;
        element.children.push(Layout.createElement());

        var expectedChildX:Float = 0;
        var expectedChildY:Float = 50;

        // ACT
        element.vertical = {
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
        
        var valueChildHeight_A:Float = 50;
        var valueChildHeight_B:Float = 80;

        var expectedChildX_A:Float = 0;
        var expectedChildY_A:Float = 75;
        var expectedChildX_B:Float = 0;
        var expectedChildY_B:Float = 60;

        // ACT
        element.children[0].height = valueChildHeight_A;
        element.children[1].height = valueChildHeight_B;

        element.vertical = {
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
        
        var expectedChildX:Float = 0;
        var expectedChildY:Float = 100;

        // ACT
        element.vertical = {
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
        element.vertical = {
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
        element.children[0].y = 20;

        element.children.push(Layout.createElement());
        element.children[1].y = 50;
        
        var expectedChildY_A:Float = 20;
        var expectedChildY_B:Float = 50;

        // ACT
        element.vertical = {
            alignment: LayoutAlignment.NONE
        }

        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildY_A, element.children[0].y);
        Assert.equals(expectedChildY_B, element.children[1].y);
    }

}