//
//  FirstViewController.swift
//  CustomTransitionDemo
//
//  Created by 徐冉 on 2019/4/26.
//  Copyright © 2019年 QK. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.purple
        
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle("Present", for: UIControl.State.normal)
        btn.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        btn.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        btn.center = self.view.center
        
        self.view.addSubview(btn)
        btn.addTarget(self, action: #selector(self.btnTapAction), for: UIControl.Event.touchUpInside)
    }
    
    @objc func btnTapAction() {
        
        let seccendCtrl = SeccendViewController()
        seccendCtrl.transitioningDelegate = self
        seccendCtrl.modalPresentationStyle = .fullScreen
        self.present(seccendCtrl, animated: true, completion: nil)
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return DirectionUpTransitionAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return DirectionDownTransitionAnimator()
    }
    
}
