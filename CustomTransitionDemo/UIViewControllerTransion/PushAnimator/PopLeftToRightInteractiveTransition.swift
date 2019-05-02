//
//  PopLeftToRightInteractiveTransition.swift
//  CustomTransitionDemo
//
//  Created by 徐冉 on 2019/4/29.
//  Copyright © 2019年 QK. All rights reserved.
//

/**
 - Pop交互式转场
 */

import UIKit

class PopLeftToRightInteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    weak var transitionContext: UIViewControllerContextTransitioning?
    var panGesture: UIScreenEdgePanGestureRecognizer?
    var edge: UIRectEdge = UIRectEdge.left
    
    private override init() {
        super.init()
    }
    
    convenience init(panGesture: UIScreenEdgePanGestureRecognizer?) {
        self.init()
        
        self.panGesture = panGesture
        self.panGesture?.addTarget(self, action: #selector(self.panGestureDidUpdate(panGes:)))
    }
    
    deinit {
        self.panGesture?.removeTarget(self, action: #selector(self.panGestureDidUpdate(panGes:)))
    }
    
    // MARK: - Overrides
    // 转场速度
    override var completionSpeed: CGFloat {
        get {
            return 0.5 * 0.35
        }
        
        set {
            super.completionSpeed = completionSpeed
        }
    }
    
    override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        
        self.transitionContext = transitionContext
        
        super.startInteractiveTransition(transitionContext)
    }
    
    // MARK: - Methods
    // 百分比计算
    func percentForPanGesture(panGes: UIScreenEdgePanGestureRecognizer) -> CGFloat {
        
        let containerView = self.transitionContext?.containerView
        
        let location = panGes.location(in: containerView)
        
        if let width: CGFloat = containerView?.frame.size.width {
            if self.edge == .left {
                return location.x / width
            }
        }
        else {
            return 0
        }
        
        return 0
    }
    
    // MARK: - Action
    @objc func panGestureDidUpdate(panGes: UIScreenEdgePanGestureRecognizer) {
        
        switch panGes.state {
        case .began:
            break
        case .changed:
            // 更新转场进度
            let percent = self.percentForPanGesture(panGes: panGes)
            self.update(percent)
            break
        case .ended:
            let percent = self.percentForPanGesture(panGes: panGes)
            if percent >= 0.35 {
                self.finish()
            }
            else {
                self.cancel()
            }
            break
        default:
            // 其他情况发生
            self.cancel()
            break
        }
    }
    
}
