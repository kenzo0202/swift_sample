//
//  ViewController.swift
//  Facerecognition
//
//  Created by 岡野健三 on 2017/05/12.
//  Copyright © 2017年 岡野健三. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var faceText: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let headers: HTTPHeaders = [
        "Accept": "application/json",
        "Ocp-Apim-Subscription-Key": "f59087f4b45f4da386462ae933582e18"
    ]
    
    @IBAction func touch(_ sender: Any) {
        // APIを叩く
        getEmotion()
        // レスポンスの中から感情を読み取る
        // 一番感情の値が強いものを表示する
        // faceTextのテキストを変更する
    }
    
    var emoArray = ["sadness",
                              "anger",
                              "happiness",
                              "fear",
                              "neutral",
                              "contempt",
                              "disgust",
                              "surprise"]
    var emoDict : [String:Float] = [:]
    var emoCount : [Float] = []
    
    private func getEmotion(){
        Alamofire.request("https://westus.api.cognitive.microsoft.com/emotion/v1.0/recognize",
                          method: .post,
                          parameters: ["url":"https://s3-ap-northeast-1.amazonaws.com/apolo-line/kenzo.jpg"],
                          encoding: JSONEncoding.default,
                          headers : headers
            ).responseJSON{
                response in
                guard let object = response.result.value else{
                    return
                }
                let json = JSON(object)
                print(json)
                
                //jsonデータ内のループ
                json.forEach { (_, json) in
                    //感情別のループ
                    for num in 0...7 {
                        let emotion : String = self.emoArray[num]
                        print(emotion)
                        let emoFloat : Float = json["scores"][emotion].float!
                        print(emoFloat)
                        self.emoDict[emotion] = emoFloat
//                        self.emoCount.append(emoFloat)
                    }
                }
                var myArr = Array(self.emoDict.keys)
                var sortedKeys = myArr.sort {
                    let obj1 = Float(self.emoDict[$0]!) // get ob associated w/ key 1
                    let obj2 = Float(self.emoDict[$1]!) // get ob associated w/ key 2
                    return obj1 > obj2
                }
                
//                self.emoCount.sort{ $1 < $0 }
                
                self.faceText.text = String(describing: myArr[0])
               
        }
    }
}



