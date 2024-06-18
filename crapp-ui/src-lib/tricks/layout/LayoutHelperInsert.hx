package tricks.layout;

class LayoutHelperInsert<T> {
    
    public function new() {
        
    }

    public function getInsertPoints(element:LayoutElement<T>):Array<LayoutInsertPoint<T>> {
        var result:Array<LayoutInsertPoint<T>> = [];
        var insertSize:Int = 10;

        if (element.children.length == 0) {
            result.push({
                centerX : element.width/2,
                centerY : element.height/2,
                height : element.height,
                width : element.width,
                index : 0,
                container: element.ref
            });
        } else {
            
            var lastY:Float = Math.NEGATIVE_INFINITY;
            var lastX:Float = Math.NEGATIVE_INFINITY;

            var isVertical:Bool = element.vertical != null && element.vertical.distribution != null && element.vertical.distribution != LayoutDistribution.NONE;
            var isHorizontal:Bool = element.horizontal != null && element.horizontal.distribution != null && element.horizontal.distribution != LayoutDistribution.NONE;
            
            if (isVertical) {
                for (i in 0 ... element.children.length) {
                    var child = element.children[i];
                    
                    if (i == 0) result.push({
                        centerX : element.width/2,
                        centerY : insertSize/2,
                        width : element.width,
                        height : insertSize,
                        index : i,
                        container: element.ref
                    });

                    else result.push({
                        centerX : element.width/2,
                        centerY : lastY + (child.y - lastY)/2,
                        width : element.width,
                        height : insertSize,
                        index : i,
                        container: element.ref
                    });

                    if (i == element.children.length - 1) result.push({
                        centerX : element.width/2,
                        centerY : child.y + child.height - insertSize/2,
                        width : element.width,
                        height : insertSize,
                        index : i + 1,
                        container: element.ref
                    });

                    lastY = child.y + child.height;
                }
            }

            if (isHorizontal) {
                for (i in 0 ... element.children.length) {
                    var child = element.children[i];
                    
                    if (i == 0) result.push({
                        centerX : insertSize/2,
                        centerY : element.height/2,
                        width : insertSize,
                        height : element.height,
                        index : i,
                        container: element.ref
                    });

                    else result.push({
                        centerX : lastX + (child.x - lastX)/2,
                        centerY : element.height/2,
                        width : insertSize,
                        height : element.height,
                        index : i,
                        container: element.ref
                    });

                    if (i == element.children.length - 1) result.push({
                        centerX : child.x + child.width - insertSize/2,
                        centerY : element.height/2,
                        width : insertSize,
                        height : element.height,
                        index : i + 1,
                        container: element.ref
                    });

                    lastX = child.x + child.width;
                }
            }
        }
        
        return result;
    }

}

typedef LayoutInsertPoint<T> = {
    var centerX:Float;
    var centerY:Float;
    var height:Float;
    var width:Float;
    var index:Int;
    var container:T;
}

