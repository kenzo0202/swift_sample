//
//  ViewController.swift
//  SwiftRelax
//
//  Created by 岡野健三 on 2017/01/12.
//  Copyright © 2017年 岡野健三. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    
    @IBOutlet weak var menuView: UIView!
    
    var player1 = AVAudioPlayer()
    var player2 = AVAudioPlayer()
    var player3 = AVAudioPlayer()
    
    @IBAction func play1(_ sender: Any) {
        do {
            player1 =  try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:Bundle.main.path(forResource: "winds", ofType: "mp3")!))
            player1.prepareToPlay()
            
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            } catch  {
                print(error)
            }
            player1.play()
        } catch  {
            print(error)

        }
    }
    
    @IBAction func play2(_ sender: Any) {
        do {
            player1 =  try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:Bundle.main.path(forResource: "sea", ofType: "mp3")!))
            player1.prepareToPlay()
            
            let audioSession = AVAudioSession.sharedInstance()
            do {
                //バックグラウンド再生で必要
                try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            } catch  {
                print(error)
            }
            player1.play()
        } catch  {
            print(error)
            
        }

    }

    @IBAction func play3(_ sender: Any) {
        do {
            player1 =  try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath:Bundle.main.path(forResource: "rain", ofType: "mp3")!))
            player1.prepareToPlay()
            
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            } catch  {
                print(error)
            }
            player1.play()
        } catch  {
            print(error)
            
        }

    }
    
    @IBAction func stop1(_ sender: Any) {
        player1.stop()
    }
    @IBAction func stop2(_ sender: Any) {
        player2.stop()
    }
    @IBAction func stop3(_ sender: Any) {
        player3.stop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gifData = NSData(contentsOfFile: Bundle.main.path(forResource: "am", ofType: "gif")!)!
        
        //gifデータを表示させる
        webView.load(gifData as Data, mimeType: "image/gif", textEncodingName: "utf-8", baseURL: NSURL() as URL)
        
        //スライドさせると隠れたボタンを表示させる
        startAnimation()
        
        
        let rightswipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
        rightswipe.direction = .right
        view.addGestureRecognizer(rightswipe)
        let leftswipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
        leftswipe.direction = .left
        view.addGestureRecognizer(leftswipe)
        
    }
    
    func startAnimation(){
        UIView.animate(withDuration: 0.5, animations: {()->Void in
            //位置を決める
            self.button1.frame = CGRect(x: 123, y: 38, width: 128, height: 128)
            self.button2.frame = CGRect(x: 123, y: 269, width: 128, height: 128)
            self.button3.frame = CGRect(x: 123, y: 519, width: 128, height: 128)
            
        
        
        }, completion: {(Bool) -> Void in
            //移動が完了した際の処理を書く
        
        })
    }


    func didSwipe(sender:UISwipeGestureRecognizer){
        
        if sender.direction == .right {
            UIView.animate(withDuration: 0.5, animations: {()->Void in
                //位置を決める
                self.menuView.frame = CGRect(x: 377, y: 0, width: 264, height: 667)
                
                
                
            }, completion: {(Bool) -> Void in
                //移動が完了した際の処理を書く
                
            })
            
            
            
        }else if sender.direction == .left {
            UIView.animate(withDuration: 0.5, animations: {()->Void in
                //位置を決める
                self.menuView.frame = CGRect(x: 151, y: 0, width: 264, height: 667)
                
                
                
            }, completion: {(Bool) -> Void in
                //移動が完了した際の処理を書く
                
            })
            

        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    


}

