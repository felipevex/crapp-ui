package test.unit.tricks.layout;

import utest.Assert;
import tricks.layout.LayoutElement;
import tricks.layout.Layout;
import tricks.layout.LayoutHelperDetector;
import utest.Test;

class LayoutHelperDetectorTest extends Test {
    
    public function test_return_simple_layout_object_over_specified_position() {
        // ARRANGE
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 300;
        element.height = 300;
        
        var result:LayoutElement<Any> = null;
        var expectedResult:LayoutElement<Any> = element;

        // ACT
        var detector:LayoutHelperDetector<Any> = new LayoutHelperDetector<Any>();
        result = detector.detectInnermostLayout(0, 0, element);

        // ASSERT
        Assert.equals(expectedResult, result);
    }

    public function test_return_null_on_out_position() {
        // ARRANGE
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 300;
        element.height = 300;
        
        var result:LayoutElement<Any> = null;
        var expectedResult:LayoutElement<Any> = null;

        var positionX:Float = -10;
        var positionY:Float = -10;

        // ACT
        var detector:LayoutHelperDetector<Any> = new LayoutHelperDetector<Any>();
        result = detector.detectInnermostLayout(positionX, positionY, element);

        // ASSERT
        Assert.equals(expectedResult, result);
    }

    public function test_return_null_on_out_beyond_element_size_position() {
        // ARRANGE
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 300;
        element.height = 300;
        
        var result:LayoutElement<Any> = null;
        var expectedResult:LayoutElement<Any> = null;

        var positionX:Float = 310;
        var positionY:Float = 310;

        // ACT
        var detector:LayoutHelperDetector<Any> = new LayoutHelperDetector<Any>();
        result = detector.detectInnermostLayout(positionX, positionY, element);

        // ASSERT
        Assert.equals(expectedResult, result);
    }

    public function test_return_child_element_with_position_over_child() {
        // ARRANGE
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 300;
        element.height = 300;

        var childA:LayoutElement<Any> = Layout.createElement();
        childA.width = 100;
        childA.height = 100;
        childA.x = 200;
        childA.y = 200;

        element.children = [childA];
        
        var result:LayoutElement<Any> = null;
        var expectedResult:LayoutElement<Any> = childA;

        var positionX:Float = 210;
        var positionY:Float = 210;

        // ACT
        var detector:LayoutHelperDetector<Any> = new LayoutHelperDetector<Any>();
        result = detector.detectInnermostLayout(positionX, positionY, element);

        // ASSERT
        Assert.equals(expectedResult, result);
    }

    public function test_return_parent_element_with_position_beyond_child_bounds() {
        // ARRANGE
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 300;
        element.height = 300;

        var childA:LayoutElement<Any> = Layout.createElement();
        childA.width = 100;
        childA.height = 100;
        childA.x = 100;
        childA.y = 100;

        element.children = [childA];

        var positionX:Float = 210;
        var positionY:Float = 150;
        
        var result:LayoutElement<Any> = null;
        var expectedResult:LayoutElement<Any> = element;

        // ACT
        var detector:LayoutHelperDetector<Any> = new LayoutHelperDetector<Any>();
        result = detector.detectInnermostLayout(positionX, positionY, element);

        // ASSERT
        Assert.equals(expectedResult, result);
    }

    public function test_child_same_size_as_parent_return_child() {
        // ARRANGE
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 300;
        element.height = 300;

        var childA:LayoutElement<Any> = Layout.createElement();
        childA.width = 300;
        childA.height = 300;
        childA.x = 0;
        childA.y = 0;

        element.children = [childA];
        
        var result:LayoutElement<Any> = null;
        var expectedResult:LayoutElement<Any> = childA;

        var positionX:Float = 5;
        var positionY:Float = 5;

        // ACT
        var detector:LayoutHelperDetector<Any> = new LayoutHelperDetector<Any>();
        result = detector.detectInnermostLayout(positionX, positionY, element);

        // ASSERT
        Assert.equals(expectedResult, result);
    }

