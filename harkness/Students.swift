//
//  Students.swift
//  Harkness
//
//  Created by Nicholas Brozey on 5/2/16.
//  Copyright © 2016 Tom Hantzmon. All rights reserved.
//

import UIKit

class Students: UIViewController, UIPopoverPresentationControllerDelegate {
    
    
    var toPass:String!
    var height = 0.0
    var temp = 0.0
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var contributionsScroll: UIScrollView!
    @IBOutlet weak var studentScroll: UIScrollView!
    var studentList = [String]()
    let className = NSUserDefaults.standardUserDefaults().objectForKey("Class")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton.layer.zPosition = CGFloat.max
        // Do any additional setup after loading the view.
        
        let students = NSUserDefaults.standardUserDefaults().objectForKey(className! as! String)
        for student in students! as! [String]{
            studentList.append(student)
            
            height = (85 * temp) + 100.0
            studentScroll.contentSize.height = CGFloat(height)
            var button = UIButton()
            button = UIButton(type: UIButtonType.System)
            
            button.setTitle(student, forState: UIControlState.Normal)
            
            button.bounds = CGRect(x: 0, y: 0, width: 150, height: 80)
            button.center = CGPoint(x: 75, y: (85 * temp) + 50)
            temp = temp+1
            button.backgroundColor = UIColor(red: 239, green: 121, blue: 111)
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 1
            
            button.titleLabel?.font = UIFont.systemFontOfSize(17)
            button.setTitleColor(UIColor(red: 64, green: 76, blue: 83), forState: UIControlState.Normal)
            
            button.addTarget(self, action: #selector(Home.selectButtonClicked(_:)), forControlEvents: .TouchUpInside)
            studentScroll.addSubview(button)
        }
    }
    var classDiscussions: [String:String]!
    var clickedButton = UIButton()
    var clickedButtonText = ""
    var theDiscussion: [String:Int]!
    var buttonsToBeRemoved = [UILabel]()
    func selectButtonClicked(sender: UIButton?){
        if sender!.backgroundColor == UIColor(red: 239, green: 121, blue: 111){
            sender!.backgroundColor = UIColor(red: 155, green: 215, blue: 179)
            clickedButton.backgroundColor = UIColor(red: 239, green: 121, blue: 111)
            clickedButton = sender!
            clickedButtonText = (clickedButton.titleLabel?.text)!
        }else{
            NSUserDefaults.standardUserDefaults().setObject(sender!.titleLabel?.text, forKey: "NotesStudent")
            self.performSegueWithIdentifier("segueToNotes", sender: self)
        }
        for i in buttonsToBeRemoved{
            i.removeFromSuperview()
        }
        var dates = [String]()
        dates.removeAll()
        let currentClass = NSUserDefaults.standardUserDefaults().objectForKey("Class")! as! String + "Discussions"
        let studentName = sender!.titleLabel?.text
        if(NSUserDefaults.standardUserDefaults().objectForKey(currentClass) != nil){
            classDiscussions = NSUserDefaults.standardUserDefaults().objectForKey(currentClass)! as! [String:String]
            
            for discussion in classDiscussions{
                dates.append(discussion.1)
            }
            for date in dates{
                for i in 1..<dates.count{
                    if(dates[i-1] > dates[i]){
                        let temp = dates[i-1]
                        dates[i-1] = dates[i]
                        dates[i] = temp
                    }
                }
            }
        }
        var onDate = 0.0
        for date in dates{
            
            for discussion in classDiscussions{
                if(date == discussion.1){
                    var onStudent = 0.0
                    theDiscussion = NSUserDefaults.standardUserDefaults().objectForKey(discussion.0)! as! [String : Int]
                    var quoteDiscussion = NSUserDefaults.standardUserDefaults().objectForKey(discussion.0 + "Quotes")! as! [String : Int]
                    var questionDiscussion = NSUserDefaults.standardUserDefaults().objectForKey(discussion.0 + "Questions")! as! [String : Int]
                    var answerDiscussion = NSUserDefaults.standardUserDefaults().objectForKey(discussion.0 + "Answers")! as! [String : Int]
                    var otherDiscussion = NSUserDefaults.standardUserDefaults().objectForKey(discussion.0 + "Others")! as! [String : Int]

                    for person in theDiscussion {
                        if person.0 == studentName{
                            let dateButton = UILabel()
                            //button = UIButton(type: UIButtonType.System)
                            height = (85 * onStudent) + 100.0
                            contributionsScroll.contentSize.height = CGFloat(height)
                            dateButton.text = String(dates[Int(onDate)])
                            dateButton.font = dateButton.font.fontWithSize(10)
                            dateButton.bounds = CGRect(x: 0, y: 0, width: 100, height: 40)
                            dateButton.center = CGPoint(x: (125 * onDate) + 75, y: (65 * onStudent) + 30)
                            contributionsScroll.contentSize.width = CGFloat((125 * onDate) + 150)
                            dateButton.textAlignment = NSTextAlignment.Center
                            onStudent = onStudent + 1
                            dateButton.backgroundColor = UIColor(red: 155, green: 215, blue: 179)
                            dateButton.layer.cornerRadius = 10
                            dateButton.clipsToBounds = true
                            buttonsToBeRemoved.append(dateButton)
                            contributionsScroll.addSubview(dateButton)

                            for quote in quoteDiscussion{
                                if quote.0 == studentName{
                                    let button = UILabel()
                                    height = (85 * onStudent) + 100.0
                                    contributionsScroll.contentSize.height = CGFloat(height)
                                    button.text = String(quote.1)
                                    button.bounds = CGRect(x: 0, y: 0, width: 100, height: 40)
                                    button.center = CGPoint(x: (125 * onDate) + 75, y: (65 * onStudent) + 30)
                                    button.textAlignment = NSTextAlignment.Center
                                    onStudent = onStudent + 1
                                    button.backgroundColor = UIColor(red: 155, green: 215, blue: 179)
                                    button.layer.cornerRadius = 10
                                    button.clipsToBounds = true
                                    buttonsToBeRemoved.append(button)
                                    contributionsScroll.addSubview(button)
                                }
                            }
                            
                            for question in questionDiscussion{
                                if question.0 == studentName{
                                    let button = UILabel()
                                    height = (85 * onStudent) + 100.0
                                    contributionsScroll.contentSize.height = CGFloat(height)
                                    button.text = String(question.1)
                                    button.bounds = CGRect(x: 0, y: 0, width: 100, height: 40)
                                    button.center = CGPoint(x: (125 * onDate) + 75, y: (65 * onStudent) + 30)
                                    button.textAlignment = NSTextAlignment.Center
                                    onStudent = onStudent + 1
                                    button.backgroundColor = UIColor(red: 155, green: 215, blue: 179)
                                    button.layer.cornerRadius = 10
                                    button.clipsToBounds = true
                                    buttonsToBeRemoved.append(button)
                                    contributionsScroll.addSubview(button)
                                }
                            }
                            
                            for answer in answerDiscussion{
                                if answer.0 == studentName{
                                    let button = UILabel()
                                    height = (85 * onStudent) + 100.0
                                    contributionsScroll.contentSize.height = CGFloat(height)
                                    button.text = String(answer.1)
                                    button.bounds = CGRect(x: 0, y: 0, width: 100, height: 40)
                                    button.center = CGPoint(x: (125 * onDate) + 75, y: (65 * onStudent) + 30)
                                    button.textAlignment = NSTextAlignment.Center
                                    onStudent = onStudent + 1
                                    button.backgroundColor = UIColor(red: 155, green: 215, blue: 179)
                                    button.layer.cornerRadius = 10
                                    button.clipsToBounds = true
                                    buttonsToBeRemoved.append(button)
                                    contributionsScroll.addSubview(button)
                                }
                            }
                            
                            for other in otherDiscussion{
                                if other.0 == studentName{
                                    let button = UILabel()
                                    height = (85 * onStudent) + 100.0
                                    contributionsScroll.contentSize.height = CGFloat(height)
                                    button.text = String(other.1)
                                    button.bounds = CGRect(x: 0, y: 0, width: 100, height: 40)
                                    button.center = CGPoint(x: (125 * onDate) + 75, y: (65 * onStudent) + 30)
                                    button.textAlignment = NSTextAlignment.Center
                                    onStudent = onStudent + 1
                                    button.backgroundColor = UIColor(red: 155, green: 215, blue: 179)
                                    button.layer.cornerRadius = 10
                                    button.clipsToBounds = true
                                    buttonsToBeRemoved.append(button)
                                    contributionsScroll.addSubview(button)
                                }
                            }



                            
                            let button = UILabel()
                            //button = UIButton(type: UIButtonType.System)
                            height = (85 * onStudent) + 100.0
                            contributionsScroll.contentSize.height = CGFloat(height)
                            button.text = String(person.1)
                            button.bounds = CGRect(x: 0, y: 0, width: 100, height: 40)
                            button.center = CGPoint(x: (125 * onDate) + 75, y: (65 * onStudent) + 30)
                            button.textAlignment = NSTextAlignment.Center
                            onDate = onDate + 1
                            onStudent = onStudent + 1
                            button.backgroundColor = UIColor(red: 155, green: 215, blue: 179)
                            button.layer.cornerRadius = 10
                            button.clipsToBounds = true
                            buttonsToBeRemoved.append(button)
                            contributionsScroll.addSubview(button)
                            
                        }
                        //so "person is an array of 2 strings (i think) person.0 being the name and person.1 being the contributions"
                    }
                }
            }
        }
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
            
        }else if (segue.identifier == "segueToNotes"){
            print("this happens")
            var vc = segue.destinationViewController as! UIViewController
            var controller = vc.popoverPresentationController
            print("1")
            if controller != nil{
                controller?.delegate = self
                print("2")
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    
    func popoverPresentationControllerDidDismissPopover(popoverPresentationController: UIPopoverPresentationController) {
        print("is this correct bruh?")
    }
    
}
