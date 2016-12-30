//
//  ViewController.swift
//  SwiftWunderList
//
//  Created by 岡野健三 on 2016/12/28.
//  Copyright © 2016年 岡野健三. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {

    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var backView: UIImageView!
    @IBOutlet weak var FormView: UIView!
    
    @IBOutlet weak var table: UITableView!
    
    var count:Int = Int()
    
    
    var titleArray = [String]()
    
    var label:UILabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FormView.layer.cornerRadius = 10.0
        table.delegate = self
        table.dataSource = self
        textfield.delegate = self
        
        table.separatorStyle = .none
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //titleArrayをアプリ内から出す
        if (UserDefaults.standard.object(forKey: "array") != nil) {
            titleArray = UserDefaults.standard.object(forKey: "array") as! [String]
        }
        
        //背景画像を適用する
        
        if (UserDefaults.standard.object(forKey: "button") != nil){
            
            let buttontag = UserDefaults.standard.string(forKey: "button")
            
            backView.image = UIImage(named: buttontag! + ".jpg")
            
        }
        
        
        //tableviewを再度呼び出して、デリゲートメソッドを呼び出す
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        count = indexPath.row
        
        //画面遷移をしたい
        performSegue(withIdentifier: "next", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "next"){
            
            let nextVC:NextViewController = segue.destination as! NextViewController
            
            nextVC.selectedNumber = count
        }
    }
    
    //セルを右にスライドしたら削除する
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete){
            titleArray.remove(at: indexPath.row)
            UserDefaults.standard.set(titleArray, forKey: "array")
            table.reloadData()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //配列にフィールドの文字列を入れる
        titleArray.append(textfield.text!)
        //アプリ内に保存する
        UserDefaults.standard.set(titleArray, forKey: "array")
        
        if (UserDefaults.standard.object(forKey: "array") != nil) {
            titleArray = UserDefaults.standard.object(forKey: "array") as! [String]
            
            textfield.text = ""
            
            table.reloadData()
            
        }
        
        //キーボードを閉じる
        textfield.resignFirstResponder()
       
        
        return true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //セクション数を返す
        return 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        
        cell.layer.cornerRadius = 10.0
        label = cell.contentView.viewWithTag(1) as! UILabel
        label.text = titleArray[indexPath.row]
        
        return cell
    }


}

