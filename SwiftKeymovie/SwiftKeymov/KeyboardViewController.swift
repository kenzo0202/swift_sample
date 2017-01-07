//
//  KeyboardViewController.swift
//  SwiftKeymov
//
//  Created by 岡野健三 on 2017/01/07.
//  Copyright © 2017年 岡野健三. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    
    var count:Int = 0
    
    //変数宣言の時にエクスクラメーションマークをつけると、nilだった場合に自動でunwrapしてくれる
    
    var videoURL:NSURL?
    
    var playerItem : AVPlayerItem!
    
    var videoPlayer:AVPlayer!
    
    var playerLayer:AVPlayerLayer?
    
    var main_button:UIButton = UIButton()
    var main_button2:UIButton = UIButton()
    var main_button3:UIButton = UIButton()
    var main_button4:UIButton = UIButton()
    var main_button5:UIButton = UIButton()
    
    
    
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
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        
        //動画が再生されているのであれば、消す
        playerLayer?.removeFromSuperlayer()
        main_button.removeFromSuperview()
        main_button2.removeFromSuperview()
        main_button3.removeFromSuperview()
        main_button4.removeFromSuperview()
        main_button5.removeFromSuperview()
        
        let path = Bundle.main.path(forResource: "movie4", ofType: "m4v")
        let fileURL = URL(fileURLWithPath: path!)
        let avAseet = AVAsset(url: fileURL)
        
        //AVPlayerに再生させるItemを作成
        playerItem = AVPlayerItem(asset: avAseet)
        
        //AVPlayerを生成
        videoPlayer = AVPlayer(playerItem: playerItem)
        
        playerLayer = AVPlayerLayer(player: videoPlayer)
        
        playerLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        
        //サイズを決める
        playerLayer?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216)
        self.view.layer.addSublayer(playerLayer!)
        videoPlayer.play()
        
        
        //通知センターにイベントハンドラを登録する
        
        let notification = NotificationCenter.default
        
        notification.addObserver(self, selector: #selector(playerplayEnded), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.videoPlayer.currentItem
        )
        
        create_button()
    }
    
    //ボタンをプログラムで生成する
    func create_button(){
        
        main_button.addTarget(self, action: #selector(thank), for: .touchUpInside)
        main_button.frame = CGRect(x: 0, y: 0, width: Int(self.view.frame.size.width/3), height: 216/3)
        main_button.setTitle("こんにちは",for: UIControlState.normal)
        
        self.view.addSubview(main_button)
        
        main_button2.addTarget(self, action: #selector(sorena), for: .touchUpInside)
        main_button2.frame = CGRect(x:  Int(self.view.frame.size.width) -  Int(self.view.frame.size.width/3), y: 0, width: Int(self.view.frame.size.width/3), height: 216/3)
        main_button2.setTitle("それな",for: UIControlState.normal)
        
        self.view.addSubview(main_button2)
        
        main_button3.addTarget(self, action: #selector(yabai), for: .touchUpInside)
        main_button3.frame = CGRect(x: 0, y:   Int(self.view.frame.size.height) - 216/3, width: Int(self.view.frame.size.width/3), height: 216/3)
        main_button3.setTitle("やばい",for: UIControlState.normal)
        
        self.view.addSubview(main_button3)
        
        main_button4.addTarget(self, action: #selector(change), for: .touchUpInside)
        main_button4.frame = CGRect(x: Int(self.view.frame.size.width/3), y:   Int(self.view.frame.size.width/3), width: Int(self.view.frame.size.width/3), height: 216/3)
        main_button4.setTitle("変更",for: UIControlState.normal)
        
        self.view.addSubview(main_button4)
        
        main_button5.addTarget(self, action: #selector(tap), for: .touchUpInside)
        main_button5.frame = CGRect(x: Int(self.view.frame.size.width) -  Int(self.view.frame.size.width/3), y:  Int(self.view.frame.size.height) - 216/3 , width: Int(self.view.frame.size.width/3), height: 216/3)
        main_button5.setTitle("動画",for: UIControlState.normal)
        
        self.view.addSubview(main_button5)

    }
    
    func tap(){
        count = count + 1
        
        if(count >= 5){
            count = 1
        }
        
        if(count == 1){
            movie1()
        }
        if(count == 2){
            movie2()
        }
        if(count == 3){
            movie3()
        }
        if(count == 4){
            movie4()
        }
    
        
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
        self.textDocumentProxy.insertText("変更")
    }
    
    func movie1(){
        videoPlayer.pause()
        //動画が再生されているのであれば、消す
        playerLayer?.removeFromSuperlayer()
        main_button.removeFromSuperview()
        main_button2.removeFromSuperview()
        main_button3.removeFromSuperview()
        main_button4.removeFromSuperview()
        main_button5.removeFromSuperview()
        
        let path = Bundle.main.path(forResource: "movie1", ofType: "m4v")
        let fileURL = URL(fileURLWithPath: path!)
        let avAseet = AVAsset(url: fileURL)
        
        //AVPlayerに再生させるItemを作成
        playerItem = AVPlayerItem(asset: avAseet)
        
        //AVPlayerを生成
        videoPlayer = AVPlayer(playerItem: playerItem)
        
        playerLayer = AVPlayerLayer(player: videoPlayer)
        
        playerLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        
        //サイズを決める
        playerLayer?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216)
        self.view.layer.addSublayer(playerLayer!)
        videoPlayer.play()
        
        
        //通知センターにイベントハンドラを登録する
        
        let notification = NotificationCenter.default
        
        notification.addObserver(self, selector: #selector(playerplayEnded), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.videoPlayer.currentItem
        )
        
        create_button()
        
        
    }
    func movie2(){
        videoPlayer.pause()
        //動画が再生されているのであれば、消す
        playerLayer?.removeFromSuperlayer()
        main_button.removeFromSuperview()
        main_button2.removeFromSuperview()
        main_button3.removeFromSuperview()
        main_button4.removeFromSuperview()
        main_button5.removeFromSuperview()
        
        let path = Bundle.main.path(forResource: "movie2", ofType: "m4v")
        let fileURL = URL(fileURLWithPath: path!)
        let avAseet = AVAsset(url: fileURL)
        
        //AVPlayerに再生させるItemを作成
        playerItem = AVPlayerItem(asset: avAseet)
        
        //AVPlayerを生成
        videoPlayer = AVPlayer(playerItem: playerItem)
        
        playerLayer = AVPlayerLayer(player: videoPlayer)
        
        playerLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        
        //サイズを決める
        playerLayer?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216)
        self.view.layer.addSublayer(playerLayer!)
        videoPlayer.play()
        
        
        //通知センターにイベントハンドラを登録する
        
        let notification = NotificationCenter.default
        
        notification.addObserver(self, selector: #selector(playerplayEnded), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.videoPlayer.currentItem
        )
        
        create_button()
        
        
    }
    func movie3(){
        videoPlayer.pause()
        //動画が再生されているのであれば、消す
        playerLayer?.removeFromSuperlayer()
        main_button.removeFromSuperview()
        main_button2.removeFromSuperview()
        main_button3.removeFromSuperview()
        main_button4.removeFromSuperview()
        main_button5.removeFromSuperview()
        
        let path = Bundle.main.path(forResource: "movie3", ofType: "m4v")
        let fileURL = URL(fileURLWithPath: path!)
        let avAseet = AVAsset(url: fileURL)
        
        //AVPlayerに再生させるItemを作成
        playerItem = AVPlayerItem(asset: avAseet)
        
        //AVPlayerを生成
        videoPlayer = AVPlayer(playerItem: playerItem)
        
        playerLayer = AVPlayerLayer(player: videoPlayer)
        
        playerLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        
        //サイズを決める
        playerLayer?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216)
        self.view.layer.addSublayer(playerLayer!)
        videoPlayer.play()
        
        
        //通知センターにイベントハンドラを登録する
        
        let notification = NotificationCenter.default
        
        notification.addObserver(self, selector: #selector(playerplayEnded), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.videoPlayer.currentItem
        )
        
        create_button()
        
        
    }
    func movie4(){
        videoPlayer.pause()
        //動画が再生されているのであれば、消す
        playerLayer?.removeFromSuperlayer()
        main_button.removeFromSuperview()
        main_button2.removeFromSuperview()
        main_button3.removeFromSuperview()
        main_button4.removeFromSuperview()
        main_button5.removeFromSuperview()
        
        let path = Bundle.main.path(forResource: "movie4", ofType: "m4v")
        let fileURL = URL(fileURLWithPath: path!)
        let avAseet = AVAsset(url: fileURL)
        
        //AVPlayerに再生させるItemを作成
        playerItem = AVPlayerItem(asset: avAseet)
        
        //AVPlayerを生成
        videoPlayer = AVPlayer(playerItem: playerItem)
        
        playerLayer = AVPlayerLayer(player: videoPlayer)
        
        playerLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        
        //サイズを決める
        playerLayer?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216)
        self.view.layer.addSublayer(playerLayer!)
        videoPlayer.play()
        
        
        //通知センターにイベントハンドラを登録する
        
        let notification = NotificationCenter.default
        
        notification.addObserver(self, selector: #selector(playerplayEnded), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.videoPlayer.currentItem
        )
        
        create_button()
        
        
    }
    
    func playerplayEnded(){
        
        self.videoPlayer.currentItem?.seek(to: kCMTimeZero)
        self.videoPlayer.play()
        
    }
    

}
