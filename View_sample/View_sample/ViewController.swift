//
//  ViewController.swift
//  View_sample
//
//  Created by 岡野健三 on 2016/11/18.
//  Copyright © 2016年 岡野健三. All rights reserved.
//

import UIKit
let sectionTitle = ["太郎", "佑二朗", "健三"]
let section0 = [("年齢","27歳"),("職業","会社員"),("好きなこと","読書")]
let section1 = [("年齢","23歳"),("職業","会社員"),("好きなこと","デート")]
let section2 = [("年齢","21歳"),("職業","大学"),("好きなこと","新しいアプリを見る")]
let tableData = [section0, section1, section2]

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let mytableView = UITableView(frame: view.frame, style: .grouped)
        
        //テーブルビューのデリゲートを設定する
        mytableView.delegate = self
        
        //テーブルビューのデータソースを設定する
        mytableView.dataSource = self
        
        view.addSubview(mytableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        //セクションごとの行数を返す
        let sectionData = tableData[section]
        return sectionData.count
        
    }
    
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        ///各行に表示するセルを返す
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let sectionData = tableData[(indexPath as NSIndexPath).section]
        let cellData = sectionData[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = cellData.0
        cell.detailTextLabel?.text = cellData.1
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //セクションタイトルを返す
        return sectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = sectionTitle[indexPath.section]
        let sectionData = tableData[indexPath.section]
        let cellData = sectionData[indexPath.row]
        print("\(title)\(cellData.0)")
        print("\(cellData.1)")
    }


}

