//
//  Gateway.swift
//  Harkness
//
//  Created by Nicholas Brozey on 5/2/16.
//  Copyright © 2016 Tom Hantzmon. All rights reserved.
//

import UIKit

class Gateway: UIViewController {
    
    
    
    
    //no queries needed on this file
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(studentNames.count == 0){
            studentNames.append("Nick Brozey")
            studentNames.append("Tom Hantzmon")
            studentNames.append("Trevor Chase")
            studentNames.append("Zach Minster")
            studentNames.append("Diplo")
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
        if (segue.identifier == "segueToHistory") {
            let segueID = segue!.destinationViewController as! PrevHark
            
        }else if (segue.identifier == "segueToStudents") {
            let segueID = segue!.destinationViewController as! Students;
        }else if (segue.identifier == "segueToAttendance"){
            let segueID = segue!.destinationViewController as! HarkPrep;
        }
    }
    
    
}