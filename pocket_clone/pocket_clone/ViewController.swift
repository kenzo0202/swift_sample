//
//  ViewController.swift
//  pocket_clone
//
//  Created by 岡野健三 on 2016/12/12.
//  Copyright © 2016年 岡野健三. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var count:Int = 0

    @IBOutlet weak var webView: UIWebView!
    
    var urlArray = [String]()
    
    var urlString:String? = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.object(forKey: "urlArray") != nil {
            urlArray = UserDefaults.standard.object(forKey: "urlArray") as! [String]
            urlString = urlArray[count]
        }
        let url = URL(string: urlString!)
        let requestURL = NSURLRequest(url:url!)
        webView.loadRequest(requestURL as URLRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

