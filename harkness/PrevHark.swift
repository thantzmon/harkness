//
//  PrevHark.swift
//  harkness
//
//  Created by Tom Hantzmon on 5/19/16.
//  Copyright © 2016 Tom Hantzmon. All rights reserved.
//

import UIKit


class PrevHark: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var dates: UIScrollView!
    @IBOutlet weak var names: UIScrollView!
    @IBOutlet weak var quotes: UIScrollView!
    @IBOutlet weak var questions: UIScrollView!
    @IBOutlet weak var answers: UIScrollView!
    @IBOutlet weak var other: UIScrollView!
    @IBOutlet weak var ticks: UIScrollView!
    
    var dateList = [String]()
    var nameList = [String]()
    var contributionsList = [String]()
    var quoteList = [String]()
    var questionList = [String]()
    var answerList = [String]()
    var otherList = [String]()
    
    func scrollViewDidScroll(scrollView: UIScrollView){
        if(scrollView == names){
            ticks.contentOffset.y = names.contentOffset.y
            quotes.contentOffset.y = names.contentOffset.y
            questions.contentOffset.y = names.contentOffset.y
            answers.contentOffset.y = names.contentOffset.y
            other.contentOffset.y = names.contentOffset.y
        }
        if(scrollView == ticks){
            names.contentOffset.y = ticks.contentOffset.y
            quotes.contentOffset.y = ticks.contentOffset.y
            questions.contentOffset.y = ticks.contentOffset.y
            answers.contentOffset.y = ticks.contentOffset.y
            other.contentOffset.y = ticks.contentOffset.y
        }
        if(scrollView == quotes){
            names.contentOffset.y = quotes.contentOffset.y
            ticks.contentOffset.y = quotes.contentOffset.y
            questions.contentOffset.y = quotes.contentOffset.y
            answers.contentOffset.y = quotes.contentOffset.y
            other.contentOffset.y = quotes.contentOffset.y
            
        }
        if(scrollView == questions){
            names.contentOffset.y = questions.contentOffset.y
            quotes.contentOffset.y = questions.contentOffset.y
            ticks.contentOffset.y = questions.contentOffset.y
            answers.contentOffset.y = questions.contentOffset.y
            other.contentOffset.y = questions.contentOffset.y
            
        }
        if(scrollView == answers){
            names.contentOffset.y = answers.contentOffset.y
            quotes.contentOffset.y = answers.contentOffset.y
            questions.contentOffset.y = answers.contentOffset.y
            ticks.contentOffset.y = answers.contentOffset.y
            other.contentOffset.y = answers.contentOffset.y
            
        }
        if(scrollView == other){
            names.contentOffset.y = other.contentOffset.y
            quotes.contentOffset.y = other.contentOffset.y
            questions.contentOffset.y = other.contentOffset.y
            answers.contentOffset.y = other.contentOffset.y
            ticks.contentOffset.y = other.contentOffset.y
            
        }
    }
    
    
    var toPass:String!
    //Trevor use class to select all the data from the harkness
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        names.delegate = self
        ticks.delegate = self
        quotes.delegate = self
        questions.delegate = self
        answers.delegate = self
        other.delegate = self
        
        // Do any additional setup after loading the view.
        
        
        //Trevor instead of these hard coded dates, put in the dates of the discussion as a string
        var contributions:[String:Int]!
        var classDiscussions: [String:String]!
        var theDiscussion: [String:Int]!
        let className = NSUserDefaults.standardUserDefaults().objectForKey("Class")! as! String
        let currentClass = NSUserDefaults.standardUserDefaults().objectForKey("Class")! as! String + "Discussions"
        if(NSUserDefaults.standardUserDefaults().objectForKey(currentClass) != nil){
            classDiscussions = NSUserDefaults.standardUserDefaults().objectForKey(currentClass)! as! [String:String]
            for discussion in classDiscussions{
                dateList.append(discussion.1)
            }
        }
        if NSUserDefaults.standardUserDefaults().objectForKey(className + "dates") != nil  {
            var topicDates = NSUserDefaults.standardUserDefaults().objectForKey(className + "dates")! as! [String:NSDate]
            
            
            
            for i in 1...dateList.count{
                for j in 1..<dateList.count{
                    if ((topicDates[dateList[j-1]]?.compare(topicDates[dateList[j]]!)) == NSComparisonResult.OrderedAscending){
                        let temp = dateList[j-1]
                        dateList[j-1] = dateList[j]
                        dateList[j] = temp
                    }
                }
            }
        }
        var temp = 0.0
        var height = 0.0
        
        
        for i in dateList{
            height = (85 * temp) + 100.0
            dates.contentSize.height = CGFloat(height)
            var button = UIButton()
            button = UIButton(type: UIButtonType.System)
            
            button.setTitle(i, forState: UIControlState.Normal)
            button.bounds = CGRect(x: 0, y: 0, width: 163, height: 80)
            button.center = CGPoint(x: 100, y: (85 * temp) + 80)
            temp = temp + 1.0
            button.backgroundColor = UIColor(red: 239, green: 121, blue: 111)
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 1
            
            
            button.titleLabel?.font = UIFont.systemFontOfSize(17)
            button.setTitleColor(UIColor(red: 64, green: 76, blue: 83), forState: UIControlState.Normal)
            
            button.addTarget(self, action: #selector(PrevHark.buttonClicked(_:)), forControlEvents: .TouchUpInside)
            
            dates.addSubview(button)
        }
        
        
        
        
    }
    
    var clickedButton = UIButton()
    var clickedButtonText = ""
    var currentNameButtons = [UILabel]()
    var currentContributionsButtons = [UILabel]()
    func buttonClicked(sender: UIButton?){
        if sender!.backgroundColor == UIColor(red: 239, green: 121, blue: 111){
            sender!.backgroundColor = UIColor(red: 155, green: 215, blue: 179)
            clickedButton.backgroundColor = UIColor(red: 239, green: 121, blue: 111)
            clickedButton = sender!
            clickedButtonText = (clickedButton.titleLabel?.text)!
        }else{
            if NSUserDefaults.standardUserDefaults().objectForKey("discussionDescriptions") != nil{
                let descriptions = NSUserDefaults.standardUserDefaults().objectForKey("discussionDescriptions")! as! [String:String]
                let className = NSUserDefaults.standardUserDefaults().objectForKey("Class")! as! String
                let discussions = NSUserDefaults.standardUserDefaults().objectForKey(className + "Discussions")! as! [String:String]
                for description in descriptions{
                    for discussion in discussions{
                        if sender!.titleLabel?.text == discussion.1 {
                            if discussion.0 == description.0 {
                                let alertController = UIAlertController(title: discussion.1, message:
                                    description.1, preferredStyle: UIAlertControllerStyle.Alert)
                                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                                
                                self.presentViewController(alertController, animated: true, completion: nil)

                                print(description.1)
                            }
                        }
                    }
                    
                }
            }
        }
        var temp = 0.0
        var height = 0.0
        var contributions:[String:Int]!
        var classDiscussions: [String:String]!
        var theDiscussion: [String:Int]!
        let currentClass = NSUserDefaults.standardUserDefaults().objectForKey("Class")! as! String + "Discussions"
        classDiscussions = NSUserDefaults.standardUserDefaults().objectForKey(currentClass)! as! [String:String]
        nameList.removeAll()
        for discussion in classDiscussions{
            theDiscussion = NSUserDefaults.standardUserDefaults().objectForKey(discussion.0)! as! [String : Int]
            let quoteDiscussion = NSUserDefaults.standardUserDefaults().objectForKey(discussion.0 + "Quotes")! as! [String : Int]
            let questionDiscussion = NSUserDefaults.standardUserDefaults().objectForKey(discussion.0 + "Questions")! as! [String : Int]
            let answerDiscussion = NSUserDefaults.standardUserDefaults().objectForKey(discussion.0 + "Answers")! as! [String : Int]
            let otherDiscussion = NSUserDefaults.standardUserDefaults().objectForKey(discussion.0 + "Others")! as! [String : Int]
            let date = discussion.1
            if(date == sender!.titleLabel?.text){
                for person in theDiscussion{
                    nameList.append(person.0)
                    contributionsList.append(String(person.1))
                    
                    for discussion in quoteDiscussion{
                        if person.0 == discussion.0{
                            quoteList.append(String(discussion.1))
                        }
                    }
                    for discussion in questionDiscussion{
                        if person.0 == discussion.0{
                            questionList.append(String(discussion.1))
                        }
                    }
                    for discussion in answerDiscussion{
                        if person.0 == discussion.0{
                            answerList.append(String(discussion.1))
                        }
                    }
                    for discussion in otherDiscussion{
                        if person.0 == discussion.0{
                            otherList.append(String(discussion.1))
                        }
                    }
                    
                }
                
            }
        }
        for nameButton in currentNameButtons{
            nameButton.removeFromSuperview()
        }
        currentNameButtons.removeAll()
        for i in nameList{
            
            
            height = (85 * temp) + 100.0
            names.contentSize.height = CGFloat(height)
            var button = UILabel()
            button = UILabel()
            
            button.text = i
            
            button.bounds = CGRect(x: 0, y: 0, width: 113, height: 80)
            button.center = CGPoint(x: 61.5, y: (85 * temp) + 80)
            temp = temp+1
            button.backgroundColor = UIColor(red: 135, green: 178, blue: 153)
            button.layer.cornerRadius = 10
            button.clipsToBounds = true
            button.textAlignment = NSTextAlignment.Center
            
            button.font = button.font.fontWithSize(17)
            button.textColor = UIColor(red: 64, green: 76, blue: 83)
            currentNameButtons.append(button)
            
            names.addSubview(button)
        }
        temp = 0.0
        height = 0.0
        for button in currentContributionsButtons{
            button.removeFromSuperview()
        }
        currentContributionsButtons.removeAll()
        for i in contributionsList{
            height = (85 * temp) + 100.0
            ticks.contentSize.height = CGFloat(height)
            names.contentSize.height = CGFloat(height)
            quotes.contentSize.height = CGFloat(height)
            questions.contentSize.height = CGFloat(height)
            answers.contentSize.height = CGFloat(height)
            other.contentSize.height = CGFloat(height)
            
            
            
            let button = UILabel()
            button.text = i
            button.bounds = CGRect(x: 0, y: 0, width: 80, height: 80)
            button.center = CGPoint(x: 45, y: (85 * temp) + 80)
            temp = temp+1
            button.backgroundColor = UIColor(red: 135, green: 178, blue: 153)
            button.layer.cornerRadius = 10
            button.clipsToBounds = true
            button.textAlignment = NSTextAlignment.Center
            button.font = button.font.fontWithSize(17)
            button.textColor = UIColor(red: 64, green: 76, blue: 83)
            currentContributionsButtons.append(button)
            ticks.addSubview(button)
            
        }
        temp = 0.0
        for i in quoteList{
            let quoteButton = UILabel()
            quoteButton.text = i
            quoteButton.bounds = CGRect(x: 0, y: 0, width: 80, height: 80)
            quoteButton.center = CGPoint(x: 45, y: (85 * temp) + 80)
            temp = temp+1
            quoteButton.backgroundColor = UIColor(red: 135, green: 178, blue: 153)
            quoteButton.layer.cornerRadius = 10
            quoteButton.clipsToBounds = true
            quoteButton.textAlignment = NSTextAlignment.Center
            quoteButton.font = quoteButton.font.fontWithSize(17)
            quoteButton.textColor = UIColor(red: 64, green: 76, blue: 83)
            currentContributionsButtons.append(quoteButton)
            quotes.addSubview(quoteButton)
            
        }
        temp = 0.0
        for i in questionList{
            let questionButton = UILabel()
            questionButton.text = i
            questionButton.bounds = CGRect(x: 0, y: 0, width: 80, height: 80)
            questionButton.center = CGPoint(x: 45, y: (85 * temp) + 80)
            temp = temp+1
            questionButton.backgroundColor = UIColor(red: 135, green: 178, blue: 153)
            questionButton.layer.cornerRadius = 10
            questionButton.clipsToBounds = true
            questionButton.textAlignment = NSTextAlignment.Center
            questionButton.font = questionButton.font.fontWithSize(17)
            questionButton.textColor = UIColor(red: 64, green: 76, blue: 83)
            currentContributionsButtons.append(questionButton)
            questions.addSubview(questionButton)
            
        }
        temp = 0.0
        for i in answerList{
            let answerButton = UILabel()
            answerButton.text = i
            answerButton.bounds = CGRect(x: 0, y: 0, width: 80, height: 80)
            answerButton.center = CGPoint(x: 45, y: (85 * temp) + 80)
            temp = temp+1
            answerButton.backgroundColor = UIColor(red: 135, green: 178, blue: 153)
            answerButton.layer.cornerRadius = 10
            answerButton.clipsToBounds = true
            answerButton.textAlignment = NSTextAlignment.Center
            answerButton.font = answerButton.font.fontWithSize(17)
            answerButton.textColor = UIColor(red: 64, green: 76, blue: 83)
            currentContributionsButtons.append(answerButton)
            answers.addSubview(answerButton)
            
        }
        temp = 0.0
        for i in otherList{
            let otherButton = UILabel()
            otherButton.text = i
            otherButton.bounds = CGRect(x: 0, y: 0, width: 80, height: 80)
            otherButton.center = CGPoint(x: 45, y: (85 * temp) + 80)
            temp = temp+1
            otherButton.backgroundColor = UIColor(red: 135, green: 178, blue: 153)
            otherButton.layer.cornerRadius = 10
            otherButton.clipsToBounds = true
            otherButton.textAlignment = NSTextAlignment.Center
            otherButton.font = otherButton.font.fontWithSize(17)
            otherButton.textColor = UIColor(red: 64, green: 76, blue: 83)
            currentContributionsButtons.append(otherButton)
            other.addSubview(otherButton)
            
        }
        contributionsList.removeAll()
        quoteList.removeAll()
        questionList.removeAll()
        answerList.removeAll()
        otherList.removeAll()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        if (segue.identifier == "segueToGateway") {
            
        }
    }
}



