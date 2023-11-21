//
//  ProductDetailVC.swift
//  Mr.GoodBean
//
//  Created by jamie on 2023/9/19.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseDatabase

class ProductDetailVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
   
    @IBOutlet weak var cameraBtn: UIBarButtonItem!
    
    @IBOutlet weak var cartBtn: UIButton!
    //資料
    var productStruct = DataFromFireBase.Product(name: "商品名稱", price: 0, amount: 0, descriptionShort: "商品概述", descriptionLong: """
        這是商品的詳細描述。
        商品描述的第二行。
        商品描述的第三行。
        """, picture: "", storeID: "", timestamp: 0)
    
    var pictureData = Data()
    var selectedProductId = String()
    
    var productImageView : UIImageView!
    
    // 主 Stack View，包含所有視圖元素
        let mainStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.spacing = 20
            return stackView
        }()
    
    
    // 商品敘述
    
        let productNameLabel: UILabel = {
            let label = UILabel()
//            label.widthAnchor.constraint(equalToConstant: 300).isActive = true
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 1
            label.lineBreakMode = .byWordWrapping
            label.font = UIFont.boldSystemFont(ofSize:  24)
            //label.attributedText = NSAttributedString.DocumentReadingOptionKey
            return label
        }()

        let productDescriptionLabel: UILabel = {
            let label = UILabel()
            //label.widthAnchor.constraint(equalToConstant: 380).isActive = true
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.font = UIFont.systemFont(ofSize: 16)
            return label
        }()

        let productPriceLabel: UILabel = {
            let label = UILabel()
            label.widthAnchor.constraint(equalToConstant: 100).isActive = true
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 17)
            return label
        }()

        let productInventoryLabel: UILabel = {
            let label = UILabel()
            label.widthAnchor.constraint(equalToConstant: 100).isActive = true
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 17)
            return label
        }()
    
    // 商品詳情的 UITextView
    let productDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.isEditable = false // 避免編輯
        return textView
    }()
    
    // MARK: 購物車的顯示
    var purchaseView : PurchaseView?
    // Pickerview內容
    var arrayForPicker = [String]()
    var aButtonPressed = 0
    // cart資料
    let cartRef = Database.database().reference().child("carts")
    var cartStruct = DataFromFireBase.Cart(user_id: "\(DataFromFireBase.shared.currentUserKey)",product_id: "error", spec: "error", grind: "error", amount: 0, timestamp: 0)
    
    // 選擇樣式的畫面
    // PickerView for 選項
    let pickerView : UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    // 讓pickerView像鍵盤彈出的隱藏texyView
    let textFieldForPicker : UITextField = {
        let textField = UITextField()
        textField.isHidden = true
        return textField
    }()
    
    // PickerView的ToolBar
    let pickerViewToolBar : UIToolbar = {
        let toolBar = UIToolbar()
        //print("\(toolBar.frame.height)")
//        let leftBtn = UIBarButtonItem(title: "退出", style: .plain, target: ProductDetailVC.self, action: #selector(toolBarCancelButtonTapped))
//        let rightBtn = UIBarButtonItem(title: "確認", style: .plain, target: ProductDetailVC.self, action: #selector(toolBarConfirmButtonTapped))
//        let flexibleSpace = UIBarButtonItem(systemItem: .flexibleSpace)
//        toolBar.setItems([leftBtn,flexibleSpace,rightBtn], animated: false)
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        return toolBar
    }()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // For用戶
        cameraBtn.isHidden = true
        
        //轉檔圖片Base64
         let base64Struct = DataFromFireBase.Base64ToIamge(base64String: productStruct.picture)
        if let ImageData = base64Struct.toImageData() {
            pictureData = ImageData
        }
        
        // 添加自定義按鈕到導航列
//        self.navigationItem.rightBarButtonItem = self.cameraBtn
           
        self.navigationItem.setRightBarButton(cameraBtn, animated: true)
        // 禁止視圖延伸到導航列下方
        
//            edgesForExtendedLayout = []
        view.backgroundColor = .white
        
        //ImageView實作
        
        productImageView = UIImageView()
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.contentMode = .scaleAspectFit
        productImageView.clipsToBounds = true
               view.addSubview(productImageView)
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([productImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),productImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),productImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),productImageView.heightAnchor.constraint(equalToConstant: 280)]
        )
      
        productImageView.backgroundColor = .lightGray
