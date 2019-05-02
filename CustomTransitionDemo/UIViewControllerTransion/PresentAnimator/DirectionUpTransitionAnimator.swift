//
//  DirectionUpTransitionAnimator.swift
//  CustomTransitionDemo
//
//  Created by 徐冉 on 2019/4/26.
//  Copyright © 2019年 QK. All rights reserved.
//
/**
 - Present 动画
 - 从下往上渐现
 */

import UIKit

class DirectionUpTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    // duration for animation
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    // animation for transition
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewConttoller = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        let containerView = transitionContext.containerView
        
        var fromView: UIView!
        var toView: UIView!
        
        // 先用viewForKey取
        if transitionContext.responds(to: #selector(UIViewControllerContextTransitioning.view(forKey:))) {
            fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
            toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        }
        else {
            fromView = fromViewConttoller.view
            toView = toViewController.view
        }
        
        containerView.addSubview(fromView)
        containerView.addSubview(toView)
        
        let initialFrame = transitionContext.initialFrame(for: fromViewConttoller)
        toView.frame = CGRect(x: 0, y: initialFrame.maxY, width: initialFrame.size.width, height: initialFrame.size.height)
        
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.2, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            toView.frame = initialFrame
        }) { (_) in
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }
        
    }
    
}
