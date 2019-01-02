//
//  CreateClass.swift
//  harkness
//
//  Created by Tom Hantzmon on 5/20/16.
//  Copyright © 2016 Tom Hantzmon. All rights reserved.
//



import UIKit

class CreateClass: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var finishedNames: UIScrollView!
    @IBOutlet weak var confirmName: UIButton!
    @IBOutlet weak var className: UITextField!
    @IBOutlet weak var studentName: UITextField!
    @IBOutlet weak var backButton: UIButton!
    
    var nameButtons:[UIButton:UILabel]!
    var labels = [UILabel]()
    var buttons = [UIButton]()
    var names = [String]()
    
    @IBAction func addStudent(sender: AnyObject) {
        if(studentName.text == "") {return}
        for name in names{
            if studentName.text == name{
                let alertController = UIAlertController(title: "Invalid Name", message: "That name has already been picked.", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)

                return
            }
        }
        names.append(studentName.text!)
        for label in labels{
            label.center.y = label.center.y + 85
        }
        for button in buttons{
            button.center.y = button.center.y + 85
        }
        
        let name = studentName.text
        
        let button = UILabel()
        //button = UIButton(type: UIButtonType.System)
        height = (85 * onStudent) + 100.0
        if height < Double((1.9/3) * UIScreen.mainScreen().bounds.height - 83){
            height = Double((1.9/3) * UIScreen.mainScreen().bounds.height - 83)
        }
        finishedNames.contentSize.height = CGFloat(height)
        
        button.text = name
        button.bounds = CGRect(x: 0, y: 0, width: 300, height: 80)
        button.center = CGPoint(x: 300, y: 60)
        onStudent = onStudent + 1
        button.backgroundColor = UIColor(red: 155, green: 215, blue: 179)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.textAlignment = NSTextAlignment.Center
        
        
        
        button.font = button.font.fontWithSize(17)
        //button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        studentList.append(studentName.text!)
        studentName.text = ""
        
        
        let delete = UIImage(named: "delete.png")! as UIImage
        
        let deleteButton = UIButton()
        deleteButton.bounds = CGRect(x: 0, y: 0, width: 80, height: 80)
        deleteButton.center = CGPoint(x: 500, y: 60)
        deleteButton.setBackgroundImage(delete, forState: UIControlState.Normal)
        deleteButton.setTitle(String(onStudent), forState: UIControlState.Normal)
        deleteButton.titleLabel!.layer.opacity = 0.0
        if(nameButtons == nil){
            nameButtons = [deleteButton:button]
        }else{
            nameButtons[deleteButton] = button
            
        }
        finishedNames.addSubview(button)
        finishedNames.addSubview(deleteButton)
        labels.append(button)
        buttons.append(deleteButton)
        
        deleteButton.addTarget(self, action: #selector(Harkness.buttonClicked(_:)), forControlEvents: .TouchUpInside)
        
        
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func buttonClicked(sender: UIButton?){
        sender!.removeFromSuperview()
        nameButtons[sender!]!.removeFromSuperview()
        studentList.removeAtIndex(studentList.indexOf((nameButtons[sender!]?.text)!)!)
        
        for label in labels{
            if sender!.center.y < label.center.y{
                label.center.y = label.center.y - 85
            }
        }
        for button in buttons{
            if sender!.center.y < button.center.y{
                button.center.y = button.center.y - 85
            }
        }
        
        onStudent = onStudent - 1.0
        height = (85 * onStudent) + 100.0
        if height < Double((1.9/3) * UIScreen.mainScreen().bounds.height - 83){
            height = Double((1.9/3) * UIScreen.mainScreen().bounds.height - 83)
        }
        finishedNames.contentSize.height = CGFloat(height)
        
    }
    
    var onStudent = 0.0
    var height = 0.0
    var studentList = [String]()
    var classList = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        finishedNames.delegate = self
        finishedNames.contentSize.height = CGFloat((1.9/3) * UIScreen.mainScreen().bounds.height - 83)
        finishedNames.keyboardDismissMode = UIScrollViewKeyboardDismissMode.Interactive
        studentNames.removeAll()
        backButton.layer.zPosition = CGFloat.max
        if(NSUserDefaults.standardUserDefaults().objectForKey("classList") != nil){
            classList = NSUserDefaults.standardUserDefaults().objectForKey("classList")! as! [String]
            if String(classes) == "[]" {
                backButton.removeFromSuperview()
            }
        }else{
            backButton.removeFromSuperview()
        }
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if (classList.contains(className.text!) && identifier == "segueToGateway"){
            let refreshAlert = UIAlertController(title: "Invalid Class", message: "Class Name Already Used", preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            }))
            
            presentViewController(refreshAlert, animated: true, completion: nil)
            return false
        }else if(studentList.isEmpty && identifier == "segueToGateway"){
            let refreshAlert = UIAlertController(title: "Invalid Students", message: "No Students Are In This Class", preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            }))
            
            
            presentViewController(refreshAlert, animated: true, completion: nil)
            
            return false
        }else if(className.text == "" && identifier == "segueToGateway"){
            let refreshAlert = UIAlertController(title: "Invalid Students", message: "Your class does not have a name", preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            }))
            
            
            presentViewController(refreshAlert, animated: true, completion: nil)
            
            return false
        }else{
            return true;
        }
    }
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        if (segue.identifier == "segueToGateway") {
            if !classList.contains(className.text!) {
                classList.append(className.text!)
                studentNames = studentList
                NSUserDefaults.standardUserDefaults().setObject(classList, forKey: "classList")
                NSUserDefaults.standardUserDefaults().setObject(className.text!, forKey: "Class")
                NSUserDefaults.standardUserDefaults().setObject(studentNames, forKey: className.text!)
                NSUserDefaults.standardUserDefaults().synchronize()
            }
            
            
        }
    }
    @IBAction func onGeneration(sender: AnyObject) {
        
        //viewcontroller.newClass(classname.text , studentList)
        
    }
    
}
