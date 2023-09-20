//
//  ProductDetailVC.swift
//  Mr.GoodBean
//
//  Created by jamie on 2023/9/19.
//

import UIKit

class ProductDetailVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
   
    @IBOutlet weak var cameraBtn: UIBarButtonItem!
    
    var productImageView : UIImageView!
    
    // 主 Stack View，包含所有視圖元素
        let mainStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.spacing = 16
            return stackView
        }()
    // 商品敘述
        let productNameLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 1
            label.font = UIFont.boldSystemFont(ofSize:  24)
            return label
        }()

        let productDescriptionLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 2
            label.font = UIFont.systemFont(ofSize: 16)
            return label
        }()

        let productPriceLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 17)
            return label
        }()

        let productInventoryLabel: UILabel = {
            let label = UILabel()
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加自定義按鈕到導航列
        self.navigationItem.rightBarButtonItem = self.cameraBtn
           
        // 禁止視圖延伸到導航列下方
//            edgesForExtendedLayout = []
        view.backgroundColor = .white
        
        //ImageView實作
        productImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 300))
        productImageView.contentMode = .scaleAspectFill
        productImageView.clipsToBounds = true
               view.addSubview(productImageView)
        productImageView.backgroundColor = .lightGray
//        view.sendSubviewToBack(productImageView)
        
        // 添加商品敘述
        // 創建一個垂直的 UIStackView 包含商品名稱、概述和垂直對齊的價格和存貨數量
                let verticalStackView = UIStackView(arrangedSubviews: [productNameLabel, productDescriptionLabel])
                verticalStackView.translatesAutoresizingMaskIntoConstraints = false
                verticalStackView.axis = .vertical
                verticalStackView.spacing = 8

                // 創建一個水平的 UIStackView 包含價格和存貨數量
                let horizontalStackView = UIStackView(arrangedSubviews: [productPriceLabel, productInventoryLabel, ])
                horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
                horizontalStackView.axis = .horizontal
                horizontalStackView.alignment = .leading // 將對齊方式設置為左對齊
                horizontalStackView.spacing = 8

                // 將垂直的 UIStackView 和水平的 UIStackView 添加到主 Stack View
//                mainStackView = UIStackView(arrangedSubviews: [verticalStackView, horizontalStackView])
//                mainStackView.translatesAutoresizingMaskIntoConstraints = false
//                mainStackView.axis = .vertical
//                mainStackView.spacing = 16
                mainStackView.addArrangedSubview(verticalStackView)
                mainStackView.addArrangedSubview(horizontalStackView)
                

                // 添加主 Stack View 到根視圖
                view.addSubview(mainStackView)

                // 設置主 Stack View 的約束
                NSLayoutConstraint.activate([
                    mainStackView.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 16),
                    mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//                    mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
                ])

                // 在這裡設置商品照片、商品敘述、價格和存貨的內容
                productImageView.image = UIImage(named: "your_product_image")
                productNameLabel.text = "商品名稱"
                productDescriptionLabel.text = "商品特色，商品概述，商品說明"
                productPriceLabel.text = "價格：$99.99"
                productInventoryLabel.text = "存貨：100 個"
            
        
         // 商品詳情內容
        let productDescription = """
        這是商品的詳細描述。
        商品描述的第二行。
        商品描述的第三行。
        8
        8
        8
        8
        
        8
        8
        8
        8
        8
        88
        8
        8
        8
        8
        8
        8
        8
        8
        8
        8
        8
        
        
        8
        8
        8
        """
        
        // 設置商品詳情的內容
        productDescriptionTextView.text = productDescription
        view.addSubview(productDescriptionTextView)

        // 設置商品詳情的 UITextView 的約束
        NSLayoutConstraint.activate([
            productDescriptionTextView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 16),
            productDescriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            productDescriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            productDescriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16) // 可選：限制底部間距
        ])
        





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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
