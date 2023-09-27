//
//  TestVC.swift
//  Mr.GoodBean
//
//  Created by jamie on 2023/9/21.
//

import Foundation
import UIKit

class CustomPopupViewController: UIViewController {

    // 自定義初始化方法，接受警告標題和消息
    init(title: String?, message: String?) {
        super.init(nibName: nil, bundle: nil)
        
        // 設置背景顏色和圓角
        view.backgroundColor = UIColor.blue
        view.layer.cornerRadius = 10
        
        // 創建標題標籤
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .center
        
        // 創建消息標籤
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        // 添加標題和消息標籤到視圖
        view.addSubview(titleLabel)
        view.addSubview(messageLabel)
        
        // 設置標題和消息標籤的約束
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 240),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            messageLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 自定義方法，用於顯示警告消息
    func showAlert(in viewController: UIViewController) {
        modalPresentationStyle = .custom
        transitioningDelegate = self
        viewController.present(self, animated: true, completion: nil)
    }
}

// 實現自定義轉場動畫
extension CustomPopupViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return CustomPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomPopupTransitionAnimator(presenting: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomPopupTransitionAnimator(presenting: false)
    }
}
