//
//  AnimateController.swift
//  Mr.GoodBean
//
//  Created by jamie on 2023/9/21.
//

import Foundation
import UIKit

class CustomPresentationController: UIPresentationController {

    override var frameOfPresentedViewInContainerView: CGRect {
        // 設置警告視圖控制器的大小和位置
        let containerBounds = containerView?.bounds ?? CGRect.zero
        let presentedSize = CGSize(width: containerBounds.width - 40, height: 200)
        let presentedOrigin = CGPoint(x: 20, y: containerBounds.midY - presentedSize.height / 2)
        return CGRect(origin: presentedOrigin, size: presentedSize)
    }

    override func presentationTransitionWillBegin() {
        // 在呈現過程開始前執行任何必要的操作
    }

    override func presentationTransitionDidEnd(_ completed: Bool) {
        // 在呈現過程完成後執行任何必要的操作
    }

    override func dismissalTransitionWillBegin() {
        // 在關閉過程開始前執行任何必要的操作
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
        // 在關閉過程完成後執行任何必要的操作
    }
}
