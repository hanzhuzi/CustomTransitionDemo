//
//  BaseNavigationController.swift
//  CustomTransitionDemo
//
//  Created by 徐冉 on 2019/4/30.
//  Copyright © 2019年 QK. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    private var customScreenPanGesture: UIScreenEdgePanGestureRecognizer?
    private var isDriveByCustomPanGesture: Bool = false
    private var navOperation: UINavigationController.Operation = .none
    
    
    deinit {
        self.delegate = nil
        self.customScreenPanGesture?.delegate = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        let appearance = UIBarButtonItem.appearance()
        appearance.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: 0), for: UIBarMetrics.default)
        
        // 自定义侧滑返回手势驱动
        self.customScreenPanGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.handleEdgePanGestureAction(panGes:)))
        self.customScreenPanGesture?.edges = .left
        self.customScreenPanGesture?.delegate = self
        self.view.addGestureRecognizer(self.customScreenPanGesture!)
        
        self.delegate = self
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }

    override var childForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
    
    // MARK: - Methods
    // handle for UIScreenEdgePanGestureRecognizer
    @objc func handleEdgePanGestureAction(panGes: UIScreenEdgePanGestureRecognizer) {
        
        if panGes.state == .began {
            // 手势开始时调用pop方法，后面交给PopLeftToRightInteractiveTransition处理
            self.isDriveByCustomPanGesture = true
            self.popViewController(animated: true)
        }
    }
    
    // MARK: - UIGestureRecognizerDelegate
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.viewControllers.count == 1 {
            return false
        }
        return true
    }

    // MARK: - UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {

        if self.customScreenPanGesture != nil {
            if navigationController.viewControllers.count == 1 {
                self.customScreenPanGesture?.isEnabled = false
            }
            else {
                self.customScreenPanGesture?.isEnabled = true
            }
        }

    }

    /// Oerride 处理底部TabBar隐藏显示问题
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {

        if self.customScreenPanGesture != nil {
            self.customScreenPanGesture?.isEnabled = false
        }
        
        if self.viewControllers.count >= 1 {
            viewController.hidesBottomBarWhenPushed = true
        }

        super.pushViewController(viewController, animated: true)
    }

    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {

        if let fIndex = self.viewControllers.index(of: viewController) {
            if fIndex == 0 {
                viewController.hidesBottomBarWhenPushed = false
            }
            else {
                viewController.hidesBottomBarWhenPushed = true
            }
        }

        return super.popToViewController(viewController, animated: animated)
    }

    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {

        for index_ in 0 ..< viewControllers.count {
            let viewCtrl = viewControllers[index_]
            if index_ == 0 {
                viewCtrl.hidesBottomBarWhenPushed = false
            }
            else {
                viewCtrl.hidesBottomBarWhenPushed = true
            }
        }

        super.setViewControllers(viewControllers, animated: animated)
    }
    
    // MARK: - 自定义转场
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.navOperation = operation
        if operation == .push {
            return PushRightToLeftAnimator()
        }
        else if operation == .pop {
            return PushByLeftToRightAnimator()
        }
        
        return nil
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        if navOperation == .pop && isDriveByCustomPanGesture {
            isDriveByCustomPanGesture = false
            return PopLeftToRightInteractiveTransition(panGesture: self.customScreenPanGesture)
        }
        
        return nil
    }
    
    /// MARK: - 旋转屏幕控制
    override var shouldAutorotate: Bool {
        if let topCtrl = topViewController {
            return topCtrl.shouldAutorotate
        }
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }

}
