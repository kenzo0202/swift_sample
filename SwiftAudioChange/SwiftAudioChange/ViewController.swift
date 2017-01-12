//
//  ViewController.swift
//  SwiftAudioChange
//
//  Created by 岡野健三 on 2017/01/11.
//  Copyright © 2017年 岡野健三. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,AVAudioPlayerDelegate{

    
    @IBOutlet weak var sc: UIScrollView!
    
    var uv:UIImageView = UIImageView()
    
    fileprivate var audioEngine = AVAudioEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        uv.frame = CGRect(x: 0, y: 0, width: 800, height: 80)
        
        
        
        for i in 0..<6 {
            let button:UIButton = UIButton()
            button.frame = CGRect(x: i*80 + 1, y: 0, width: 80, height: 80)
            var image:UIImage = UIImage()
            image = UIImage(named: String(i + 1) + ".png")!
            button.setImage(image, for: UIControlState.normal)
            button.viewWithTag(i)
            button.addTarget(self, action: #selector(changeVoice), for: .touchUpInside)
            
            uv.addSubview(button)
        }
        
        sc.addSubview(uv)
        sc.contentSize = uv.bounds.size
        
    }
    
    func changeVoice(sender:UIButton){
        switch sender.tag{
            case 0:
                audioEngine.stop()
                audioEngine.reset()
                clearVoice1()
            case 1:
                audioEngine.stop()
                audioEngine.reset()
                clearVoice2()
            case 2:
                audioEngine.stop()
                audioEngine.reset()
                clearVoice3()
            case 3:
                audioEngine.stop()
                audioEngine.reset()
                clearVoice4()
            case 4:
                audioEngine.stop()
                audioEngine.reset()
                clearVoice5()
            case 5:
                audioEngine.stop()
                audioEngine.reset()
                clearVoice6()
        default:
            print("こんにちは")
            
        }
    
        
        
        
    }
    
    func clearVoice1(){
        //AudioSessionを作成する
        let audioSession = AVAudioSession.sharedInstance()
        do{
            try audioSession.setActive(true)
        }catch let error as NSError{
            print("エラーでっせ")
        }
        
        let input = audioEngine.inputNode
        let mixir = audioEngine.outputNode
        
        //リバーブの設定
        let reverb = AVAudioUnitReverb()
        reverb.loadFactoryPreset(.largeHall)
        audioEngine.attach(reverb)
        
        //distortionの設定　歪みの設定
        let distortion = AVAudioUnitDistortion()
        distortion.loadFactoryPreset(.multiDistortedFunk)
        distortion.preGain = 10
        audioEngine.attach(distortion)
        
        //イコライザーの設定
        let eq = AVAudioUnitEQ()
        eq.globalGain = 20
        audioEngine.attach(eq)
        
        
        //全てを順番に接続する
        audioEngine.connect(input!, to: reverb, format: input!.inputFormat(forBus:0))
        audioEngine.connect(reverb, to: distortion, format: input!.inputFormat(forBus:0))
        audioEngine.connect(distortion, to: eq, format: input!.inputFormat(forBus:0))
        audioEngine.connect(eq, to: mixir, format: input!.inputFormat(forBus:0))
        
        
    }
    
    func clearVoice2(){
        // AudioSession init
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(true)
        } catch let error as NSError  {
            print("Error : \(error)")
        }
        
        // Mic -> Effect -> BusMixer
        let input = audioEngine.inputNode
        let mixer = audioEngine.mainMixerNode
        
        
        // example for connect three effectNode
        
        // Reverb
        let reverb = AVAudioUnitReverb()
        reverb.loadFactoryPreset(.largeHall)
        audioEngine.attach(reverb)
        
        // Distortion
        
        let distortion = AVAudioUnitDistortion()
        distortion.loadFactoryPreset(.multiEcho1)
        distortion.preGain = -6
        audioEngine.attach(distortion)
        
        // Delay
        let delay = AVAudioUnitDelay()
        delay.delayTime = 1
        audioEngine.attach(delay)
        
        // EQ
        let eq = AVAudioUnitEQ()
        eq.globalGain = 60
        audioEngine.attach(eq)
        
        //全てを順番に接続する
        audioEngine.connect(input!, to: reverb, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(reverb, to: delay, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(delay, to: eq, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(eq, to: mixer, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(input!, to: distortion, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(distortion, to: mixer, format: input!.inputFormat(forBus: 0))
        
        
        try! audioEngine.start()

    }
    func clearVoice3(){
        // AudioSession init
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(true)
        } catch let error as NSError  {
            print("Error : \(error)")
        }
        
        // Mic -> Effect -> BusMixer
        let input = audioEngine.inputNode
        let mixer = audioEngine.mainMixerNode
        
        
        // example for connect three effectNode
        
        // Reverb
        let reverb = AVAudioUnitReverb()
        reverb.loadFactoryPreset(.cathedral)
        reverb.wetDryMix = 50
        audioEngine.attach(reverb)
        
        // Distortion
        
        let distortion = AVAudioUnitDistortion()
        distortion.loadFactoryPreset(.multiBrokenSpeaker)
        distortion.preGain = -6
        audioEngine.attach(distortion)
        
        // Delay
        let delay = AVAudioUnitDelay()
        delay.delayTime = 1
        audioEngine.attach(delay)
        
        // EQ
        let eq = AVAudioUnitEQ()
        eq.globalGain = 50
        audioEngine.attach(eq)
        
        // connect!
        audioEngine.connect(input!, to: reverb, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(reverb, to: delay, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(delay, to: eq, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(eq, to: mixer, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(input!, to: distortion, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(distortion, to: mixer, format: input!.inputFormat(forBus: 0))
        
        
        try! audioEngine.start()

        
    }
    func clearVoice4(){
        // AudioSession init
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(true)
        } catch let error as NSError  {
            print("Error : \(error)")
        }
        
        // Mic -> Effect -> BusMixer
        let input = audioEngine.inputNode
        let mixer = audioEngine.mainMixerNode
        
        
        // example for connect three effectNode
        
        // Reverb
        let reverb = AVAudioUnitReverb()
        reverb.loadFactoryPreset(.largeRoom2)
        audioEngine.attach(reverb)
        
        // Distortion
        
        
        let distortion = AVAudioUnitDistortion()
        distortion.loadFactoryPreset(.multiCellphoneConcert)
        distortion.preGain = -6
        audioEngine.attach(distortion)
        
        // Delay
        let delay = AVAudioUnitDelay()
        delay.delayTime = 1
        audioEngine.attach(delay)
        
        // EQ
        let eq = AVAudioUnitEQ()
        eq.globalGain = 90
        audioEngine.attach(eq)
        
        // connect!
        audioEngine.connect(input!, to: reverb, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(reverb, to: delay, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(delay, to: eq, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(eq, to: mixer, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(input!, to: distortion, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(distortion, to: mixer, format: input!.inputFormat(forBus: 0))
        
        
        try! audioEngine.start()

    }
    func clearVoice5(){
        // AudioSession init
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(true)
        } catch let error as NSError  {
            print("Error : \(error)")
        }
        
        // Mic -> Effect -> BusMixer
        let input = audioEngine.inputNode
        let mixer = audioEngine.mainMixerNode
        
        
        // example for connect three effectNode
        
        // Reverb
        let reverb = AVAudioUnitReverb()
        reverb.loadFactoryPreset(.mediumChamber)
        audioEngine.attach(reverb)
        
        // Distortion
        
        let distortion = AVAudioUnitDistortion()
        distortion.loadFactoryPreset(.multiEcho2)
        audioEngine.attach(distortion)
        
        // Delay
        let delay = AVAudioUnitDelay()
        delay.delayTime = 1
        audioEngine.attach(delay)
        
        // EQ
        let eq = AVAudioUnitEQ()
        eq.globalGain = 90
        audioEngine.attach(eq)
        
        // connect!
        audioEngine.connect(input!, to: reverb, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(reverb, to: delay, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(delay, to: eq, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(eq, to: mixer, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(input!, to: distortion, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(distortion, to: mixer, format: input!.inputFormat(forBus: 0))
        
        
        try! audioEngine.start()

    }
    func clearVoice6(){
        
        // AudioSession init
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(true)
        } catch let error as NSError  {
            print("Error : \(error)")
        }
        
        // Mic -> Effect -> BusMixer
        let input = audioEngine.inputNode
        let mixer = audioEngine.mainMixerNode
        
        
        // example for connect three effectNode
        
        // Reverb
        let reverb = AVAudioUnitReverb()
        reverb.loadFactoryPreset(.mediumHall3)
        audioEngine.attach(reverb)
        
        // Distortion
        
        let distortion = AVAudioUnitDistortion()
        distortion.loadFactoryPreset(.speechCosmicInterference)
        //    distortion.preGain = -10
        audioEngine.attach(distortion)
        
        
        // EQ
        let eq = AVAudioUnitEQ()
        eq.globalGain = -96
        audioEngine.attach(eq)
        
        // connect!
        audioEngine.connect(input!, to: reverb, format: input!.inputFormat(forBus: 0))
        //    audioEngine.connect(reverb, to: delay, format: input!.inputFormat(forBus: 0))
        //audioEngine.connect(delay, to: eq, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(eq, to: mixer, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(input!, to: distortion, format: input!.inputFormat(forBus: 0))
        audioEngine.connect(distortion, to: mixer, format: input!.inputFormat(forBus: 0))
        
        
        try! audioEngine.start()
        
        

        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

