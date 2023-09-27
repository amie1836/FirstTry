//
//  PurchaseView.swift
//  Mr.GoodBean
//
//  Created by jamie on 2023/9/21.
//

import UIKit

class PurchaseView: UIView {
    
    // UI元件
    let leftBtn : UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("退出", for: .normal)
        return button
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize:  20)
        return label
    }()
    
    
    let priceLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize:  20)
        return label
    }()
    
    let specBtn : UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    let grindBtn : UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    let numBtn : UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    let purchaseBtn : UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    var productImageView : UIImageView!
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupView()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setupView()
        }
    

        private func setupView() {
        // 設置視圖的固定大小
        self.frame = CGRect(x: 0, y: 0, width: 393, height: 490)
        // 可以在這裡添加其他視圖元素或自定義 UI
            // 照片
            productImageView = UIImageView(frame: CGRect(x: 38, y: 38, width: 150  , height: 150))
            productImageView.contentMode = .scaleAspectFill
            productImageView.clipsToBounds = true
                   self.addSubview(productImageView)
            productImageView.backgroundColor = .gray
            
            // 創建一個垂直的 UIStackView包含名稱和價格label
            let verticalStackView = UIStackView(arrangedSubviews: [nameLabel, priceLabel])
            verticalStackView.translatesAutoresizingMaskIntoConstraints = false
            verticalStackView.axis = .vertical
            verticalStackView.spacing = 14
            self.addSubview(verticalStackView)
            nameLabel.text = "名稱"
            priceLabel.text = "價格"
            
            NSLayoutConstraint.activate([verticalStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 62),verticalStackView.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 35)])
            
            // 創建另一個垂直的 UIStackView包含規格和研磨的button
            let verticalStackView2 = UIStackView(arrangedSubviews: [specBtn, grindBtn])
            verticalStackView2.translatesAutoresizingMaskIntoConstraints = false
            verticalStackView2.axis = .vertical
            verticalStackView2.alignment = .center
            verticalStackView2.spacing = 10
            specBtn.heightAnchor.constraint(equalToConstant: 42).isActive = true
            specBtn.widthAnchor.constraint(equalToConstant: 318).isActive = true
            grindBtn.heightAnchor.constraint(equalToConstant: 42).isActive = true
            grindBtn.widthAnchor.constraint(equalToConstant: 318).isActive = true
            self.addSubview(verticalStackView2)
            specBtn.setTitle("規格", for: .normal)
            grindBtn.setTitle("研磨", for: .normal)

            NSLayoutConstraint.activate([
                verticalStackView2.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 38),verticalStackView2.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 38)])
            
            // 創建另一個垂直的 UIStackView包含數量和購買的button
            let verticalStackView3 = UIStackView(arrangedSubviews: [numBtn, purchaseBtn])
            verticalStackView3.translatesAutoresizingMaskIntoConstraints = false
            verticalStackView3.axis = .vertical
            verticalStackView3.alignment = .center
            verticalStackView3.spacing = 10
            numBtn.heightAnchor.constraint(equalToConstant: 42).isActive = true
            numBtn.widthAnchor.constraint(equalToConstant: 318).isActive = true
            purchaseBtn.heightAnchor.constraint(equalToConstant: 42).isActive = true
            purchaseBtn.widthAnchor.constraint(equalToConstant: 318).isActive = true
            self.addSubview(verticalStackView3)
            numBtn.setTitle("數量", for: .normal)
            purchaseBtn.setTitle("購買", for: .normal)
            
            NSLayoutConstraint.activate([
                verticalStackView3.topAnchor.constraint(equalTo: verticalStackView2.bottomAnchor, constant: 41),verticalStackView3.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 38)])
            
            // 按鈕
            self.addSubview(leftBtn)
            leftBtn.addTarget(self, action: #selector(leftBtnPressed), for: .touchUpInside)
            NSLayoutConstraint.activate([
                leftBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
                leftBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
            ])
            
        self.backgroundColor = UIColor.lightGray
    }
    
    @objc func leftBtnPressed() {
          // 移除UIView
        //self.removeFromSuperview()
        // 移除UIView + 淡出動畫
        UIView.animate(withDuration: 0.3, animations: {
           self.alpha = 0.0
        }) { (completed) in
            if completed {
                self.removeFromSuperview()
            }
        }
    }
}
