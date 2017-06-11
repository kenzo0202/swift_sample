//
//  ViewController.swift
//  SentencesRecognizer
//
//  Created by 岡野健三 on 2017/01/17.
//  Copyright © 2017年 岡野健三. All rights reserved.
//

import UIKit
import TesseractOCR

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,G8TesseractDelegate {
    

    @IBOutlet weak var sample_image: UIImageView!
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func recognize(_ sender: Any) {
        if let tesseract = G8Tesseract(language: "jpn"){
            
            tesseract.delegate = self
            tesseract.image = sample_image.image?.g8_blackAndWhite()
            tesseract.pageSegmentationMode = G8PageSegmentationMode.auto
            tesseract.recognize()
            //認識した文字をテキストビューに入れる
            textView.text = tesseract.recognizedText
        }
        
    }
    
    //画像の処理を行っている時に処理を行うデリゲートメソッド
    func progressImageRecognition(for tesseract: G8Tesseract!) {
        print()
    }
    
    @IBAction func getAlbum(_ sender: Any) {
        //アルバムから画像を取得する
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.photoLibrary
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func getCamera(_ sender: Any) {
        //カメラで撮った写真を取ってくる
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.camera
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
    }
    
    //　撮影が完了時した時に呼ばれる
    func imagePickerController(_ imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
    
            sample_image.image = pickedImage
            
        }
        
        //カメラ画面(アルバム画面)を閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
        
    }

    

}

