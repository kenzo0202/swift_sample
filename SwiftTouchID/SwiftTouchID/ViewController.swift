//
//  ViewController.swift
//  SwiftTouchID
//
//  Created by 岡野健三 on 2017/01/07.
//  Copyright © 2017年 岡野健三. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func touch(_ sender: Any) {
        let context = LAContext()
        var error : NSError?
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "サンプル確認のための認証チェック", reply: {
                success, error in
                if (success) {
                    NSLog("認証成功")
                    self.alert()
                } else {
                    NSLog("認証失敗：" + error!._code.description)
                }
            })
        } else {
            NSLog("TouchID非対応")
        }
    }
    
    func alert(){
        let alert = UIAlertController(title:"認証成功しました", message: "おめでとうございます", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OKです",
                                      style: .default,
                                      handler: {
                                        (action) -> Void in
                                        //ボタンを押した時に実行するプログラムを書く
                                        let next = self.storyboard!.instantiateViewController(withIdentifier: "next")
                                        self.present(next,animated: true, completion: nil)
                                        
        })
        )
        self.present(alert, animated: true, completion: {
                print("アラートが表示されました")
        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

