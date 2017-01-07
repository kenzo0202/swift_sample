//
//  KeyboardViewController.swift
//  Swiftkeyboard
//
//  Created by 岡野健三 on 2017/01/04.
//  Copyright © 2017年 岡野健三. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    var imageView:UIImageView = UIImageView()
    
    var main_button:UIButton = UIButton()
    var main_button2:UIButton = UIButton()
    var main_button3:UIButton = UIButton()
    var main_button4:UIButton = UIButton()
    
    var count:Int = 0


    @IBOutlet var nextKeyboardButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        //背景画像を設定する
        imageView.image = UIImage(named: "image11.jpg")
        self.view.addSubview(imageView)
        //ボタンをプログラムで生成する
        main_button.addTarget(self, action: #selector(thank), for: .touchUpInside)
        main_button.frame = CGRect(x: 0, y: 0, width: Int(self.view.frame.size.width/3), height: 216/3)
        main_button.title(for: UIControlState.normal)
        
        self.view.addSubview(main_button)
        
        main_button2.addTarget(self, action: #selector(sorena), for: .touchUpInside)
        main_button2.frame = CGRect(x:  Int(self.view.frame.size.width) -  Int(self.view.frame.size.width/3), y: 0, width: Int(self.view.frame.size.width/3), height: 216/3)
        main_button2.title(for: UIControlState.normal)
        
        self.view.addSubview(main_button2)

        main_button3.addTarget(self, action: #selector(yabai), for: .touchUpInside)
        main_button3.frame = CGRect(x: 0, y:   Int(self.view.frame.size.width) - 216/3, width: Int(self.view.frame.size.width/3), height: 216/3)
        main_button3.title(for: UIControlState.normal)
        
        self.view.addSubview(main_button3)
        
        main_button4.addTarget(self, action: #selector(change), for: .touchUpInside)
        main_button4.frame = CGRect(x: Int(self.view.frame.size.width/3), y:   Int(self.view.frame.size.width/3), width: Int(self.view.frame.size.width/3), height: 216/3)
        main_button4.title(for: UIControlState.normal)
        
        self.view.addSubview(main_button4)

        
        
    }
    
    func thank(){
        self.textDocumentProxy.insertText("こんにちは")
        
    }
    func sorena(){
        self.textDocumentProxy.insertText("それな")
        
    }
    func yabai(){
        self.textDocumentProxy.insertText("ヤバイ")
        
    }
    func change(){
        //背景画像の変更
        count = count + 1
        
         if(count == 1){
            imageView.image = UIImage(named: "image1.jpg")
        }
        if(count == 2){
            imageView.image = UIImage(named: "image2.jpg")
        }

        if(count == 3){
            imageView.image = UIImage(named: "image3.jpg")
        }

        if(count == 4){
            imageView.image = UIImage(named: "image4.jpg")
        }

        if(count == 5){
            imageView.image = UIImage(named: "image5.jpg")
        }

        if(count == 6){
            imageView.image = UIImage(named: "image6.jpg")
        }

        
        if(count == 7){
            imageView.image = UIImage(named: "image7.jpg")
        }
        
        if(count == 8){
            imageView.image = UIImage(named: "image8.jpg")
        }
        if(count == 9){
            imageView.image = UIImage(named: "image9.jpg")
        }

        if(count == 10){
            imageView.image = UIImage(named: "image10.jpg")
            count = 1
        }

        

        
    }
    

}
