package test.unit;

import test.unit.style.TestThemeProvider;
import test.unit.tricks.layout.LayoutHelperDetectorTest;
import test.unit.tricks.layout.LayoutHelperInsertTest;
import test.unit.tricks.layout.LayoutVerticalSizeFlexTest;
import test.unit.tricks.layout.LayoutVerticalDistributionSideTest;
import test.unit.tricks.layout.LayoutVerticalGapTest;
import test.unit.tricks.layout.LayoutVerticalSizeFitTest;
import test.unit.tricks.layout.LayoutVerticalDistributionJustifyTest;
import test.unit.tricks.layout.LayoutVerticalAlignmentTest;
import test.unit.tricks.layout.LayoutHorizontalSizeFlexTest;
import test.unit.tricks.layout.LayoutHorizontalGapTest;
import test.unit.tricks.layout.LayoutHorizontalSizeFitTest;
import test.unit.tricks.layout.LayoutHorizontalDistributionSideTest;
import test.unit.tricks.layout.LayoutHorizontalDistributionJustifyTest;
import test.unit.tricks.layout.LayoutHorizontalAlignmentTest;
import test.unit.tricks.layout.LayoutTest;
import utest.ui.Report;
import utest.Runner;

class UnitTests {
    
    static public function main() {

        var runner = new Runner();

        runner.addCase(new LayoutTest());
        runner.addCase(new LayoutHorizontalAlignmentTest());
        runner.addCase(new LayoutHorizontalDistributionSideTest());
        runner.addCase(new LayoutHorizontalDistributionJustifyTest());
        runner.addCase(new LayoutHorizontalSizeFitTest());
        runner.addCase(new LayoutHorizontalGapTest());
        runner.addCase(new LayoutHorizontalSizeFlexTest());
        runner.addCase(new LayoutVerticalAlignmentTest());
        runner.addCase(new LayoutVerticalDistributionSideTest());
        runner.addCase(new LayoutVerticalDistributionJustifyTest());
        runner.addCase(new LayoutVerticalSizeFitTest());
        runner.addCase(new LayoutVerticalGapTest());
        runner.addCase(new LayoutVerticalSizeFlexTest());
        runner.addCase(new LayoutHelperInsertTest());
        runner.addCase(new LayoutHelperDetectorTest());

        runner.addCase(new TestThemeProvider());

        Report.create(runner);
        runner.run();
        
    }

}