package tricks.layout;

class Layout {
    
    public function new() {
        
    }

    private function calculatePositionForDistributionNONE(alignment:LayoutAlignment, elementSize:Float, childSize:Float, originalPos:Float):Float {
        return switch (alignment) {
            case LayoutAlignment.CENTER : (elementSize - childSize) / 2;
            case LayoutAlignment.MAX : elementSize - childSize;
            case LayoutAlignment.MIN : 0;
            case null | LayoutAlignment.NONE : originalPos;
        }
    }

    private function calculatePositionForDistributionSIDE(alignment:LayoutAlignment, elementSize:Float, childSize:Float, totalSize:Float, partialSize:Float):Float {
        return switch (alignment) {
            case LayoutAlignment.CENTER : ((elementSize - totalSize) / 2) + partialSize;
            case LayoutAlignment.MAX : elementSize - totalSize + partialSize;
            case LayoutAlignment.MIN | null | LayoutAlignment.NONE : partialSize;
        }
    }

    private function calculateFlexSize(distribution:LayoutDistribution, totalFlexElements:Int, elementSize:Float, emptySpace:Float):Float {
        var minimumFlexSize:Float = 10;
        if (totalFlexElements == 0) return minimumFlexSize;

        var result:Float = switch (distribution) {
            case null | LayoutDistribution.NONE : elementSize;
            case LayoutDistribution.SIDE | LayoutDistribution.JUSTIFY : Math.max(0, (elementSize - emptySpace) / totalFlexElements);
        }

        if (result > minimumFlexSize) return result;
        else return minimumFlexSize;
    }
    
