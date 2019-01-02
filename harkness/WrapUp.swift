//
//  Wrap Up.swift
//  Harkness
//
//  Created by Nicholas Brozey on 5/3/16.
//  Copyright © 2016 Tom Hantzmon. All rights reserved.
//

import UIKit

class WrapUp: UIViewController {
    
    @IBOutlet weak var labelScroll: UIScrollView!
    @IBOutlet weak var infoScroll: UIScrollView!
    @IBOutlet weak var doneButton: UIButton!
    var contributions:[String:Int]!
    var classDiscussions: [String:String]!
    var theDiscussion: [String:Int]!
    var discussionName:String!
    var discussionDescriptions = [String:String]()
    var discussQuote: [String:Int]!
    var discussQuestion: [String:Int]!
    var discussAnswer: [String:Int]!
    var discussOther: [String:Int]!
    
    
    override func viewDidAppear(animated: Bool) {
        var alert = UIAlertController(title: "Discussion Notes", message: "Enter any notes you had about this discussion", preferredStyle: .Alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = "Notes"
        })
        
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            if NSUserDefaults.standardUserDefaults().objectForKey("discussionDescriptions") != nil{
                self.discussionDescriptions = NSUserDefaults.standardUserDefaults().objectForKey("discussionDescriptions")! as! [String:String]
                self.discussionDescriptions[self.discussionName as String] = textField.text
            } else{
                self.discussionDescriptions = [self.discussionName as String:textField.text!]
            }
            NSUserDefaults.standardUserDefaults().setObject(self.discussionDescriptions, forKey: "discussionDescriptions")
            
            
        }))
        
        // 4. Present the alert.
        self.presentViewController(alert, animated: true, completion: nil)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //made the header buttons... ugly code incoming
        
        let label1 = UILabel()
        label1.text = "Name"
        label1.bounds = CGRect(x: 0, y: 0, width: 100, height: 80)
        label1.center = CGPoint(x: (1 * 110) - 60, y: (85 * 1) + 100)
        label1.textAlignment = NSTextAlignment.Center
        label1.layer.cornerRadius = 10
        label1.clipsToBounds = true
        label1.backgroundColor = UIColor(red: 129, green: 182, blue: 186)
        label1.font = label1.font.fontWithSize(17)
        view.addSubview(label1)
        
        let label2 = UILabel()
        label2.text = "Quotes"
        label2.bounds = CGRect(x: 0, y: 0, width: 100, height: 80)
        label2.center = CGPoint(x: (2 * 110) - 60, y: (85 * 1) + 100)
        label2.textAlignment = NSTextAlignment.Center
        label2.layer.cornerRadius = 10
        label2.clipsToBounds = true
        label2.backgroundColor = UIColor(red: 129, green: 182, blue: 186)
        label2.font = label2.font.fontWithSize(17)
        view.addSubview(label2)
        
        let label3 = UILabel()
        label3.text = "Questions"
        label3.bounds = CGRect(x: 0, y: 0, width: 100, height: 80)
        label3.center = CGPoint(x: (3 * 110) - 60, y: (85 * 1) + 100)
        label3.textAlignment = NSTextAlignment.Center
        label3.layer.cornerRadius = 10
        label3.clipsToBounds = true
        label3.backgroundColor = UIColor(red: 129, green: 182, blue: 186)
        label3.font = label3.font.fontWithSize(17)
        view.addSubview(label3)
        
        let label4 = UILabel()
        label4.text = "Answers"
        label4.bounds = CGRect(x: 0, y: 0, width: 100, height: 80)
        label4.center = CGPoint(x: (4 * 110) - 60, y: (85 * 1) + 100)
        label4.textAlignment = NSTextAlignment.Center
        label4.layer.cornerRadius = 10
        label4.clipsToBounds = true
        label4.backgroundColor = UIColor(red: 129, green: 182, blue: 186)
        label4.font = label4.font.fontWithSize(17)
        view.addSubview(label4)
        
        let label5 = UILabel()
        label5.text = "Other"
        label5.bounds = CGRect(x: 0, y: 0, width: 100, height: 80)
        label5.center = CGPoint(x: (5 * 110) - 60, y: (85 * 1) + 100)
        label5.textAlignment = NSTextAlignment.Center
        label5.layer.cornerRadius = 10
        label5.clipsToBounds = true
        label5.backgroundColor = UIColor(red: 129, green: 182, blue: 186)
        label5.font = label5.font.fontWithSize(17)
        view.addSubview(label5)
        
        let label6 = UILabel()
        label6.text = "Total"
        label6.bounds = CGRect(x: 0, y: 0, width: 100, height: 80)
        label6.center = CGPoint(x: (6 * 110) - 60, y: (85 * 1) + 100)
        label6.textAlignment = NSTextAlignment.Center
        label6.layer.cornerRadius = 10
        label6.clipsToBounds = true
        label6.backgroundColor = UIColor(red: 129, green: 182, blue: 186)
        label6.font = label6.font.fontWithSize(17)
        view.addSubview(label6)
        
        
        
        
        
        
        
        doneButton.layer.zPosition = CGFloat.max
        let currentClass = NSUserDefaults.standardUserDefaults().objectForKey("Class")! as! String + "Discussions"
        classDiscussions = NSUserDefaults.standardUserDefaults().objectForKey(currentClass)! as! [String:String]
        for discussion in classDiscussions{
            theDiscussion = NSUserDefaults.standardUserDefaults().objectForKey(discussion.0)! as! [String : Int]
            for person in theDiscussion {
                //so "person is an array of 2 strings (i think) person.0 being the name and person.1 being the contributions"
            }
        }
        var temp = 0
        for student in contributions{
            temp = temp+1
            for column in 1...6{
                let button = UILabel()
                switch column {
                case 1:
                    button.text = student.0
                case 2:
                    discussQuote = NSUserDefaults.standardUserDefaults().objectForKey(discussionName+"Quotes")! as! [String:Int]
                    for person in discussQuote{
                        if person.0 == student.0{
                            button.text = String(person.1)
                        }
                    }
                case 3:
                    discussQuestion = NSUserDefaults.standardUserDefaults().objectForKey(discussionName+"Questions")! as! [String:Int]
                    for person in discussQuestion{
                        if person.0 == student.0{
                            button.text = String(person.1)
                        }
                    }
                case 4:
                    discussAnswer = NSUserDefaults.standardUserDefaults().objectForKey(discussionName+"Answers")! as! [String:Int]
                    for person in discussAnswer{
                        if person.0 == student.0{
                            button.text = String(person.1)
                        }
                    }
                    
                case 5:
                    discussOther = NSUserDefaults.standardUserDefaults().objectForKey(discussionName+"Others")! as! [String:Int]
                    for person in discussOther{
                        if person.0 == student.0{
                            button.text = String(person.1)
                        }
                    }
                    
                case 6:
                    button.text = String(student.1)
                    
                default:
                    button.text = "ERROR"
                }
                //button = UIButton(type: UIButtonType.System)
                
                //do a for each for every type of contribution and test if student.0 == student.0, if so, display the contribution in a new label to the right of it... at the end make the total contributions last because that makes the most sense for it to be there
                
                
                button.bounds = CGRect(x: 0, y: 0, width: 100, height: 80)
                button.center = CGPoint(x: (column * 110) - 60, y: (85 * temp) + 85)
                button.textAlignment = NSTextAlignment.Center
                button.layer.cornerRadius = 10
                button.clipsToBounds = true
                button.backgroundColor = UIColor(red: 129, green: 182, blue: 186)
                
                button.font = button.font.fontWithSize(17)
                //button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
                infoScroll.contentSize.height = CGFloat((85 * temp) + 185 + 40)
                infoScroll.addSubview(button)
            }
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        if (segue.identifier == "segueToGateway") {
            let segueID = segue!.destinationViewController as! Gateway
            
        }
    }
    
}
