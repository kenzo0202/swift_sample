//
//  ViewController.swift
//  UI_sample
//
//  Created by 岡野健三 on 2016/11/16.
//  Copyright © 2016年 岡野健三. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var main_text: UILabel!
    
    @IBOutlet weak var imageview: UIView!
    
    @IBAction func love(_ sender: Any) {
        main_text.text = "love"
        main_text.textColor = UIColor.red
    }
    @IBAction func dislike(_ sender: Any) {
        main_text.text = "hate"
        main_text.backgroundColor = UIColor.brown
    }
    
    @IBAction func changeimage(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            imageview.backgroundColor = UIColor.red
        case 1:
            imageview.backgroundColor = UIColor.blue
        case 2:
            imageview.backgroundColor = UIColor.yellow
        default:
            imageview.backgroundColor = UIColor.white
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

