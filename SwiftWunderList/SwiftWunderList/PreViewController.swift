//
//  PreViewController.swift
//  SwiftWunderList
//
//  Created by 岡野健三 on 2016/12/28.
//  Copyright © 2016年 岡野健三. All rights reserved.
//

import UIKit

class PreViewController: UIViewController {
    

    @IBOutlet weak var sv: UIScrollView!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var vc = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vc.frame = CGRect(x: 0, y: 0, width: 800, height: 80)
        

        
        for i in 0..<10 {
            let button:UIButton = UIButton()
            button.tag = i
            button.frame = CGRect(x: i*80, y: 0, width: 80, height: 80)
            
            let buttonImage:UIImage = UIImage(named: String(i)+".jpg")!
            
            button.setImage(buttonImage, for: UIControlState.normal)
            button.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
            
            vc.addSubview(button)
        }
        
        sv.addSubview(vc)
        sv.contentSize = vc.bounds.size

        

    }
    
    func selectImage(sender:UIButton){
        //画像をUIImageViewに反映する
        backImageView.image = UIImage(named: String(sender.tag)+".jpg")
        
        //そのボタンのタグ情報をアプリ内に保存する
        UserDefaults.standard.set(sender.tag, forKey: "button")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

   
}
