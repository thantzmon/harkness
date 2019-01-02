//
//  ViewController.swift
//  harkness
//
//  Created by Tom Hantzmon and yeah boi nb up in da kitchen on 4/30/16.
//  Copyright © 2016 Tom Hantzmon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Do any additional setup after loading the view, typically from a nib.
        //var test = [UIButton]()
                
        for i in 0...5{
            var button = UIButton()
            button = UIButton(type: UIButtonType.System)
            
            button.setTitle("Button number" + String(i), forState: UIControlState.Normal)
            
            button.bounds = CGRect(x: 0, y: 0, width: 300, height: 80)
            button.center = CGPoint(x: 150, y: (85 * i) + 100)
            
            button.backgroundColor = UIColor.blueColor()
            
            button.titleLabel?.font = UIFont.systemFontOfSize(17)
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            
            view.addSubview(button)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

