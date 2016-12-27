//
//  ViewController.swift
//  SwiftPlayer
//
//  Created by 岡野健三 on 2016/12/17.
//  Copyright © 2016年 岡野健三. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func tap(_ sender: Any) {
        playVideo()
    }
    
    
    func playVideo(){
        if let bundlePath = Bundle.main.path(forResource: "movie", ofType: "mp4") {
            
            let videoPlayer = AVPlayer(url: URL(fileURLWithPath: bundlePath))
            
            let playerLayer = AVPlayerLayer(player: videoPlayer)
            playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            
            //サイズを決める
            playerLayer.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216)
            self.view.layer.addSublayer(playerLayer)
            videoPlayer.play()
            
//            // 動画プレイヤーの用意
//            let playerController = AVPlayerViewController()
//            playerController.player = videoPlayer
//        
//            self.present(playerController, animated: true, completion: {
//                videoPlayer.play()
//            })
        } else {
            print("no such file")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

