//
//  ViewController.swift
//  Square_sample
//
//  Created by 岡野健三 on 2016/11/21.
//  Copyright © 2016年 岡野健三. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    func makeBoxImage(width w:CGFloat, height h:CGFloat) -> UIImage{
        
        let size = CGSize(width: w, height: h)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        
        let context = UIGraphicsGetCurrentContext()
        
        let drawRect = CGRect(x: 0, y: 0, width: w, height: h)
        
        //パスを作る(四角形)
        let drawPath = UIBezierPath(rect: drawRect)
        
        context?.setFillColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        
        //パスを塗る
        drawPath.fill()
        
        context?.setStrokeColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
        
        //パスを描く
        drawPath.stroke()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let boxImage = makeBoxImage(width: 250, height: 180)
        
        let boxView = UIImageView(image: boxImage)
        
        boxView.center = view.center
        
        view.addSubview(boxView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

