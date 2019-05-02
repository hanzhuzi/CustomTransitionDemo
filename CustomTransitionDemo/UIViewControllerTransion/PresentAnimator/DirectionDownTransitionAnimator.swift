//
//  DirectionDownTransitionAnimator.swift
//  CustomTransitionDemo
//
//  Created by 徐冉 on 2019/4/27.
//  Copyright © 2019年 QK. All rights reserved.
//

/**
 - Dismiss 转场动画
 - 从上向下渐隐
 */

import UIKit

class DirectionDownTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
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
        
        containerView.addSubview(toView)
        containerView.addSubview(fromView)
        
        let initialFrame = transitionContext.initialFrame(for: fromViewConttoller)
        fromView.frame = CGRect(x: 0, y: 0, width: initialFrame.size.width, height: initialFrame.size.height)
        
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.2, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            fromView.frame = CGRect(x: 0, y: initialFrame.maxY, width: initialFrame.size.width, height: initialFrame.size.height)
        }) { (_) in
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }
    }
    
}
