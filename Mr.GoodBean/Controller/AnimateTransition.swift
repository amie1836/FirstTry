//
//  AnimateTransition.swift
//  Mr.GoodBean
//
//  Created by jamie on 2023/9/21.
//

import Foundation
import UIKit

class CustomPopupTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    let presenting: Bool

    init(presenting: Bool) {
        self.presenting = presenting
        super.init()
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1 // 轉場動畫的持續時間
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView

        if presenting {
            // 將警告視圖控制器添加到容器視圖
            if let toView = transitionContext.view(forKey: .to) {
                containerView.addSubview(toView)
            }
            // 設置警告視圖的初始位置（在畫面底部）
            let fromView = transitionContext.view(forKey: .from)
            fromView?.frame.origin.y = containerView.frame.height
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                fromView?.frame.origin.y = containerView.frame.height - (fromView?.frame.height ?? 0)
            }) { (_) in
                transitionContext.completeTransition(true)
            }
        } else {
            // 移除警告視圖控制器的視圖
            if let fromView = transitionContext.view(forKey: .from) {
                UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                    fromView.frame.origin.y = containerView.frame.height
                }) { (_) in
                    fromView.removeFromSuperview()
                    transitionContext.completeTransition(true)
                }
            }
        }
    }
}
