//
//  ViewController.swift
//  SwiftWatson
//
//  Created by 岡野健三 on 2017/01/14.
//  Copyright © 2017年 岡野健三. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var cameraImage = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            }

    @IBAction func pickAlbum(_ sender: Any) {
        let sourceType:UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.photoLibrary
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
        
    }
    @IBAction func pickCamera(_ sender: Any) {
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
            
            //backImageViewというものをはじめにつくっておいて、そのimageに
            //撮影された画像(アルバムで選択された画像)が、デリゲートメソッドが呼ばれたときに
            //UserPhotoボタンがタップされた時、
            //入っているpickedImageを代入する
            cameraImage = pickedImage
            
            // アルバムに追加.
            UIImageWriteToSavedPhotosAlbum(pickedImage, self, nil, nil)
            
            performSegue(withIdentifier: "next", sender: nil)
        }
        
        //カメラ画面(アルバム画面)を閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next"{
            
            let watsonController:WatsonViewController = segue.destination as! WatsonViewController
            
            watsonController.receivedImage = cameraImage
        }
        
    }


}

