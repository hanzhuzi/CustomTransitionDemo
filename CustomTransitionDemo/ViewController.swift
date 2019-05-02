//
//  ViewController.swift
//  CustomTransitionDemo
//
//  Created by 徐冉 on 2019/4/26.
//  Copyright © 2019年 QK. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let firstCtrl = FirstViewController()
            self.navigationController?.pushViewController(firstCtrl, animated: true)
        }
        else if indexPath.row == 1 {
            let firstCtrl = ThirdViewController()
            self.navigationController?.pushViewController(firstCtrl, animated: true)
        }
    }
    
    
}

