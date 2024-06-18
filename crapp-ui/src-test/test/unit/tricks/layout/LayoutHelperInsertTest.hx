package test.unit.tricks.layout;

import tricks.layout.LayoutSize;
import tricks.layout.LayoutAlignment;
import tricks.layout.LayoutDistribution;
import utest.Assert;
import tricks.layout.Layout;
import tricks.layout.LayoutElement;
import tricks.layout.LayoutHelperInsert;
import utest.Test;

class LayoutHelperInsertTest extends Test {


    function test_should_detect_one_point_on_center() {
        // ARRANGE
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 300;
        element.height = 300;

        var expectedTotalPoints:Int = 1;
        var expectedIndex_A:Int = 0;
        var expectedPointCenterX_A:Float = 150;
        var expectedPointCenterY_A:Float = 150;
        var expextedPointWidth_A:Float = 300;
        var expextedPointHeight_A:Float = 300;

        // ACT
        var insert:LayoutHelperInsert<Any> = new LayoutHelperInsert<Any>();
        var points = insert.getInsertPoints(element);

        // ASSERT
        Assert.equals(expectedTotalPoints, points.length);
        Assert.equals(expectedIndex_A, points[0].index);
        Assert.equals(expectedPointCenterX_A, points[0].centerX);
        Assert.equals(expectedPointCenterY_A, points[0].centerY);
        Assert.equals(expextedPointWidth_A, points[0].width);
        Assert.equals(expextedPointHeight_A, points[0].height);
    }

    function test_should_detect_two_points_on_vertical_layout_with_one_children() {
        // ARRANGE
        var element:LayoutElement<Any> = Layout.createElement();
        element.vertical = {
            size : LayoutSize.FIT,
            alignment : LayoutAlignment.CENTER,
            distribution: LayoutDistribution.SIDE
        }
        element.horizontal = {
            alignment: LayoutAlignment.CENTER
        }

        element.width = 300;
        element.height = 300;
        element.children = [Layout.createElement()];

        var expectedTotalPoints:Int = 2;

        var expectedIndex_A:Int = 0;
        var expectedPointCenterX_A:Float = 150;
        var expectedPointCenterY_A:Float = 5;
        var expextedPointWidth_A:Float = 300;
        var expextedPointHeight_A:Float = 10;

        var expectedIndex_B:Int = 1;
        var expectedPointCenterX_B:Float = 150;
        var expectedPointCenterY_B:Float = 95;
        var expextedPointWidth_B:Float = 300;
        var expextedPointHeight_B:Float = 10;

        // ACT
        var layout:Layout= new Layout();
        layout.organize(element);

        var insert:LayoutHelperInsert<Any> = new LayoutHelperInsert<Any>();
        var points = insert.getInsertPoints(element);

        // ASSERT
        Assert.equals(expectedTotalPoints, points.length);
        Assert.equals(expectedIndex_A, points[0].index);
        Assert.equals(expectedPointCenterX_A, points[0].centerX);
        Assert.equals(expectedPointCenterY_A, points[0].centerY);
        Assert.equals(expextedPointWidth_A, points[0].width);
        Assert.equals(expextedPointHeight_A, points[0].height);

        Assert.equals(expectedIndex_B, points[1].index);
        Assert.equals(expectedPointCenterX_B, points[1].centerX);
        Assert.equals(expectedPointCenterY_B, points[1].centerY);
        Assert.equals(expextedPointWidth_B, points[1].width);
        Assert.equals(expextedPointHeight_B, points[1].height);
    }

