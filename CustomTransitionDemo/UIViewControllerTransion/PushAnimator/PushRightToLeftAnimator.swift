//
//  PushRightToLeftAnimator.swift
//  CustomTransitionDemo
//
//  Created by 徐冉 on 2019/4/29.
//  Copyright © 2019年 QK. All rights reserved.
//
/**
 - 从右向左动画
 - Push
 */

import UIKit

class PushRightToLeftAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView;
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        
        var fromView: UIView!
        var toView: UIView!
        
        if transitionContext.responds(to: #selector(UIViewControllerContextTransitioning.view(forKey:))) {
            fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
            toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        }
        else {
            fromView = fromViewController?.view
            toView = toViewController?.view
        }
        
        let maskView = UIView(frame: CGRect.zero)
        
        containerView.addSubview(fromView)
        containerView.addSubview(maskView)
        containerView.addSubview(toView)
        
        let initalFrame = transitionContext.initialFrame(for: fromViewController!)
        
        fromView.frame = CGRect(x: 0, y: 0, width: initalFrame.size.width, height: initalFrame.size.height)
        toView.frame = CGRect(x: initalFrame.size.width, y: 0, width: initalFrame.size.width, height: initalFrame.size.height)
        maskView.frame = CGRect(x: 0, y: 0, width: initalFrame.size.width, height: initalFrame.size.height)
        
        maskView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        maskView.alpha = 0
        
        toView.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
        toView.layer.shadowOffset = CGSize(width: -3, height: 0)
        toView.layer.shadowRadius = 3
        toView.layer.shadowOpacity = 0
        
        let duration = self.transitionDuration(using: transitionContext)
        
        let basicAnima = CABasicAnimation(keyPath: "shadowOpacity")
        basicAnima.fromValue = 0
        basicAnima.toValue = 1
        basicAnima.duration = duration
        basicAnima.repeatCount = 1
        basicAnima.isRemovedOnCompletion = false
        basicAnima.autoreverses = false
        basicAnima.fillMode = .forwards
        basicAnima.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeInEaseOut)
        toView.layer.add(basicAnima, forKey: "shadowOpacityAnimation")
        
        UIView.animate(withDuration: duration, animations: {
            fromView.frame = CGRect(x: -initalFrame.size.width * 0.35, y: 0, width: initalFrame.size.width, height: initalFrame.size.height)
            toView.frame = CGRect(x: 0, y: 0, width: initalFrame.size.width, height: initalFrame.size.height)
            maskView.frame = CGRect(x: -initalFrame.size.width * 0.35, y: 0, width: initalFrame.size.width, height: initalFrame.size.height)
            maskView.alpha = 1
        }) { (_) in
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
            maskView.removeFromSuperview()
        }
        
    }
    
}
