//
//  Notes.swift
//  harkness
//
//  Created by Tom Hantzmon on 8/8/16.
//  Copyright © 2016 Tom Hantzmon. All rights reserved.
//

import UIKit

class Notes: UIViewController {
    @IBOutlet weak var notes: UITextView!
    var studentName = String()
    var className = String()
    var note = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("it got this far!")
        if NSUserDefaults.standardUserDefaults().objectForKey("NotesStudent") != nil{
            studentName = NSUserDefaults.standardUserDefaults().objectForKey("NotesStudent")! as! String
            className = NSUserDefaults.standardUserDefaults().objectForKey("Class")! as! String
            
            if NSUserDefaults.standardUserDefaults().objectForKey(className + studentName) != nil{
                note = NSUserDefaults.standardUserDefaults().objectForKey(className + studentName)! as! String
            }else{
                note = ""
            }
            
            notes.text = note
            
            
        }

    }
    
    @IBAction func saveNotes(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setObject(notes.text, forKey: className + studentName)
    }

}

