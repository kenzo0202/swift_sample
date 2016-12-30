//
//  NextViewController.swift
//  SwiftWunderList
//
//  Created by 岡野健三 on 2016/12/30.
//  Copyright © 2016年 岡野健三. All rights reserved.
//

import UIKit
import MessageUI

class NextViewController: UIViewController, UITextViewDelegate,MFMailComposeViewControllerDelegate {
    
    var titleArray:Array = [String]()
    
    var selectedNumber:Int = 0

    @IBOutlet weak var UITextView: UITextView!
    
    var mailViewController = MFMailComposeViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITextView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if((UserDefaults.standard.object(forKey: "array")) != nil){
            titleArray = UserDefaults.standard.object(forKey: "array") as! [String]
        }
        
        UITextView.text = titleArray[selectedNumber]
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(UITextView.isFirstResponder){
            //閉じる
            UITextView.resignFirstResponder()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    @IBAction func openMain(_ sender: Any) {
        
        let toRecipients = ["to@1gmail.com"] //Toのアドレス指定
        let CcRecipients = ["cc@1gmail.com","Cc2@1gmail.com"] //Ccのアドレス指定
        let BccRecipients = ["Bcc@1gmail.com","Bcc2@1gmail.com"] //Bccのアドレス指定
        
        //メールを開く
        mailViewController.mailComposeDelegate = self
        mailViewController.setSubject("メールの件名")
        mailViewController.setToRecipients(toRecipients) //Toアドレスの表示
        mailViewController.setCcRecipients(CcRecipients) //Ccアドレスの表示
        mailViewController.setBccRecipients(BccRecipients) //Bccアドレスの表示
        mailViewController.setMessageBody(UITextView.text, isHTML: false)
        self.present(mailViewController, animated: true, completion: nil)
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
