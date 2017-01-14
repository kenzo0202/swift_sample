//
//  ViewController.swift
//  SwiftFB
//
//  Created by 岡野健三 on 2017/01/14.
//  Copyright © 2017年 岡野健三. All rights reserved.
//

import UIKit
import FBSDKLoginKit


class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var label: UILabel!

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        //FBボタンを設置
        let fbbutton = FBSDKLoginButton()
        fbbutton.frame = CGRect(x: 50, y: 100, width: self.view.frame.width - 100 , height: 50)
        self.view.addSubview(fbbutton)
        
        fbbutton.delegate = self
    
    }
    //起動しているかのログを出力
    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    
    //FBSDKLoginButtonDelegateのデリゲイトメソッド
    func loginButton(_
        loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            //error
            
        }else if result.isCancelled{
            
        }else{
            //値を取得する
            getUserInfo()
        }
    }
    
    
        func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!){
            
            print("ログアウト")
            self.label.text = ""
            self.imageView.image = nil
        }
        
        func getUserInfo(){
            if(FBSDKAccessToken.current() != nil){
                let graphRequest = FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields": "id,name"])
                
                graphRequest?.start(completionHandler: {(connection,result,errror) in
                    self.label.text = (result! as AnyObject).value(forKey: "name") as? String
                    
                    let id = (result! as AnyObject).value(forKey: "id") as? String
                    
                    let url = URL(string: "https://graph.facebook.com/\(id!)/picture?/type=large&return_ssl_resources=1")
                    
                    let dataUrl = NSData(contentsOf: url!)
                    
                    self.imageView.image = UIImage(data:dataUrl as! Data)
                })
            }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