//        view.sendSubviewToBack(productImageView)
        
        // 添加商品敘述
        // 創建一個垂直的 UIStackView 包含商品名稱、概述和垂直對齊的價格和存貨數量
        
                let horizontalStackView1 = UIStackView(arrangedSubviews: [productNameLabel, cartBtn])
                horizontalStackView1.translatesAutoresizingMaskIntoConstraints = false
                horizontalStackView1.axis = .horizontal
                horizontalStackView1.spacing = 8

                // 創建一個水平的 UIStackView 包含價格和存貨數量
                let horizontalStackView2 = UIStackView(arrangedSubviews: [productPriceLabel, productInventoryLabel, ])
                horizontalStackView2.translatesAutoresizingMaskIntoConstraints = false
                horizontalStackView2.axis = .horizontal
                horizontalStackView2.alignment = .leading // 將對齊方式設置為左對齊
                horizontalStackView2.spacing = 8

                // 將垂直的 UIStackView 和水平的 UIStackView 添加到主 Stack View
//                mainStackView = UIStackView(arrangedSubviews: [verticalStackView, horizontalStackView])
//                mainStackView.translatesAutoresizingMaskIntoConstraints = false
//                mainStackView.axis = .vertical
//                mainStackView.spacing = 16
                mainStackView.addArrangedSubview(horizontalStackView1)
                mainStackView.addArrangedSubview(productDescriptionLabel)
                mainStackView.addArrangedSubview(horizontalStackView2)
                

                // 添加主 Stack View 到根視圖
                view.addSubview(mainStackView)

                // 設置主 Stack View 的約束
        NSLayoutConstraint.activate([
                    mainStackView.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 16),
                    mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                    
                    mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
                ])
        
                // 設置 Stack View 內容物的約束
                NSLayoutConstraint.activate([
                    productNameLabel.widthAnchor.constraint(equalToConstant: 280),
                    productDescriptionLabel.widthAnchor.constraint(equalToConstant: 324)
                ])
        
                // 在這裡設置商品照片、商品敘述、價格和存貨的內容
                productImageView.image = UIImage(data: pictureData)
                productNameLabel.text = productStruct.name
                productDescriptionLabel.text = productStruct.descriptionShort
                productPriceLabel.text = "價格：\(productStruct.price)"
                productInventoryLabel.text = "庫存：\(productStruct.amount)"
            
       
        // 設置商品詳情的內容
        productDescriptionTextView.text = productStruct.descriptionLong
        view.addSubview(productDescriptionTextView)

        // 設置商品詳情的 UITextView 的約束
        NSLayoutConstraint.activate([
            productDescriptionTextView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 16),
            productDescriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            productDescriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            productDescriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
        
        // pickerView dataSource
        pickerView.dataSource = self
        pickerView.delegate = self
    }

    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // 確保 mainStackView 已完成佈局
        mainStackView.layoutIfNeeded()

        // 獲取 mainStackView 的大小和位置
        let mainStackViewFrame = mainStackView.frame

        // mainStackView 的 x 和 y 座標
        let x = mainStackViewFrame.origin.x
        let y = mainStackViewFrame.origin.y

        // mainStackView 的寬度和高度
        let width = mainStackViewFrame.size.width
        let height = mainStackViewFrame.size.height

        // 輸出 mainStackView 的尺寸和位置信息
        print("mainStackView 的 x 座標：\(x)")
        print("mainStackView 的 y 座標：\(y)")
        print("mainStackView 的寬度：\(width)")
        print("mainStackView 的高度：\(height)")
        
        // ToolBar BarItem設置
        let leftBtn = UIBarButtonItem(title: "退出", style: .plain, target: self, action: #selector(toolBarCancelButtonTapped))
        let rightBtn = UIBarButtonItem(title: "確認", style: .plain, target:  self, action: #selector(toolBarConfirmButtonTapped))
        let flexibleSpace = UIBarButtonItem(systemItem: .flexibleSpace)
        pickerViewToolBar.setItems([leftBtn,flexibleSpace,rightBtn], animated: false)
    }

    
    // 處理選擇照片的按鈕點擊事件
    @IBAction func PickerBtn(_ sender: Any) {
        let imagePicker = UIImagePickerController()
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
                present(imagePicker, animated: true, completion: nil)
    }
   
    // 實現UIImagePickerControllerDelegate方法，處理選擇照片後的回調
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                productImageView.image = selectedImage
            }
            picker.dismiss(animated: true, completion: nil)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    
    
    @IBAction func cartBtnPress(_ sender: Any) {
       
        //創造view實例以及貼上
        purchaseView = PurchaseView()
        
        // 設置購買介面視圖的初始位置，將其放在屏幕下方
        purchaseView?.frame.origin.y = self.view.frame.height
        //purchaseView.ViewController = self
        purchaseView?.delegate = self
        
       // self.addChild(<#T##childController: UIViewController##UIViewController#>)
        if let purchaseView = purchaseView {
            self.view.addSubview(purchaseView)
            
            UIView.animate(withDuration: 0.5) {
                
                // 設置購買介面視圖的新位置，使其顯示在屏幕上
                purchaseView.frame.origin.y = self.view.frame.height - purchaseView.frame.height
            }
            
            // 簡單傳值
            if self.productImageView != nil
            {
                purchaseView.productImageView.image = self.productImageView.image
                purchaseView.nameLabel.text = "\(productStruct.name)"
                purchaseView.priceLabel.text = "NT$\(productStruct.price)"
            }
        }
//        let purchaseVC = PurchaseVC()
//        present(purchaseVC, animated: true)
        
//        let customPopup = CustomPopupViewController(title: "警告～～～", message: "這是一個自定義警告視圖。")
//
//        customPopup.showAlert(in: self)
//
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

 }
    


