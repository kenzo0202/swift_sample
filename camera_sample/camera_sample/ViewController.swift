//
//  ViewController.swift
//  camera_sample
//
//  Created by 岡野健三 on 2016/11/22.
//  Copyright © 2016年 岡野健三. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController  {
    
    var session = AVCaptureSession()
    var photoOutput = AVCapturePhotoOutput()
    
    var shareImage:UIImage?
    
    var authStatus:AuthorizedStatus = .authorized
    var inOutStatus:InputOutputStatus = .ready
    
    
    enum AuthorizedStatus {
        case authorized
        case notAuthorized
        case failed
    }
    
    enum InputOutputStatus {
        case ready
        case notReady
        case failed
    }
    
    let notification = NotificationCenter.default
    
    
    @IBAction func shareAction(_ sender: UIBarButtonItem) {
        guard let shareImage = shareImage else{
            return
        }
        
        let sharedText = "いええええええい！！"
        let activities = [sharedText as AnyObject, shareImage]
        let appActivities = [UIActivity()]
        
        let activityVC = UIActivityViewController(activityItems: activities, applicationActivities: appActivities)
        
        self.present(activityVC, animated: true, completion: nil)
        
    }
    

    
    @IBOutlet weak var shutterButton: UIButton!
    @IBOutlet weak var previewView: UIView!
    
    @IBAction func camshot(_ sender: UIButton) {
        
        if(authStatus == .authorized) && (inOutStatus == .ready){
            let captureSetting = AVCapturePhotoSettings()
            //A setting for whether to fire the flash when capturing photos.
            captureSetting.flashMode = .auto
            
            //A Boolean value that specifies whether captures use automatic image stabilization
            captureSetting.isAutoStillImageStabilizationEnabled = true
            
            //A Boolean value that specifies whether to capture still images at the highest resolution supported by the active device and format
            captureSetting.isHighResolutionPhotoEnabled = false
            
            photoOutput.capturePhoto(with: captureSetting, delegate: self)
        }else{
            showAlert(appname: "カメラ")
        }
        
    }
    
    func setupInputOutput(){
        //解像度の指定 写真用の最大解像度, ビデオ出力ではサポートされない
        session.sessionPreset = AVCaptureSessionPresetPhoto
        
        do{
            let device = AVCaptureDevice.defaultDevice(withDeviceType: AVCaptureDeviceType.builtInWideAngleCamera
                , mediaType: AVMediaTypeVideo
                , position: .back)
            
            let input = try AVCaptureDeviceInput(device: device)
            if session.canAddInput(input){
                session.addInput(input)
            }else{
                print("セッションに入力を追加できなかった")
                return
            }
        }catch let error as NSError{
            print("カメラがない\(error)")
            return
        }
        
        if session.canAddOutput(photoOutput){
            session.addOutput(photoOutput)
        }else{
            print("セッションに出力を追加できなかった")
            return
        }
    }
    
    func setPreviewLayer() {
        //プレビューレイヤーを作成する
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        
        guard let videoPlayer = previewLayer else{
            print("プレビューレイヤーを作成できませんでした")
            return
        }
        
        videoPlayer.frame = view.bounds
        videoPlayer.masksToBounds = true
        videoPlayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        previewView.layer.addSublayer(videoPlayer)
        
        
    }
    override func viewDidAppear(_ animated: Bool){
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //セッション実行中ならば中断する
        if session.isRunning{
            return
        }
        
        cameraAuth()
        
        
        //入出力の設定
        setupInputOutput()
        
        if(authStatus == .authorized) && (inOutStatus == .ready){
            //プレビューレイヤーの設定
            setPreviewLayer()
            
            //セッション開始
            session.startRunning()
            
            shutterButton.isEnabled = true
        }else{
            
            shutterButton.isEnabled = false
            showAlert(appname: "カメラ")
        }
        
        
        notification.addObserver(self, selector: #selector(self.changeDeviceOrientation(_:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
    }
    
    func cameraAuth(){
        let status = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        
        switch status {
        case .notDetermined:
            //初回起動時
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: {[unowned self] authorized in
                print("初回",authorized.description)
                if authorized{
                    self.authStatus = .authorized
                }else{
                    self.authStatus = .notAuthorized
                }})
            
        case .restricted, .denied:
            authStatus = .notAuthorized
            
        case .authorized:
            authStatus = .authorized
        }
    }
    
    func showAlert(appname :String){
        let aTitle = appname + "のプライバシー認証"
        let aMessage = "設定>プライバシー>" + appname + "で利用してください"
        
        let alert = UIAlertController(title: aTitle, message: aMessage, preferredStyle: .alert)
        
        alert.addAction(
            UIAlertAction(title: "OK", style: .default, handler: nil)
        )
        
        alert.addAction(
            UIAlertAction(title: "設定を開く", style: .default, handler: {
                action in
                UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
            })
        )
        self.present(alert, animated: false, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func changeDeviceOrientation(_ notification :Notification){
        if let photoOutputConnection = self.photoOutput.connection(withMediaType: AVMediaTypeVideo){
            
            switch UIDevice.current.orientation {
            case .portrait:
                photoOutputConnection.videoOrientation = .portrait
            case .portraitUpsideDown:
                photoOutputConnection.videoOrientation = .portraitUpsideDown
            case .landscapeLeft:
                photoOutputConnection.videoOrientation = .landscapeRight
            case .landscapeRight:
                photoOutputConnection.videoOrientation = .landscapeLeft
            default:
                break
            }
        }
    }

}

