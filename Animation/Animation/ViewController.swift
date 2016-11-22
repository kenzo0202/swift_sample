//
//  ViewController.swift
//  Animation
//
//  Created by 岡野健三 on 2016/11/20.
//  Copyright © 2016年 岡野健三. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var car: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Timer.scheduledTimer(timeInterval: 0.1,
                             target: self,
                             selector: #selector(self.step),
                             userInfo: nil,
                             repeats: true)
    }
    
    func step(){
        
        car.center.x  += 10
        
        let carWidth = car.bounds.width
        
        if car.center.x > (view.bounds.width + carWidth/2){
            
            car.center.x = -carWidth
            
            let viewH = view.bounds.height
            car.center.y = CGFloat(arc4random_uniform(UInt32(viewH)))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

