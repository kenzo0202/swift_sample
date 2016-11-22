//
//  ExtensionViewController.swift
//  camera_sample
//
//  Created by 岡野健三 on 2016/11/22.
//  Copyright © 2016年 岡野健三. All rights reserved.
//

import Foundation
import Photos

extension ViewController:AVCapturePhotoCaptureDelegate{
    
    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        //バッファからjpegデータを取り出す
        let photoData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer!, previewPhotoSampleBuffer: previewPhotoSampleBuffer)
        
        //photoDataがnilでない時UIImageに変換する
        if let data = photoData{
            if let stillImage = UIImage(data: data){
                //アルバムに追加する
                UIImageWriteToSavedPhotosAlbum(stillImage, self, nil, nil)
                shareImage = stillImage
            }
        }
        
        
    }
}
