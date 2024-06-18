package tricks.layout;

class LayoutHelperDetector<T> {
    
    public function new() {
        
    }

    public function detectInnermostLayout(x:Float, y:Float, element:LayoutElement<T>, ?offset:Float = 5, ?offsetIncrement:Float = 5):LayoutElement<T> {
        if (x < 0 || y < 0 || x > element.width || y > element.height) return null;

        if (x < offset || y < offset || x > element.width - offset || y > element.height - offset) return element;
        
        var result:LayoutElement<T> = null;

        for (child in element.children) {
            if (child.isContainer) {
                result = this.detectInnermostLayout(x - child.x, y - child.y, child, offset + offsetIncrement, offsetIncrement);
                if (result != null) break;
            }
        }

        if (result == null) result = element;
        return result;
    }
}