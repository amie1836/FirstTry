//
//  PurchaseView.swift
//  Mr.GoodBean
//
//  Created by jamie on 2023/9/21.
//

import UIKit
//import Firebase
//import FirebaseCore
//import FirebaseDatabase

 protocol purchaseViewDelegate : AnyObject {
//    @objc func toolBarCancelButtonTapped ()
//    @objc func toolBarConfirmButtonTapped (row: Int,aButtonPressed: Int)
     func openPickerView (arrayForPicker:[String],aButtonPressed: Int)
}


class PurchaseView: UIView {
    
    // 準備Delegate變數
    weak var delegate : purchaseViewDelegate?
    
    //    // cart資料
    //    let cartRef = Database.database().reference().child("carts")
    //    var cartStruct = DataFromFireBase.Cart(user_id: "\(DataFromFireBase.shared.currentUserKey)", spec: "error", grind: "error", amount: 0, timestamp: 0)
    
    // UI元件
    
    var productImageView : UIImageView!
    
    let leftBtn : UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("退出", for: .normal)
        return button
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
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
    
    
    var aButtonPressed = 0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //    override func viewDidLoad() {
    //            super.viewDidLoad()
    //            // Do any additional setup after loading the view.
    //
    //            songTextField.inputView = songPickerView
    //            songTextField.inputAccessoryView = songToolbar
    //    }
    
    
    private func setupView() {
        // 設置視圖的固定大小
        // self.frame = CGRect(x: 0, y: 0, width: 393, height: 490)
        self.frame = CGRect(x: 0, y: 0, width: 393, height: 852)
        
        // 可以在這裡添加其他視圖元素或自定義 UI
        // 照片
        let grayView = UIView(frame: CGRect(x: 0, y: 362, width: 393, height: 490))
        grayView.backgroundColor = .gray
        
        self.addSubview(grayView)
        
        productImageView = UIImageView(frame: CGRect(x: 38, y: 38, width: 150  , height: 150))
        productImageView.contentMode = .scaleAspectFill
        productImageView.clipsToBounds = true
        grayView.addSubview(productImageView)
        productImageView.backgroundColor = .gray
        
        // 創建一個垂直的 UIStackView包含名稱和價格label
        let verticalStackView = UIStackView(arrangedSubviews: [nameLabel, priceLabel])
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 14
        grayView.addSubview(verticalStackView)
        nameLabel.text = "名稱"
        priceLabel.text = "價格"
        
        NSLayoutConstraint.activate([nameLabel.widthAnchor.constraint(equalToConstant: 132),
                                     verticalStackView.topAnchor.constraint(equalTo: grayView.topAnchor, constant: 72),verticalStackView.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 25)])
        
        
        
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
        grayView.addSubview(verticalStackView2)
        specBtn.setTitle("規格", for: .normal)
        grindBtn.setTitle("研磨", for: .normal)
        
        specBtn.addTarget(self, action: #selector(specBtnPressed), for: .touchUpInside)
        grindBtn.addTarget(self, action: #selector(grindBtnPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            verticalStackView2.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 38),verticalStackView2.leadingAnchor.constraint(equalTo: grayView.leadingAnchor, constant: 38)])
        
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
        grayView.addSubview(verticalStackView3)
        numBtn.setTitle("數量", for: .normal)
        purchaseBtn.setTitle("加入購物車", for: .normal)
        
        numBtn.addTarget(self, action: #selector(numBtnPressed), for: .touchUpInside)
        purchaseBtn.addTarget(self, action: #selector(purchaseBtnPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            verticalStackView3.topAnchor.constraint(equalTo: verticalStackView2.bottomAnchor, constant: 41),verticalStackView3.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 38)])
        
        // 按鈕
        grayView.addSubview(leftBtn)
        leftBtn.addTarget(self, action: #selector(leftBtnPressed), for: .touchUpInside)
        NSLayoutConstraint.activate([
            leftBtn.topAnchor.constraint(equalTo: grayView.topAnchor, constant: 10),
            leftBtn.trailingAnchor.constraint(equalTo:
                                                grayView.trailingAnchor, constant: -16)
        ])
        
        self.backgroundColor = UIColor.lightText
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
    
    // 商品設定按鈕功能
    
    @objc func specBtnPressed() {
        aButtonPressed = 1
        var arrayForPicker = ["4/1磅","半磅","一磅"]
        self.delegate?.openPickerView(arrayForPicker: arrayForPicker,aButtonPressed: aButtonPressed)
    }
    
    @objc func grindBtnPressed() {
        aButtonPressed = 2
        var arrayForPicker = ["法式濾壓","手沖","摩卡壺"]
        self.delegate?.openPickerView(arrayForPicker: arrayForPicker,aButtonPressed: aButtonPressed)
        
    }
    
    @objc func numBtnPressed() {
        aButtonPressed = 3
        var arrayForPicker = ["1","2","3","4","5","6","7","8","9","10"]
        self.delegate?.openPickerView(arrayForPicker: arrayForPicker,aButtonPressed: aButtonPressed)
    }
    
    @objc func purchaseBtnPressed() {
        aButtonPressed = 4
        var arrayForPicker = ["確定將產品加入購物車？"]
        self.delegate?.openPickerView(arrayForPicker: arrayForPicker,aButtonPressed: aButtonPressed)

        
    }
    
}

