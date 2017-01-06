//
//  FirstTableViewController.swift
//  keyboardCustom
//
//  Created by 岡野健三 on 2017/01/04.
//  Copyright © 2017年 岡野健三. All rights reserved.
//

import UIKit

class FirstTableViewController: UITableViewController {
    
    var imageView:UIImageView = UIImageView()
    
    var imageArray:[String] = ["image1.jpg","image2.jpg","image3.jpg","image4.jpg","image5.jpg","image6.jpg","image7.jpg","image8.jpg","image9.jpg","image10.jpg","image11.jpg"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return imageArray.count
    }
    
    //画面が現れるたびに実行される

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        imageView = cell.contentView.viewWithTag(1) as! UIImageView
        
        imageView.image = UIImage(named: "image1.jpg")
        
        


        return cell
    }

   
}
