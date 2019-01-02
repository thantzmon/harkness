//
//  Harkness.swift
//  Harkness
//
//  Created by Nicholas Brozey on 5/3/16.
//  Copyright © 2016 Tom Hantzmon. All rights reserved.
//

import UIKit
var locations = [CGPoint]()

class Harkness: UIViewController {
    
    @IBOutlet weak var Test_View: UIView!
    
    @IBOutlet weak var backButton: UIButton!
    var toPass:String!
    var presentList:[String]!
    var people = [UILabel]()
    var countofContributions = [String:Int]()
    var countofQuotes = [String:Int]()
    var countofAnswers = [String:Int]()
    var countofQuestions = [String:Int]()
    var countofOthers = [String:Int]()
    var discussionTitle = String()
    var topicDate = [String:NSDate]()
    
    @IBOutlet weak var swapButton: UIButton!
    @IBAction func switcherino(sender: AnyObject) {
        for name in people{
            var newButton = UIButton()
            newButton = UIButton(type: UIButtonType.System)
            
            newButton.setTitle(name.text, forState: UIControlState.Normal)
            newButton.backgroundColor = UIColor(red: 129, green: 182, blue: 186)
            newButton.bounds = CGRect(x: 0, y: 0, width: 75, height: 40)
            newButton.center = name.center
            newButton.layer.cornerRadius = 10
            newButton.clipsToBounds = true
            newButton.layer.borderWidth = 1
            newButton.titleLabel!.font =  UIFont(name: "Futura", size: 10)
            newButton.addTarget(self, action: #selector(Harkness.buttonClicked(_:)), forControlEvents: .TouchUpInside)
            
            view.addSubview(newButton)
            countofContributions[name.text!] = 0
            countofQuestions[name.text!] = 0
            countofQuotes[name.text!] = 0
            countofAnswers[name.text!] = 0
            countofOthers[name.text!] = 0
            
            
            swapButton.removeFromSuperview()
            
            for i in people{
                i.removeFromSuperview()
            }
        }
    }
    func buttonClicked(sender: UIButton?){
        
        var readyToContinue = false
        var refreshAlert = UIAlertController(title: "Contribution Type", message: "What kind of contribution was made?", preferredStyle: UIAlertControllerStyle.Alert)
        
        
        refreshAlert.addAction(UIAlertAction(title: "Quote", style: .Default, handler: { (action: UIAlertAction!) in
            self.countofQuotes[(sender!.titleLabel?.text)!] = self.countofQuotes[(sender!.titleLabel?.text)!]! + 1
            self.growButton(sender!)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Question", style: .Default, handler: { (action: UIAlertAction!) in
            self.countofQuestions[(sender!.titleLabel?.text)!] = self.countofQuestions[(sender!.titleLabel?.text)!]! + 1
            self.growButton(sender!)

        }))
        refreshAlert.addAction(UIAlertAction(title: "Answer to Question", style: .Default, handler: { (action: UIAlertAction!) in
            self.countofAnswers[(sender!.titleLabel?.text)!] = self.countofAnswers[(sender!.titleLabel?.text)!]! + 1
            self.growButton(sender!)

        }))
        refreshAlert.addAction(UIAlertAction(title: "Other", style: .Default, handler: { (action: UIAlertAction!) in
            self.countofOthers[(sender!.titleLabel?.text)!] = self.countofOthers[(sender!.titleLabel?.text)!]! + 1
            self.growButton(sender!)

        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            return
        }))
        presentViewController(refreshAlert, animated: true, completion: nil)

        
        
        
        
    }
    func growButton(sender: UIButton?){
        countofContributions[(sender!.titleLabel?.text)!] = countofContributions[(sender!.titleLabel?.text)!]! + 1
        var newButton = UIButton()
        newButton = UIButton(type: UIButtonType.System)
        
        newButton.setTitle(sender!.currentTitle, forState: UIControlState.Normal)
        newButton.backgroundColor = UIColor(red: 129, green: 182, blue: 186)
        newButton.layer.cornerRadius = 10
        newButton.clipsToBounds = true
        newButton.layer.borderWidth = 1
        newButton.bounds = CGRect(x: 0, y: 0, width: sender!.frame.width + 2, height: sender!.frame.height + 2)
        // let currentFontSize = newButton.titleLabel!.font.pointSize + CGFloat(1)
        //let label = newButton.titleLabel
        //  label?.minimumScaleFactor = 1
        //  label?.adjustsFontSizeToFitWidth = true
        //  label?.font = UIFont.systemFontOfSize(100)
        //newButton.titleLabel!.font = newButton.titleLabel!.font.fontWithSize(currentFontSize)
        newButton.titleLabel!.font =  UIFont(name: "Futura", size: 10)
        //  newButton.titleLabel!.adjustsFontSizeToFitWidth = true
        
        newButton.center = sender!.center
        
        
        newButton.addTarget(self, action: #selector(Harkness.buttonClicked(_:)), forControlEvents: .TouchUpInside)
        
        view.addSubview(newButton)
        sender!.removeFromSuperview()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var temp = 0
        for i in presentList{
            
            temp = temp+1
            let button = UILabel()
            //button = UIButton(type: UIButtonType.System)
            
            button.text = i
            button.bounds = CGRect(x: 0, y: 0, width: 75, height: 40)
            button.center = CGPoint(x: 150, y: (45 * temp) + 100)
            button.textAlignment = NSTextAlignment.Center
            button.layer.cornerRadius = 10
            button.clipsToBounds = true
            button.layer.borderWidth = 1
            button.backgroundColor = UIColor(red: 129, green: 182, blue: 186)
            
            button.font =  UIFont(name: "Futura", size: 10)
            
            // button.font = button.font.fontWithSize(10)
            //button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            
            view.addSubview(button)
            people.append(button)
            
        }
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(animated: Bool) {
        var alert = UIAlertController(title: "Discussion Title", message: "Enter the topic of today's discussion", preferredStyle: .Alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = "Topic"
        })
        
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let textField = alert.textFields![0] as UITextField
            self.discussionTitle = textField.text!
            
            if NSUserDefaults.standardUserDefaults().objectForKey(NSUserDefaults.standardUserDefaults().objectForKey("Class")! as! String + "Discussions") != nil{
                let previousTitles = NSUserDefaults.standardUserDefaults().objectForKey(NSUserDefaults.standardUserDefaults().objectForKey("Class")! as! String + "Discussions")! as! [String:String]
                for title in previousTitles{
                    if title.1 == self.discussionTitle{
                        var alert = UIAlertController(title: "Title Already Used", message: "Please enter a unique topic for today's discussion", preferredStyle: .Alert)
                        
                        //2. Add the text field. You can configure it however you need.
                        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
                            textField.text = "Topic"
                        })
                        
                        //3. Grab the value from the text field, and print it when the user clicks OK.
                        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                            let textField = alert.textFields![0] as UITextField
                            self.discussionTitle = textField.text!
                            
                            if NSUserDefaults.standardUserDefaults().objectForKey(NSUserDefaults.standardUserDefaults().objectForKey("Class")! as! String + "Discussions") != nil{
                                let previousTitles = NSUserDefaults.standardUserDefaults().objectForKey(NSUserDefaults.standardUserDefaults().objectForKey("Class")! as! String + "Discussions")! as! [String:String]
                                for title in previousTitles{
                                    if title.1 == self.discussionTitle{
                                        self.presentViewController(alert, animated: true, completion: nil)
                                    }
                                }
                            }
                        }))
                        
                        // 4. Present the alert.
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                }
            }
        }))
        
        // 4. Present the alert.
        self.presentViewController(alert, animated: true, completion: nil)
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in (touches ){
            let location = touch.locationInView(self.view)
            for buttons in people{
                if buttons.frame.contains(location){
                    buttons.center = location
                    break;
                }
            }
        }
        
    }
    
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        if (segue.identifier == "segueToAttendance") {
            let segueID = segue!.destinationViewController as! HarkPrep
            segueID.toPass = toPass
            
        }else if(segue.identifier == "segueToWrapUp"){
            let date = NSDate()
            /*
             let calendar = NSCalendar.currentCalendar()
             let components = calendar.components([.Day, .Month, .Year, .Hour, .Minute], fromDate: date)
             let year = components.year
             let month = components.month
             let day = components.day
             let hour = components.hour
             let minute = components.minute
             var newMinute = ""
             if(minute < 10){
             newMinute = "0" + String(minute)
             }else{
             newMinute = String(minute)
             }
             let dateString = String(month) + "/" + String(day) + "/" + String(year) + " " + String(hour) + ":" + newMinute
             */
            

            
            
            let className = NSUserDefaults.standardUserDefaults().objectForKey("Class")!
            
            if NSUserDefaults.standardUserDefaults().objectForKey((className as! String) + "dates") != nil {
                topicDate = NSUserDefaults.standardUserDefaults().objectForKey((className as! String) + "dates")! as! [String:NSDate]
                topicDate[discussionTitle] = date
            } else{
                topicDate = [discussionTitle:date]
            }
            NSUserDefaults.standardUserDefaults().setObject(topicDate, forKey: (className as! String) + "dates")
            
            var allNames = [String]()
            
            if((NSUserDefaults.standardUserDefaults().objectForKey("allNames")) == nil){
                
            }else{
                allNames = NSUserDefaults.standardUserDefaults().objectForKey("allNames")! as! [String]
                
            }
            var newDiscussionName = randomStringWithLength(10)
            while allNames.contains(newDiscussionName as String) {
                newDiscussionName = randomStringWithLength(10)
            }
            allNames.append(newDiscussionName as String)
            NSUserDefaults.standardUserDefaults().setObject(allNames, forKey: "allNames")
            var discussionsInClass:[String:String]!
            let key = String(className) + "Discussions"
            if(NSUserDefaults.standardUserDefaults().objectForKey(key) == nil){
                discussionsInClass = [newDiscussionName as String:discussionTitle]
                
            }else{
                discussionsInClass = NSUserDefaults.standardUserDefaults().objectForKey(key)! as! [String : String]
                discussionsInClass[newDiscussionName as String] = discussionTitle
            }
            

            
            
            NSUserDefaults.standardUserDefaults().setObject(discussionsInClass, forKey: String(className) + "Discussions")
            NSUserDefaults.standardUserDefaults().setObject(countofContributions, forKey: newDiscussionName as String)
            NSUserDefaults.standardUserDefaults().setObject(countofQuestions, forKey: newDiscussionName as String + "Questions")
            NSUserDefaults.standardUserDefaults().setObject(countofAnswers, forKey: newDiscussionName as String + "Answers")
            NSUserDefaults.standardUserDefaults().setObject(countofQuotes, forKey: newDiscussionName as String + "Quotes")
            NSUserDefaults.standardUserDefaults().setObject(countofOthers, forKey: newDiscussionName as String + "Others")
            
            
            
            
            
            NSUserDefaults.standardUserDefaults().synchronize()
            
            let segueID = segue!.destinationViewController as! WrapUp
            segueID.contributions = countofContributions
            segueID.discussionName = newDiscussionName as String
        }
    }
    
}

func randomStringWithLength (len : Int) -> NSString {
    
    let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    
    let randomString : NSMutableString = NSMutableString(capacity: len)
    
    for (var i=0; i < len; i = i + 1){
        let length = UInt32 (letters.length)
        let rand = arc4random_uniform(length)
        randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
    }
    
    return randomString
}