    public function organize(element:LayoutElement<Any>):Void {
        if (element.children == null) element.children = [];
        
        var totalChildren:Int = element.children.length;
        var childrenWidthSum:Float = 0;
        var childrenHeightSum:Float = 0;
        var childrenHGapSum:Float = 0;
        var childrenVGapSum:Float = 0;
        var maxChildrenWidth:Float = 0;
        var maxChildrenHeight:Float = 0;
        var maxChildrenX:Float = 0;
        var maxChildrenY:Float = 0;
        var partialWidth:Float = 0;
        var partialHeight:Float = 0;

        var hSize:LayoutSize = element.horizontal == null ? null : element.horizontal.size;
        var vSize:LayoutSize = element.vertical == null ? null : element.vertical.size;
        var hDistribution:LayoutDistribution = element.horizontal == null ? null : element.horizontal.distribution;
        var vDistribution:LayoutDistribution = element.vertical == null ? null : element.vertical.distribution;
        var hAlignment:LayoutAlignment = element.horizontal == null ? null : element.horizontal.alignment;
        var vAlignment:LayoutAlignment = element.vertical == null ? null : element.vertical.alignment;

        var hGap:Float = element.horizontal == null || element.horizontal.gap == null ? 0 : element.horizontal.gap;
        var vGap:Float = element.vertical == null || element.vertical.gap == null ? 0 : element.vertical.gap;
        
        var childFlexWidth:Float = 0;
        var childFlexHeight:Float = 0;
        var hFlexChildren:Array<LayoutElement<Any>> = [];
        var vFlexChildren:Array<LayoutElement<Any>> = [];

        if (totalChildren > 1) {
            childrenHGapSum = hGap * (totalChildren - 1);
            childrenVGapSum = vGap * (totalChildren - 1);   
        }

        for (child in element.children) {
            this.organize(child);

            if (child.horizontal != null && child.horizontal.size == LayoutSize.FLEX) {
                hFlexChildren.push(child);
            } else {
                maxChildrenX = Math.max(maxChildrenX, child.x + child.width);
                maxChildrenWidth = Math.max(maxChildrenWidth, child.width);
                childrenWidthSum += child.width;
            }

            if (child.vertical != null && child.vertical.size == LayoutSize.FLEX) {
                vFlexChildren.push(child);
            } else {
                maxChildrenY = Math.max(maxChildrenY, child.y + child.height);
                maxChildrenHeight = Math.max(maxChildrenHeight, child.height);
                childrenHeightSum += child.height;
            }
        }

        childFlexWidth = this.calculateFlexSize(hDistribution, hFlexChildren.length, element.width, childrenWidthSum + childrenHGapSum);
        for (child in hFlexChildren) child.width = childFlexWidth;
        
        childFlexHeight = this.calculateFlexSize(vDistribution, vFlexChildren.length, element.height, childrenHeightSum + childrenVGapSum);
        for (child in vFlexChildren) child.height = childFlexHeight;

        for (child in hFlexChildren) {
            this.organize(child);
            maxChildrenX = Math.max(maxChildrenX, child.x + child.width);
            maxChildrenWidth = Math.max(maxChildrenWidth, child.width);
            childrenWidthSum += child.width;
        }

        for (child in vFlexChildren) {
            this.organize(child);
            maxChildrenY = Math.max(maxChildrenY, child.y + child.height);
            maxChildrenHeight = Math.max(maxChildrenHeight, child.height);
            childrenHeightSum += child.height;
        }

        childrenWidthSum += childrenHGapSum;
        childrenHeightSum += childrenVGapSum;
        
        element.width = switch (hSize) {
            case LayoutSize.FIT : switch (hDistribution) {
                case null | LayoutDistribution.NONE : switch (hAlignment) {
                    case null | LayoutAlignment.NONE : maxChildrenX;
                    case CENTER | MAX | MIN : maxChildrenWidth;
                }
                case LayoutDistribution.SIDE : childrenWidthSum;
                case LayoutDistribution.JUSTIFY : childrenWidthSum;
            }
            case LayoutSize.FLEX : element.width;
            case null | LayoutSize.FIXED : element.width;
        }
        
        element.height = switch (vSize) {
            case LayoutSize.FIT : switch (vDistribution) {
                case null | LayoutDistribution.NONE : switch (vAlignment) {
                    case null | LayoutAlignment.NONE : maxChildrenY;
                    case CENTER | MAX | MIN : maxChildrenHeight;
                }
                case LayoutDistribution.SIDE : childrenHeightSum;
                case LayoutDistribution.JUSTIFY : childrenHeightSum;
            }
            case LayoutSize.FLEX : element.height;
            case null | LayoutSize.FIXED : element.height;
        }

        for (child in element.children) {
            switch (hDistribution) {
                case null | LayoutDistribution.NONE : {
                    if (hFlexChildren.indexOf(child) > -1) child.x = 0;
                    else child.x = this.calculatePositionForDistributionNONE(
                        hAlignment, 
                        element.width, 
                        child.width,
                        child.x
                    );
                }
                case LayoutDistribution.SIDE : {
                    child.x = this.calculatePositionForDistributionSIDE(
                        hAlignment, 
                        element.width, 
                        child.width, 
                        childrenWidthSum, 
                        partialWidth
                    );

                    partialWidth += child.width + hGap;
                }
                case LayoutDistribution.JUSTIFY : {
                    if (totalChildren == 1) child.x = (element.width - child.width) / 2;
                    else {
                        child.x = partialWidth;
                        
                        var space:Float = (element.width - childrenWidthSum) / (totalChildren - 1);
                        partialWidth += child.width + space + hGap;
                    }
                }
            }
        
            switch (vDistribution) {
                case null | LayoutDistribution.NONE : {
                    if (vFlexChildren.indexOf(child) > -1) child.y = 0;
                    else child.y = this.calculatePositionForDistributionNONE(
                        vAlignment, 
                        element.height, 
                        child.height,
                        child.y
                    );
                }
                case LayoutDistribution.SIDE : {
                    child.y = this.calculatePositionForDistributionSIDE(
                        vAlignment, 
                        element.height, 
                        child.height, 
                        childrenHeightSum, 
                        partialHeight
                    );

                    partialHeight += child.height + vGap;
                }
                case LayoutDistribution.JUSTIFY : {
                    if (totalChildren == 1) child.y = (element.height - child.height) / 2;
                    else {
                        child.y = partialHeight;
                        
                        var space:Float = (element.height - childrenHeightSum) / (totalChildren - 1);
                        partialHeight += child.height + space + vGap;
                    }
                }
            }
        }
    }

    static public function createElement():LayoutElement<Any> {
        return {
            x : 0,
            y : 0,
            width : 100,
            height : 100,
            children : [],
            isContainer: true
        }
    }


}