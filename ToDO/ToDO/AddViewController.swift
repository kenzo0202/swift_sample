//
//  AddViewController.swift
//  ToDO
//
//  Created by 岡野健三 on 2016/12/12.
//  Copyright © 2016年 岡野健三. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    var array = [String]()

    @IBOutlet weak var Inputfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //画面が表示されるたびに実行される
        
    }

    @IBAction func add(_ sender: Any) {
        
        if UserDefaults.standard.object(forKey: "array") != nil{
            array = UserDefaults.standard.object(forKey: "array") as! [String]
        }
        
        array.append(Inputfield.text!)
        
        //アプリ内に配列を保存する
        UserDefaults.standard.set(array, forKey: "array")
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
