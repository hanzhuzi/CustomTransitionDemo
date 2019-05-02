//
//  ThirdViewController.swift
//  CustomTransitionDemo
//
//  Created by 徐冉 on 2019/4/29.
//  Copyright © 2019年 QK. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UINavigationControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle("Push", for: UIControl.State.normal)
        btn.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        btn.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        btn.center = self.view.center
        
        self.view.addSubview(btn)
        btn.addTarget(self, action: #selector(self.btnTapAction), for: UIControl.Event.touchUpInside)
        
    }
    
    @objc func btnTapAction() {
        
        let seccendCtrl = FourViewController()
        self.navigationController?.pushViewController(seccendCtrl, animated: true)
    }
    
}