    function test_should_detect_three_points_on_vertical_layout_with_two_children() {
        // ARRANGE
        var element:LayoutElement<Any> = Layout.createElement();
        element.vertical = {
            size : LayoutSize.FIT,
            alignment : LayoutAlignment.CENTER,
            distribution: LayoutDistribution.SIDE
        }
        element.horizontal = {
            alignment: LayoutAlignment.CENTER
        }

        element.width = 300;
        element.height = 300;
        element.children = [Layout.createElement(), Layout.createElement()];

        var expectedTotalPoints:Int = 3;

        var expectedIndex_A:Int = 0;
        var expectedPointCenterX_A:Float = 150;
        var expectedPointCenterY_A:Float = 5;
        var expextedPointWidth_A:Float = 300;
        var expextedPointHeight_A:Float = 10;

        var expectedIndex_B:Int = 1;
        var expectedPointCenterX_B:Float = 150;
        var expectedPointCenterY_B:Float = 100;
        var expextedPointWidth_B:Float = 300;
        var expextedPointHeight_B:Float = 10;

        var expectedIndex_C:Int = 2;
        var expectedPointCenterX_C:Float = 150;
        var expectedPointCenterY_C:Float = 195;
        var expextedPointWidth_C:Float = 300;
        var expextedPointHeight_C:Float = 10;

        // ACT
        var layout:Layout= new Layout();
        layout.organize(element);

        var insert:LayoutHelperInsert<Any> = new LayoutHelperInsert<Any>();
        var points = insert.getInsertPoints(element);

        // ASSERT
        Assert.equals(expectedTotalPoints, points.length);

        Assert.equals(expectedIndex_A, points[0].index);
        Assert.equals(expectedPointCenterX_A, points[0].centerX);
        Assert.equals(expectedPointCenterY_A, points[0].centerY);
        Assert.equals(expextedPointWidth_A, points[0].width);
        Assert.equals(expextedPointHeight_A, points[0].height);

        Assert.equals(expectedIndex_B, points[1].index);
        Assert.equals(expectedPointCenterX_B, points[1].centerX);
        Assert.equals(expectedPointCenterY_B, points[1].centerY);
        Assert.equals(expextedPointWidth_B, points[1].width);
        Assert.equals(expextedPointHeight_B, points[1].height);

        Assert.equals(expectedIndex_C, points[2].index);
        Assert.equals(expectedPointCenterX_C, points[2].centerX);
        Assert.equals(expectedPointCenterY_C, points[2].centerY);
        Assert.equals(expextedPointWidth_C, points[2].width);
        Assert.equals(expextedPointHeight_C, points[2].height);
    }

    function test_should_detect_three_points_on_horizontal_layout_with_two_children() {
        // ARRANGE
        var element:LayoutElement<Any> = Layout.createElement();
        element.horizontal = {
            size : LayoutSize.FIT,
            alignment : LayoutAlignment.CENTER,
            distribution: LayoutDistribution.SIDE
        }
        element.vertical = {
            alignment: LayoutAlignment.CENTER
        }

        element.width = 300;
        element.height = 300;
        element.children = [Layout.createElement(), Layout.createElement()];

        var expectedTotalPoints:Int = 3;

        var expectedIndex_A:Int = 0;
        var expectedPointCenterX_A:Float = 5;
        var expectedPointCenterY_A:Float = 150;
        var expextedPointWidth_A:Float = 10;
        var expextedPointHeight_A:Float = 300;

        var expectedIndex_B:Int = 1;
        var expectedPointCenterX_B:Float = 100;
        var expectedPointCenterY_B:Float = 150;
        var expextedPointWidth_B:Float = 10;
        var expextedPointHeight_B:Float = 300;

        var expectedIndex_C:Int = 2;
        var expectedPointCenterX_C:Float = 195;
        var expectedPointCenterY_C:Float = 150;
        var expextedPointWidth_C:Float = 10;
        var expextedPointHeight_C:Float = 300;

        // ACT
        var layout:Layout= new Layout();
        layout.organize(element);

        var insert:LayoutHelperInsert<Any> = new LayoutHelperInsert<Any>();
        var points = insert.getInsertPoints(element);

        // ASSERT
        Assert.equals(expectedTotalPoints, points.length);

        Assert.equals(expectedIndex_A, points[0].index);
        Assert.equals(expectedPointCenterX_A, points[0].centerX);
        Assert.equals(expectedPointCenterY_A, points[0].centerY);
        Assert.equals(expextedPointWidth_A, points[0].width);
        Assert.equals(expextedPointHeight_A, points[0].height);

        Assert.equals(expectedIndex_B, points[1].index);
        Assert.equals(expectedPointCenterX_B, points[1].centerX);
        Assert.equals(expectedPointCenterY_B, points[1].centerY);
        Assert.equals(expextedPointWidth_B, points[1].width);
        Assert.equals(expextedPointHeight_B, points[1].height);

        Assert.equals(expectedIndex_C, points[2].index);
        Assert.equals(expectedPointCenterX_C, points[2].centerX);
        Assert.equals(expectedPointCenterY_C, points[2].centerY);
        Assert.equals(expextedPointWidth_C, points[2].width);
        Assert.equals(expextedPointHeight_C, points[2].height);
    }

}