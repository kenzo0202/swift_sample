//
//  ViewController.swift
//  WebView
//
//  Created by 岡野健三 on 2016/11/19.
//  Copyright © 2016年 岡野健三. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!

    var data:(name:String, url: String)?
    
    func openWeb(){
        
        if let webData = data{
            
            if let url = NSURL(string: webData.url){
                let urlReq = NSURLRequest(url: url as URL)
                webView.loadRequest(urlReq as URLRequest)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //webページを開く
        openWeb()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

