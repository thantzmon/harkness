//
//  ViewController.swift
//  harkness
//
//  Created by Tom Hantzmon and yeah boi nb up in da kitchen on 4/30/16.
//  Copyright © 2016 Tom Hantzmon. All rights reserved.
//


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}

let memoryKey = NSUserDefaults.standardUserDefaults()
var classes = [String]()
var studentNames = [String]()
import UIKit
var classUsed = ""
var temp = 0.0
var height = 0.0

var classNames:[UIButton:UIButton]!

class Home: UIViewController {
        
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        temp = 0.0
                
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("classList") != nil){
            classes = NSUserDefaults.standardUserDefaults().objectForKey("classList")! as! [String]
            if String(classes) == "[]" {
                dispatch_async(dispatch_get_main_queue()) {
                    [unowned self] in
                    self.performSegueWithIdentifier("segueToCreateClass", sender: self)
                }

            }
        }else{
            
            dispatch_async(dispatch_get_main_queue()) {
                [unowned self] in
                self.performSegueWithIdentifier("segueToCreateClass", sender: self)
            }
            
        }
        
        for i in classes{
            height = (85 * temp) + 100.0
            scrollView.contentSize.height = CGFloat(height)
            var button = UIButton()
            button = UIButton(type: UIButtonType.System)
            
            button.setTitle(i, forState: UIControlState.Normal)
            
            button.bounds = CGRect(x: 0, y: 0, width: 300, height: 80)
            button.center = CGPoint(x: 300, y: (85 * temp) + 50)
            temp = temp+1
            button.backgroundColor = UIColor(red: 239, green: 121, blue: 111)
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 1
            
            button.titleLabel?.font = UIFont.systemFontOfSize(17)
            button.setTitleColor(UIColor(red: 64, green: 76, blue: 83), forState: UIControlState.Normal)
            
            button.addTarget(self, action: #selector(Home.selectButtonClicked(_:)), forControlEvents: .TouchUpInside)
            
            
            let delete = UIImage(named: "settings")! as UIImage
            
            let deleteButton = UIButton()
            deleteButton.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
            deleteButton.center = CGPoint(x: 460, y: (85 * (temp-1)) + 20)
            deleteButton.setBackgroundImage(delete, forState: UIControlState.Normal)
            deleteButton.setTitle(String(temp), forState: UIControlState.Normal)
            deleteButton.titleLabel!.layer.opacity = 0.0
            deleteButton.layer.cornerRadius = 5
            deleteButton.layer.borderWidth = 1

            if(classNames == nil){
                classNames = [deleteButton:button]
            }else{
                classNames[deleteButton] = button
                
            }
            
            deleteButton.addTarget(self, action: #selector(Harkness.buttonClicked(_:)), forControlEvents: .TouchUpInside)
            
            scrollView.addSubview(deleteButton)
            deleteButton.layer.zPosition = CGFloat.max
            scrollView.addSubview(button)
            
        }
        
        
    }
    func buttonClicked(sender: UIButton?){
        
        var refreshAlert = UIAlertController(title: "Settings", message: "What would you like to do?", preferredStyle: UIAlertControllerStyle.Alert)
        
        
        refreshAlert.addAction(UIAlertAction(title: "Delete Class", style: .Default, handler: { (action: UIAlertAction!) in
            
            sender!.removeFromSuperview()
            classNames[sender!]!.removeFromSuperview()
            let removedName = classNames[sender!]?.titleLabel!.text
            let indexOfButton = classes.indexOf((classNames[sender!]?.titleLabel!.text)!)!
            classes.removeAtIndex(indexOfButton)
            NSUserDefaults.standardUserDefaults().setObject(classes, forKey: "classList")
            for button in classNames{
                if(Double((sender!.titleLabel?.text)!) < Double((button.0.titleLabel?.text)!)){
                    var firstCenter = button.0.center
                    var secondCenter = button.1.center
                    firstCenter.y = firstCenter.y - 85
                    secondCenter.y = secondCenter.y - 85
                    button.0.center = firstCenter
                    button.1.center = secondCenter
                    
                }
                button.0.setTitle(String(Double((button.0.titleLabel?.text)!)! - 1) , forState: UIControlState.Normal)
            }
            temp = temp - 1.0
            NSUserDefaults.standardUserDefaults().setObject(nil, forKey: removedName!)
            NSUserDefaults.standardUserDefaults().setObject(nil, forKey: removedName! + "Discussions")
        
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Rename Class", style: .Default, handler: { (action: UIAlertAction!) in
            
            var alert = UIAlertController(title: "New Class Name", message: "Enter the new class name", preferredStyle: .Alert)
            
            //2. Add the text field. You can configure it however you need.
            alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
                textField.text = (classNames[sender!]?.titleLabel!.text)!
            })
            
            //3. Grab the value from the text field, and print it when the user clicks OK.
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
                let textField = alert.textFields![0] as UITextField

                let indexOfButton = classes.indexOf((classNames[sender!]?.titleLabel!.text)!)!
                classes.removeAtIndex(indexOfButton)

                classes.append(textField.text!)
                NSUserDefaults.standardUserDefaults().setObject(classes, forKey: "classList")

                classNames[sender!]?.setTitle(textField.text!, forState: UIControlState.Normal)
                NSUserDefaults.standardUserDefaults().setObject(NSUserDefaults.standardUserDefaults().objectForKey((classNames[sender!]?.titleLabel!.text)!), forKey: textField.text!)
                NSUserDefaults.standardUserDefaults().setObject(NSUserDefaults.standardUserDefaults().objectForKey((classNames[sender!]?.titleLabel!.text)! + "Discussions"), forKey: textField.text! + "Discussions")
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: (classNames[sender!]?.titleLabel!.text)!)
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: (classNames[sender!]?.titleLabel!.text)! + "Discussions")

            }))
            
            // 4. Present the alert.
            self.presentViewController(alert, animated: true, completion: nil)

            
            
        }))
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
        }))

        presentViewController(refreshAlert, animated: true, completion: nil)

        
        
        
        
    }
    var clickedButton = UIButton()
    var clickedButtonText = ""
    func selectButtonClicked(sender: UIButton?){
        
        
        if sender!.backgroundColor == UIColor(red: 239, green: 121, blue: 111){
            sender!.backgroundColor = UIColor(red: 155, green: 215, blue: 179)
            clickedButton.backgroundColor = UIColor(red: 239, green: 121, blue: 111)
            clickedButton = sender!
            clickedButtonText = (clickedButton.titleLabel?.text)!
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if (clickedButtonText == "" && identifier == "segueToGateway"){
            let refreshAlert = UIAlertController(title: "Invalid Class", message: "No Class Selected", preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            }))
            
            
            presentViewController(refreshAlert, animated: true, completion: nil)
            
            return false
        }else{
            return true
        }
    }
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        if (segue.identifier == "segueToGateway") {
            NSUserDefaults.standardUserDefaults().setObject(clickedButtonText, forKey: "Class")
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }else if (segue.identifier == "segueToMakeClass"){
            
        }
    }
}
