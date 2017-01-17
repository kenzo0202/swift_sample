//
//  WatsonViewController.swift
//  SwiftWatson
//
//  Created by 岡野健三 on 2017/01/14.
//  Copyright © 2017年 岡野健三. All rights reserved.
//

import UIKit
import Social

class WatsonViewController: UIViewController {
    
    var receivedImage = UIImage()

    @IBOutlet weak var imageView: UIImageView!
    
    var textArray = [String]()
    var scoreArray = [String]()
    
    var resultString:String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = receivedImage
        
        //タグをつける
        getTag(image: receivedImage)

    }

    @IBAction func back(_ sender: Any) {
        //戻るボタンを押した時に前の画面に戻る
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Twitterにシェアするための関数
    @IBAction func postTwitter(_ sender: Any) {
        
        
        //Tweet用のViewを作成する
        let twitterPostView:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)!
        //Tweetする文章を設定する
        twitterPostView.setInitialText(resultString)
        
        //起動時にキャプチャしたスクリーンショットを添付する
        twitterPostView.add(receivedImage)
        
        //上述の内容を反映したTweet画面を表示する
        self.present(twitterPostView, animated: true, completion: nil)
    }
    
    func getTag(image:UIImage){
        //IBM　WatsonのAPIを使用して、何を表している画像かテキストでもらう
        
        let api_key = "6e3d79413c793e35278ea13adc77c92af1f065da";
        
        let api_url = "https:/gateway-a.watsonplatform.net/calls/image/ImageGetRankedImageKeywords?apikey="+api_key+"&imagePostMode=raw&outputMode=json"
        
        //APIに対してPOSTリクエストをする
        let myURL = URL(string: api_url)
        let request = NSMutableURLRequest(url: myURL!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded",forHTTPHeaderField: "Content-Type")
        let maxsize:Double = 1024 * 768
        var ratio:CGFloat = 1
        
        
        if(Double(image.size.height * image.size.width) > maxsize){
            ratio = CGFloat(maxsize/Double(image.size.height * image.size.width))
        }
        
        let imageData = UIImageJPEGRepresentation(image, ratio)
        request.httpBody = imageData!
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            
            data,response,error in
            if let error = error {
                print(error)
            }
            
        do{
            let json = try JSONSerialization.jsonObject(with: data!) as! [String:AnyObject]
            
            var textArray = [String]()
            var scoreArray = [String]()
            
            if let items = json["imageKeywords"] as? [[String:AnyObject]]{
                
                for item in items{
                    guard let maker = item["text"] as? String else{
                        continue
                    }
                    guard let name = item["score"] as? String else{
                        continue
                    }
                    
                    textArray.append(maker)
                    scoreArray.append(name)
                    
                }
                
            }
            
            let scoreNumber = scoreArray[0]
            let number = Double(scoreNumber)! * 100.0
            
            self.resultString = "この画像で象徴的なキーワードは"+textArray[0] + "と、その確率は" + String(number) + "%"
            
            
        }catch{
            print(error)
        }
        
        }
        
        task.resume()
    }


}
