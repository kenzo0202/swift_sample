//
//  ViewController.swift
//  Alarm_sample
//
//  Created by 岡野健三 on 2016/12/05.
//  Copyright © 2016年 岡野健三. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    
    @IBOutlet weak var time_label: UILabel!
    
    @IBOutlet weak var time_setting: UIDatePicker!
    
    var timer:Timer = Timer()
    var count:Int = 0
    
    var audioPlayer:AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let audioPath = Bundle.main.path(forResource: "su017", ofType: "mp3")!
        let audioUrl = URL(fileURLWithPath: audioPath)
        
        var audioError:NSError?
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
        }catch let error as NSError{
            audioError = error
            audioPlayer = nil
        }
        // エラーが起きたとき
        if let error = audioError {
            print("Error \(error.localizedDescription)")
        }
        
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func time_set(_ sender: Any) {
        //タイマーが有効であれば、無効にする
        timer.invalidate()
        
        //カウントする数を取得する
        count = Int(time_setting.countDownDuration)
        
        //決まった時間だけカウントダウンする
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.timechanged) , userInfo: nil,repeats: true)
        timer.fire()
    }
    
    func timechanged(){
        count -= 1
        
        if(count>0){
            time_label.text = "残り\(count)秒です"
        }else if(count == 0) {
            audioPlayer.play()
        }
        else{
            time_label.text = "終わりです"
        }
        
    }

}

