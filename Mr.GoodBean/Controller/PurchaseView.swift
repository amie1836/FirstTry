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
    
//    // 選擇樣式的PickerView
//    let pickerView : UIPickerView = {
//        let pickerView = UIPickerView()
//        pickerView.translatesAutoresizingMaskIntoConstraints = false
//        return pickerView
//    }()
//    
//    // 讓pickerView像鍵盤彈出的隱藏texyView
//    let textFieldForPicker : UITextField = {
//        let textField = UITextField()
//        textField.isHidden = true
//        return textField
//    }()
//    
//    // PickerView的ToolBar
//    let pickerViewToolBar : UIToolbar = {
//        let toolBar = UIToolbar()
//        //print("\(toolBar.frame.height)")
//        let leftBtn = UIBarButtonItem(title: "退出", style: .plain, target: PurchaseView.self, action: #selector(toolBarCancelButtonTapped))
//        let rightBtn = UIBarButtonItem(title: "確認", style: .plain, target: PurchaseView.self, action: #selector(toolBarConfirmButtonTapped))
//        let flexibleSpace = UIBarButtonItem(systemItem: .flexibleSpace)
//        toolBar.setItems([leftBtn,flexibleSpace,rightBtn], animated: false)
//        toolBar.translatesAutoresizingMaskIntoConstraints = false
//        
//        return toolBar
//    }()
//    
    // 確認按哪個按鈕
//    var spectIsBtnPressed = false
//    var grindIsBtnPressed = false
//    var numBtnIsPressed = false
//    var cartBtnIsPressed = false
    var aButtonPressed = 0
   
    // Pickerview內容
   // var arrayForPicker = [String]()
    
    // PurchaseViewController本人
   // var ViewController : ProductDetailVC?
    
    
    
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
        
//        // PickerView放進來
//        if let existViewController = ViewController {
//            existViewController.view.addSubview(pickerView)
//            // textViewForPicker放進來
//            existViewController.view.addSubview(textFieldForPicker)
//            textFieldForPicker.inputView = pickerView
//        }
        
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
        // PickerView放進來
//        if let self = ViewController {
//            self.arrayForPicker = ["4/1磅","半磅","一磅"]
//            pickerView.dataSource = self
//            pickerView.delegate = self
//            self.view.addSubview(pickerView)
//            // NSLayout
//            pickerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
//            pickerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
//            pickerView.topAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true // 初始位置在畫面底部
//                pickerView.heightAnchor.constraint(equalToConstant: pickerView.frame.height).isActive = true
//
//            // textViewForPicker放進來
//            self.view.addSubview(textFieldForPicker)
//            textFieldForPicker.inputView = pickerView
//            // toolBar放進來
//            self.view.addSubview(pickerViewToolBar)
//            pickerViewToolBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
//            pickerViewToolBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
//            pickerView.topAnchor.constraint(equalTo: pickerView.bottomAnchor).isActive = true
//            textFieldForPicker.inputAccessoryView = pickerViewToolBar
//            textFieldForPicker.becomeFirstResponder()
//            aButtonPressed = 1
//        }
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
    
    // pickerViewToolBar barButtonItem的功能
//   @objc  func toolBarCancelButtonTapped() {
//        if let existViewController = ViewController {
//            existViewController.view.endEditing(true)
//        }
//       self.delegate?.toolBarCancelButtonTapped()
//    }
    
    
//   @objc  func toolBarConfirmButtonTapped() {
//        if let existViewController = ViewController {
//            v
//     switch aButtonPressed {
//            case 1 :
//         self.cartStruct.spec = existViewController.arrayForPicker[row]
//           default :
//                aButtonPressed = 0
//            }
//            existViewController.view.endEditing(true)
//        }
//       self.delegate?.toolBarConfirmButtonTapped( row: pickerView.selectedRow(inComponent: 0),aButtonPressed: aButtonPressed)
//    }
}

//extension ProductDetailVC : UIPickerViewDataSource, UIPickerViewDelegate {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1 // 一個組件
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return arrayForPicker.count // 選項的數量
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return arrayForPicker[row] // 返回選項的標題
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        // 用戶選擇的選項
//        let selectedOption = arrayForPicker[row]
//        // 在這裡處理選擇，例如將其存儲在變數中
//    }
//}


