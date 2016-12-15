//
//  ViewController.swift
//  Notification
//
//  Created by 岡野健三 on 2016/12/15.
//  Copyright © 2016年 岡野健三. All rights reserved.
//

import UIKit
import UserNotifications


class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var whoTextField: UITextField!
    
    @IBOutlet weak var mainTextField: UITextField!
    
    var resultString = ""
    var ketsugouString = ":"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //テキストフィールドのイベントを取得するためにデリゲート(委譲)する
        whoTextField.delegate = self
        mainTextField.delegate = self
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //キーボートのリターンキーが押された時に呼ばれるデリゲートメソッド
    
        //whoTextFieldのテキストと:とmainTextFieldのテキストを穴道する
        
        resultString = whoTextField.text! + ketsugouString + mainTextField.text!
        
        //閉じる
        textField.resignFirstResponder()
        
        return true
        
    }

    @IBAction func tap(_ sender: Any) {
    
        pushnotification()
        
    }
    
    //Push通知に関するメソッド
    func pushnotification(){
        
        let content = UNMutableNotificationContent()
        //content.title = "タイトル"
        //content.subtitle = "サブタイトル"
        
        content.body = resultString
        
        //どのタイミングでPush通知を発動させるか
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3.0, repeats: false)
        
        let requestidentifier = "LINEPush"
        let request = UNNotificationRequest(identifier: requestidentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request,withCompletionHandler:{error in
            
            //エラー処理
            
        })

        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

