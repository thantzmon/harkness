//
//  Hark Prep.swift
//  Harkness
//
//  Created by Nicholas Brozey on 5/3/16.
//  Copyright © 2016 Tom Hantzmon. All rights reserved.
//

import UIKit

class HarkPrep: UIViewController {
    
    @IBOutlet weak var studentView: UIScrollView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var absentStudentView: UIScrollView!
    var presentStudents = [String]()
    var absentStudents = [String]()
    var numberPresent = [UIButton]()
    var numberAbsent = [UIButton]()
    var height = Double()
    var absentHeight = Double()
    var toPass:String!
    override func viewDidLoad() {
        locations.removeAll()
        backButton.layer.zPosition = CGFloat.max
        
        /*
         Trevor right here yoou need to select distinct student names from the variable called toPass (that is the class name)
         put the names in the array students as you can see below (and make sure you delete hard coded names... query can go right here
         
         */
        var students = [String]()
        students = NSUserDefaults.standardUserDefaults().objectForKey(NSUserDefaults.standardUserDefaults().objectForKey("Class")! as! String) as! [String]
        
        //receive list of student names from Trevor
        temp = 0.0
        height = 0.0
        absentHeight = 100.0
        for i in students{
            
            height = (85 * temp) + 185.0
            studentView.contentSize.height = CGFloat(height)
            
            
            var button = UIButton()
            button = UIButton(type: UIButtonType.System)
            
            button.setTitle(i, forState: UIControlState.Normal)
            
            button.bounds = CGRect(x: 0, y: 0, width: 250, height: 80)
            button.center = CGPoint(x: 150, y: (85 * temp) + 100)
            button.layer.cornerRadius = 10
            button.clipsToBounds = true
            button.layer.borderWidth = 1
            button.backgroundColor = UIColor(red: 155, green: 215, blue: 179)
            presentStudents.append(i)
            
            button.titleLabel?.font = UIFont.systemFontOfSize(17)
            button.setTitleColor(UIColor(red: 64, green: 76, blue: 83), forState: UIControlState.Normal)
            
            button.addTarget(self, action: #selector(HarkPrep.buttonClicked(_:)), forControlEvents: .TouchUpInside)
            
            
            temp = temp + 1
            studentView.addSubview(button)
            numberPresent.append(button)
        }
        
    }
    func buttonClicked(sender: UIButton?){
        if sender!.backgroundColor == UIColor(red: 239, green: 121, blue: 111){
            sender!.backgroundColor = UIColor(red: 155, green: 215, blue: 179)
            presentStudents.append(sender!.titleLabel!.text!)
            absentStudents.removeAtIndex(absentStudents.indexOf(sender!.titleLabel!.text!)!)
            studentView.addSubview(sender!)
            for button in numberPresent{
                button.center.y = button.center.y + 85
            }
            for button in numberAbsent{
                if button.center.y > sender!.center.y{
                    button.center.y = button.center.y - 85
                }            }
            sender!.center.y = 100
            height = height + 85
            absentHeight = absentHeight - 85
            studentView.contentSize.height = CGFloat(height)
            absentStudentView.contentSize.height = CGFloat(absentHeight)

            numberPresent.append(sender!)
            numberAbsent.removeAtIndex(numberAbsent.indexOf(sender!)!)

        }else{
            sender!.backgroundColor = UIColor(red: 239, green: 121, blue: 111)
            absentStudents.append(sender!.titleLabel!.text!)
            presentStudents.removeAtIndex(presentStudents.indexOf(sender!.titleLabel!.text!)!)
            absentStudentView.addSubview(sender!)
            for button in numberAbsent{
                button.center.y = button.center.y + 85
            }
            for button in numberPresent{
                if button.center.y > sender!.center.y{
                    button.center.y = button.center.y - 85
                }
            }
            sender!.center.y = 100
            absentHeight = absentHeight + 85
            height = height - 85
            absentStudentView.contentSize.height = CGFloat(absentHeight)
            studentView.contentSize.height = CGFloat(height)


            numberAbsent.append(sender!)
            numberPresent.removeAtIndex(numberPresent.indexOf(sender!)!)

        }
    }
    
    
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        if (segue.identifier == "segueToHarkness") {
            let svc = segue!.destinationViewController as! Harkness;
            svc.presentList = presentStudents
            svc.toPass = toPass
        } else if (segue.identifier == "segueToGateway"){
            
        }
    }
    
    
    
}