extension ProductDetailVC: purchaseViewDelegate {
    // PickerView 的玩意兒
    func openPickerView(arrayForPicker:[String],aButtonPressed: Int) {
        self.arrayForPicker = arrayForPicker
        self.view.addSubview(pickerView)
        // NSLayout
        pickerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        pickerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        pickerView.topAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true // 初始位置在畫面底部
        pickerView.heightAnchor.constraint(equalToConstant: pickerView.frame.height).isActive = true
        
        // textViewForPicker放進來
        self.view.addSubview(textFieldForPicker)
        textFieldForPicker.inputView = pickerView
        // toolBar放進來
        self.view.addSubview(pickerViewToolBar)
        pickerViewToolBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        pickerViewToolBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        pickerView.topAnchor.constraint(equalTo: pickerView.bottomAnchor).isActive = true
        textFieldForPicker.inputAccessoryView = pickerViewToolBar
        textFieldForPicker.becomeFirstResponder()
        self.aButtonPressed = aButtonPressed
    }
 
    @objc func toolBarConfirmButtonTapped() {
    let row = pickerView.selectedRow(inComponent: 0)
     switch aButtonPressed {
     case 1 :
        cartStruct.spec = arrayForPicker[row]
     case 2 :
         cartStruct.grind = arrayForPicker[row]
     case 3 :
         if let amount = Int(arrayForPicker[row]) {
             cartStruct.amount = amount
         }
     case 4 :
         cartStruct.product_id = selectedProductId
         cartStruct.cartStructToDict { dict in
             self.cartRef.childByAutoId().setValue(dict) { error, _ in
                 if let error = error {
                     print("Error upload cart: \(error)")
                     
                 } else {
                     // 將新增的購物車加進cartOfUserDict
                     FirebaseCRUD.shared.query(child1: "carts", childForSearch: "user_id", Equal: DataFromFireBase.shared.currentUserKey) { dict in
                         for (key,value) in dict {
                             DataFromFireBase.shared.cartOfUser[key] = value
                         }
                     }
                     print("Cart upload successfully")
                     DataFromFireBase.shared.didAddCart = true
                 }
             }
         }
         if let purchaseView = purchaseView {
             UIView.animate(withDuration: 0.3, animations: {
                 purchaseView.alpha = 0.0
             }) { (completed) in
                 if completed {
                     purchaseView.removeFromSuperview()
                 }
             }
         }
        NotificationCenter.default.post(name: NSNotification.Name("CartAdd"), object: nil)
             
     default :
            aButtonPressed = 0
         }
         self.view.endEditing(true)
     }

@objc func toolBarCancelButtonTapped() {
    self.view.endEditing(true)
 }
}

extension ProductDetailVC : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // 一個組件
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayForPicker.count // 選項的數量
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayForPicker[row] // 返回選項的標題
    }

//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        // 用戶選擇的選項
//        let selectedOption = arrayForPicker[row]
//        // 在這裡處理選擇，例如將其存儲在變數中
//    }
}
