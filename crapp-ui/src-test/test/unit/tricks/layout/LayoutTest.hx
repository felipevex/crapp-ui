package test.unit.tricks.layout;

import utest.Assert;
import tricks.layout.LayoutElement;
import tricks.layout.Layout;
import utest.Test;

class LayoutTest extends Test {

    function test_layout_should_not_change_if_havent_especifications():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.children.push(Layout.createElement());

        var expectedChildX:Float = 0;
        var expectedChildY:Float = 0;

        // ACT
        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildX, element.children[0].x);
        Assert.equals(expectedChildY, element.children[0].y);
    }

    function test_layout_should_keep_chidren_on_specific_position():Void {
        // ARRANGE
        var layout:Layout = new Layout();
        var element:LayoutElement<Any> = Layout.createElement();
        element.children.push(Layout.createElement());

        var valueChildX:Float = 10;
        var valueChildY:Float = 20;

        var expectedChildX:Float = 10;
        var expectedChildY:Float = 20;

        // ACT
        element.children[0].x = valueChildX;
        element.children[0].y = valueChildY;
        layout.organize(element);

        // ASSERT
        Assert.equals(expectedChildX, element.children[0].x);
        Assert.equals(expectedChildY, element.children[0].y);
    }

}