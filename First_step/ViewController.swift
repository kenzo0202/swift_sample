//
//  ViewController.swift
//  First_step
//
//  Created by 岡野健三 on 2016/11/14.
//  Copyright © 2016年 岡野健三. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var TextLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    @IBAction func buttonradius(_ sender: UISlider) {
        let test = sender.value
        button.layer.cornerRadius = 10.0 * CGFloat(test)
    }
    
    
    @IBAction func tapGreen(_ sender: AnyObject) {
        view.backgroundColor = UIColor.blue
        TextLabel.text = "What??"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        button.layer.cornerRadius = 10
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