    public function test_child_same_size_as_parent_with_offset_should_return_child() {
        // ARRANGE
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 300;
        element.height = 300;

        var childA:LayoutElement<Any> = Layout.createElement();
        childA.width = 300;
        childA.height = 300;
        childA.x = 0;
        childA.y = 0;

        element.children = [childA];
        
        var result:LayoutElement<Any> = null;
        var expectedResult:LayoutElement<Any> = element;

        var positionX:Float = 5;
        var positionY:Float = 5;
        var offset:Float = 10;

        // ACT
        var detector:LayoutHelperDetector<Any> = new LayoutHelperDetector<Any>();
        result = detector.detectInnermostLayout(positionX, positionY, element, offset);

        // ASSERT
        Assert.equals(expectedResult, result);
    }

    public function test_validate_offset_increment_on_left() {
        // ARRANGE
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 300;
        element.height = 300;

        var childLevel1:LayoutElement<Any> = Layout.createElement();
        childLevel1.width = 300;
        childLevel1.height = 300;
        childLevel1.x = 0;
        childLevel1.y = 0;

        var childLevel2:LayoutElement<Any> = Layout.createElement();
        childLevel2.width = 300;
        childLevel2.height = 300;
        childLevel2.x = 0;
        childLevel2.y = 0;

        element.children = [childLevel1];
        childLevel1.children = [childLevel2];
        
        var result_X2:LayoutElement<Any> = null;
        var result_X6:LayoutElement<Any> = null;
        var result_X12:LayoutElement<Any> = null;

        var expectedResult_X2:LayoutElement<Any> = element;
        var expectedResult_X6:LayoutElement<Any> = childLevel1;
        var expectedResult_X12:LayoutElement<Any> = childLevel2;

        var positionY:Float = 100;

        // ACT
        var detector:LayoutHelperDetector<Any> = new LayoutHelperDetector<Any>();
        result_X2 = detector.detectInnermostLayout(2, positionY, element);
        result_X6 = detector.detectInnermostLayout(6, positionY, element);
        result_X12 = detector.detectInnermostLayout(12, positionY, element);

        // ASSERT
        Assert.equals(expectedResult_X2, result_X2);
        Assert.equals(expectedResult_X6, result_X6);
        Assert.equals(expectedResult_X12, result_X12);
    }

    public function test_validate_offset_increment_on_bottom() {
        // ARRANGE
        var element:LayoutElement<Any> = Layout.createElement();
        element.width = 300;
        element.height = 300;

        var childLevel1:LayoutElement<Any> = Layout.createElement();
        childLevel1.width = 300;
        childLevel1.height = 300;
        childLevel1.x = 0;
        childLevel1.y = 0;

        var childLevel2:LayoutElement<Any> = Layout.createElement();
        childLevel2.width = 300;
        childLevel2.height = 300;
        childLevel2.x = 0;
        childLevel2.y = 0;

        element.children = [childLevel1];
        childLevel1.children = [childLevel2];
        
        var result_Y298:LayoutElement<Any> = null;
        var result_Y294:LayoutElement<Any> = null;
        var result_Y288:LayoutElement<Any> = null;

        var expectedResult_Y298:LayoutElement<Any> = element;
        var expectedResult_Y294:LayoutElement<Any> = childLevel1;
        var expectedResult_Y288:LayoutElement<Any> = childLevel2;

        var positionX:Float = 100;

        // ACT
        var detector:LayoutHelperDetector<Any> = new LayoutHelperDetector<Any>();
        result_Y298 = detector.detectInnermostLayout(positionX, 298, element);
        result_Y294 = detector.detectInnermostLayout(positionX, 294, element);
        result_Y288 = detector.detectInnermostLayout(positionX, 288, element);

        // ASSERT
        Assert.equals(expectedResult_Y298, result_Y298);
        Assert.equals(expectedResult_Y294, result_Y294);
        Assert.equals(expectedResult_Y288, result_Y288);
    }

}