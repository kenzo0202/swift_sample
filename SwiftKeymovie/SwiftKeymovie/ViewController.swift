//
//  ViewController.swift
//  SwiftKeymovie
//
//  Created by 岡野健三 on 2017/01/07.
//  Copyright © 2017年 岡野健三. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sc: UIScrollView!
    
    var uv:UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uv.frame = CGRect(x: 0, y: 0, width: Int(self.view.frame.size.width)*3, height: Int(self.view.frame.size.height))
        
        for i in 0..<3{
            let imageView:UIImageView = UIImageView()
            imageView.frame = CGRect(x: Int(self.view.frame.size.width)*i , y: 0, width: Int(self.view.frame.size.width), height: Int(self.view.frame.size.height))
            
            let image:UIImage = UIImage(named: String(i+1)+".jpg")!
            
            imageView.image = image
            
            uv.addSubview(imageView)
            
        }
        sc.isPagingEnabled = true
        sc.addSubview(uv)
        
        sc.contentSize = uv.bounds.size
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

