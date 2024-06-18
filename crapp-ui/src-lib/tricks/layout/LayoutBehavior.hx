package tricks.layout;

import tricks.layout.LayoutSize;

typedef LayoutBehavior = {
    @:optional var gap:Float;
    @:optional var size:LayoutSize;
    @:optional var alignment:LayoutAlignment;
    @:optional var distribution:LayoutDistribution;
}