//
//  ViewController.swift
//  UIScrollView
//
//  Created by 岡野健三 on 2016/11/19.
//  Copyright © 2016年 岡野健三. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var myScrollView: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet var myTextFields: [UITextField]!
    
    
    var editingField: UITextField?
    
    var overlap:CGFloat = 0.0
    var lastOffsetY:CGFloat = 0.0
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        editingField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        editingField = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    
    @IBAction func tapView(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //すワイプでスクロールさせたならばキーボードを下げる
        myScrollView.keyboardDismissMode = .onDrag
        
        
        let scrollFrame = CGRect(x: 0, y: 20, width: view.frame.width, height: view.frame.height )
        myScrollView.frame = scrollFrame
        
        let contentRect = contentView.bounds
        myScrollView.contentSize = CGSize(width: contentRect.width, height: contentRect.height)
        
        
        for fid in myTextFields {
            fid.delegate = self
        }
        
        let notification = NotificationCenter.default
        //キーボードのframeが変化したとき
        notification.addObserver(self,selector: #selector(ViewController.keyboardChangeFrame(_:)),name: NSNotification.Name.UIKeyboardDidChangeFrame, object: nil)
        
        
        //キーボードが登場したとき
        notification.addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        //キーボードが退場したとき
        notification.addObserver(self, selector: #selector(ViewController.keyboardDidHide(_:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
        func keyboardChangeFrame(_ notification: Notification){
            //キーボードを削除したときも、イベントが発生するので編集途中のフィールドの有無で判別
            guard let fid = editingField else {
                return
            }
            
            let userInfo = (notification as NSNotification).userInfo!
            let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            let fidFrame = view.convert(fid.frame, from: contentView)
            overlap = fidFrame.maxY - keyboardFrame.minY + 5
            
            if overlap > 0 {
                //すでにスクロールしている分を加算
                overlap += myScrollView.contentOffset.y
                
                myScrollView.setContentOffset(CGPoint(x: 0, y: overlap), animated: true)
            }
        }
        
        func keyboardWillShow(_ notification: Notification){
            lastOffsetY = myScrollView.contentOffset.y
        }
        
        func keyboardDidHide(_ notification: Notification){
            let baseline = (contentView.bounds.height - myScrollView.bounds.height)
            lastOffsetY = min(baseline, lastOffsetY)
            myScrollView.setContentOffset(CGPoint(x: 0, y: lastOffsetY), animated: true)
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

