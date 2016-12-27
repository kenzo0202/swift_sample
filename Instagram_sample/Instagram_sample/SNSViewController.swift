//
//  SNSViewController.swift
//  Instagram_sample
//
//  Created by 岡野健三 on 2016/12/27.
//  Copyright © 2016年 岡野健三. All rights reserved.
//

import UIKit
import Social

class SNSViewController: UIViewController {
    
    var endImage: UIImage = UIImage()
    
    //SNSシェア用
    var myComposetView : SLComposeViewController!
    
    
    @IBOutlet weak var endImageView: UIImageView!
    
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        endImageView.image = endImage

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //もしテキストビューが出ている状態であれば、閉じる
        if(textView.isFirstResponder){
            textView.resignFirstResponder()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(_ sender: Any) {
        //画面を保存する処理
        UIImageWriteToSavedPhotosAlbum(endImageView.image!, self, nil, nil)
        
        //アラートを立ち上げる
        let alertController:UIAlertController = UIAlertController(title: "保存が完了しました", message: "OKボタンを押してください", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        //Default 複数指定可
        let OKAction:UIAlertAction = UIAlertAction(title: "OK",
                                                        style: UIAlertActionStyle.default,
                                                        handler:{
                                                            (action:UIAlertAction!) -> Void in
                                                            
        })
        
    alertController.addAction(OKAction)
        present(alertController, animated: true, completion: nil)
        

        
        
    }

    @IBAction func share(_ sender: Any) {
        //SNSでシェアするメニュー画面を立ち上げるボタン
        
        //アラートを立ち上げる
        let alertController:UIAlertController = UIAlertController(title: "シェアする", message: "好きなSNSでシェアしよう", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        //Default 複数指定可
        let TwitterAction:UIAlertAction = UIAlertAction(title: "Twitter",
                                                        style: UIAlertActionStyle.default,
                                                        handler:{
                                                            (action:UIAlertAction!) -> Void in
                                                            self.postTwitter()
        })
        
        let FacebookAction:UIAlertAction = UIAlertAction(title: "Facebook",
                                                        style: UIAlertActionStyle.default,
                                                        handler:{
                                                            (action:UIAlertAction!) -> Void in
                                                            self.postFacebook()
        })
        let LINEAction:UIAlertAction = UIAlertAction(title: "LINE",
                                                         style: UIAlertActionStyle.default,
                                                         handler:{
                                                            (action:UIAlertAction!) -> Void in
                                                            self.postLine()
        })

        
        let cancelAction:UIAlertAction = UIAlertAction(title: "Cancel",
                                                       style: UIAlertActionStyle.cancel,
                                                       handler:{
                                                        (action:UIAlertAction!) -> Void in
        })
        
        alertController.addAction(TwitterAction)
        alertController.addAction(FacebookAction)
        alertController.addAction(LINEAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    //Twitterに投稿するメソッド
    func postTwitter(){
        myComposetView = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        myComposetView.setInitialText(textView.text)
        myComposetView.add(endImageView.image)
        self.present(myComposetView, animated: true, completion: nil)
        
        //SNSへの投稿画面が自動的に立ち上がる
        
    }

    //Facebookに投稿するメソッド
    func postFacebook(){
        myComposetView = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        myComposetView.setInitialText(textView.text)
        myComposetView.add(endImageView.image)
        self.present(myComposetView, animated: true, completion: nil)
        
        
    }
    
    @IBAction func `return`(_ sender: Any) {
        //アラート画面を出す
        let alertController:UIAlertController = UIAlertController(title: "本文は破棄されてしまいます", message: "よろしいですか？", preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction2:UIAlertAction = UIAlertAction(title: "Cancel",
                                                       style: UIAlertActionStyle.cancel,
                                                       handler:{
                                                        (action:UIAlertAction!) -> Void in
        })
        
        let OKAction:UIAlertAction = UIAlertAction(title: "OK",
                                                        style: UIAlertActionStyle.default,
                                                        handler:{
                                                            (action:UIAlertAction!) -> Void in
                                                            //戻る処理
                                                            self.navigationController?.popViewController(animated: true)
        })
        
        alertController.addAction(OKAction)
        alertController.addAction(cancelAction2)
        present(alertController, animated: true, completion: nil)

        
    }
//LINEに投稿するメソッド
    func postLine(){
        let pasteBoard : UIPasteboard = UIPasteboard.general
        
        pasteBoard.setData(UIImagePNGRepresentation(endImageView.image!)!, forPasteboardType: "public.png")
        
        pasteBoard.setValue(textView.text, forPasteboardType:textView.text)
        
        let urlString:String = String(format: "line://msg/image/%@", pasteBoard.name as CVarArg)
        
        let url: URL! = URL(string: urlString)
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        
    }
}
