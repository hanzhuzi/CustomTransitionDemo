//
//  SeccendViewController.swift
//  CustomTransitionDemo
//
//  Created by 徐冉 on 2019/4/26.
//  Copyright © 2019年 QK. All rights reserved.
//

import UIKit

class SeccendViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.orange
        
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle("Dismiss", for: UIControl.State.normal)
        btn.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        btn.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        btn.center = self.view.center
        
        self.view.addSubview(btn)
        btn.addTarget(self, action: #selector(self.btnTapAction), for: UIControl.Event.touchUpInside)
    }
    
    @objc func btnTapAction() {
        
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
