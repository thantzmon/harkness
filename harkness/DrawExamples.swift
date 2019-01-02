
import UIKit

class DrawExamples: UIView {


    override func drawRect(rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()
        
        /*CSS FOR THE PATH*/
        CGContextSetLineWidth(context, 3.0) /* SETTING LINE WIDTH: Set to the let and then the width next (let, width) */
        CGContextSetStrokeColorWithColor(context, UIColor.purpleColor().CGColor) /* SETTING COLOR: Set let, set desired color and .CGColor to set the type */
        
        /*SETS INVISIBLE PATH*/
        CGContextMoveToPoint(context, 0, 0) /* SETTING PATH START: Set let, set X coordinate, set Y coordinate */
        CGContextAddLineToPoint(context, 400, 400)/* SETTING PATH END: Set let, set X coordinate, set Y coordinate */
        
        /*ACTUALLY MAKES THE DESIGNED^ PATH*/
        CGContextStrokePath(context)/*DRAWS REQUESTED LINE*/

        
    }
    

}
