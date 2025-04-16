package crapp.ui.display.drag;

import priori.geom.PriGeomBox;

class CrappUIDragAlignHelper {
    
    public static function freeDistribution(data:CrappUIDragAlignHelperData):Array<PriGeomBox> {
        return [];
    }

    public static function rowDistribution(vGap:Float, data:CrappUIDragAlignHelperData):Array<PriGeomBox> {
        var result:Array<PriGeomBox> = [];

        var nextY:Float = 0;

        for (i in 0 ... data.items.length) {
            var item:CrappUIDragItem = data.items[i];

            item.width = data.width;
            
            var box:PriGeomBox = new PriGeomBox(
                0, 
                nextY, 
                data.width, 
                item.height
            );

            result.push(box);
            
            nextY += item.height + vGap;
        }

        return result;
    }

}

typedef CrappUIDragAlignHelperData = {
    var width:Float;
    var height:Float;
    var items:Array<CrappUIDragItem>;
}