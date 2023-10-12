//
//  NewViewController.swift
//  Mr.GoodBean
//
//  Created by jamie on 2023/9/7.
//

import UIKit
import Firebase
import FirebaseDatabase

class StoreDetailVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    var sotreDescribeTextView : UITextView!
    var bannerImageView : UIImageView!
    var storeDataDict = [String:Any]()
    var productImageArray = [Data]()
    
    var structForNextVC = DataFromFireBase.Product(name: "商品名稱", price: 0, amount: 0, descriptionShort: "商品概述", descriptionLong: """
        這是商品的詳細描述。
        商品描述的第二行。
        商品描述的第三行。
        """, picture: "", storeID: "", timestamp: 0)
    
    var selectedProductId = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storeDataDict = DataFromFireBase.shared.currentUser
//        print("\(userDataDict)")
        //userData
        var userIconData = Data()
        var userBanner = Data()
        var userDescription = String()
        var userName = String()
        
        
        if let IcondataFromFunc = AnytoData(Dict: storeDataDict["icon"]) {
            userIconData = IcondataFromFunc
        }
        if let DesStringFromFunc = AnytoString(Dict: storeDataDict["descriptions"]) {
            userDescription = DesStringFromFunc
        }
        if let NameStringFromFunc = AnytoString(Dict: storeDataDict["username"]) {
            userName = NameStringFromFunc
        }
        
        //productPicDataArray 將商品資料下載下來集成真列
         let productKeyDict = DataFromFireBase.shared.productOfUser
        for i in 0...productKeyDict.count - 1 {
            if let productDetailDict = productKeyDict[DataFromFireBase.shared.productsKeys[i]] as? [String:Any] {
                if let productPicBase64 = productDetailDict["picture"] as? String {
                   let productPicBase64Struct = DataFromFireBase.Base64ToIamge(base64String: productPicBase64)
                    if let Data = productPicBase64Struct.toImageData()  {
                        productImageArray.append(Data)
                    }
                }
            }
        }
//        var productKeyArray = [String]()
//        FirebaseCRUD.shared.query(child1: "products", childForSearch: "storeID", Equal: DataFromFireBase.shared.userKey) { products in
//            productKeyArray = Array(products.keys)
//            for i in 0...productKeyArray.count - 1 {
//                let ref = Database.database().reference()
//                ref.child("products").child(productKeyArray[i]).observeSingleEvent(of: .value) { (DataSnapShot,pre) in
//                    if let Dict = DataSnapShot.value as? [String:Any]  {
//                        if let ImageBase64 = Dict["picture"] as? String {
//                            let ImageBase64Struct = DataFromFireBase.ImageBase64(base64String: ImageBase64)
//                            if let Data = ImageBase64Struct.toImageData() {
//                                self.productImageArray.append(Data)
//
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        var  productImageArray = [Data]()
        // 設置委託對象
       
        
        // 設置背景橫幅
        bannerImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 190))
        bannerImageView.image = UIImage(named: "white_cat_and_dog.jpg") // 背景橫幅的圖片
        bannerImageView.contentMode = .scaleAspectFill
        bannerImageView.clipsToBounds = true
        view.addSubview(bannerImageView)
        
        // 設置圓形頭像
        let avatarImageView = UIImageView(frame: CGRect(x: 23, y: 76, width: 90, height: 90))
        avatarImageView.image = UIImage(data: userIconData) // 頭像的圖片
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
        avatarImageView.clipsToBounds = true
        avatarImageView.backgroundColor = .gray
        view.addSubview(avatarImageView)
        
        //設置姓名標籤
        let nameLabel = UILabel(frame: CGRect(x: 123, y: 116, width: 161, height: 26))
        nameLabel.text = userName
        nameLabel.backgroundColor = .lightText
        view.addSubview(nameLabel)
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
//        nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,constant: 10).isActive = true
//        nameLabel.widthAnchor.constraint(equalToConstant: 161).isActive = true
//        nameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 31).isActive = true
        // 加入UITextView
        //        NSLayoutConstraint.activate([sotreDescribeTV.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor), sotreDescribeTV.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16)])
        
        sotreDescribeTextView = UITextView(frame: CGRect(x: 0, y: bannerImageView.frame.maxY, width: view.frame.width, height: 128))
        sotreDescribeTextView.backgroundColor = UIColor.white // 設置背景色
        sotreDescribeTextView.text = userDescription // 預設文本
        sotreDescribeTextView.font = UIFont.systemFont(ofSize: 16) // 文本字體
        sotreDescribeTextView.textColor = UIColor.black // 文本顏色
        sotreDescribeTextView.textAlignment = .left // 文本對齊方式
        view.addSubview(sotreDescribeTextView)
        
        // 創建UICollectionView佈局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 195, height: 183)
        layout.minimumInteritemSpacing = 3 // 水平間距
        layout.minimumLineSpacing =  5 // 垂直間距
        layout.scrollDirection = .vertical // 垂直滾動
        
        // 創建UICollectionView
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: sotreDescribeTextView.frame.maxY, width: view.frame.width, height: 549), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white // 設置背景色
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell") // 註冊cell類別
        view.addSubview(collectionView)
    }
    
    //轉檔
    func AnytoString (Dict: Any?) -> String? {
        
        guard let AnyFromDict = Dict as? String else {
           return nil
        }
        return AnyFromDict
    }
    
    func AnytoData (Dict: Any?) -> Data? {
        
        guard let AnyFromDict = Dict as? String  else {
           return nil
        }
        let Base64Struct = DataFromFireBase.Base64ToIamge(base64String:AnyFromDict  )
        guard let  Data = Base64Struct.toImageData() else {
           return nil
        }
        return Data
        
    }
    
    // 實現UICollectionViewDataSource方法
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 返回商品數量
        //return yourProductArray.count
        return productImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 創建和配置UICollectionViewCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let productImageView = UIImageView(frame: cell.contentView.bounds)
        productImageView.image = UIImage(data: productImageArray[indexPath.row])
//        productImageView.image = UIImage(named: "product1.jpeg")
        productImageView.contentMode = .scaleAspectFit
        cell.contentView.addSubview(productImageView)
        return cell
    }
    
    // 實現UICollectionViewDelegate方法
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 在此處處理點擊特定商品的操作
        // 獲取選擇的商品或商品ID
        let selectedProduct = DataFromFireBase.shared.productsKeys[indexPath.row]
            selectedProductId = selectedProduct
        
        // 替換成你的商品數據
        // 創建ProductDetailViewController的實例
        //let productDetailVC = ProductDetailVC()
        guard let selectedProductDict = DataFromFireBase.shared.productOfUser["\(selectedProduct)"] as? [String:Any] else {
            assertionFailure("***轉檔失敗***")
            return
        }
        DataFromFireBase.shared.dictToProductStruct(from: selectedProductDict, completion: { Data in
            //print("#####\(Data)")
            self.structForNextVC = Data
        }) // 傳遞商品信息，例如ID或其他需要的數據
        
        // 使用導航控制器將ProductDetailViewController推送到堆棧中
        if let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailVC") {
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
//                               navigationController?.pushViewController(productDetailVC, animated: true)
//                        print("item picked")
        //performSegue(withIdentifier: "showProductDetail", sender: indexPath)
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//     //Get the new view controller using segue.destination.
//     //Pass the selected object to the new view controller.
            if segue.identifier == "showProductDetail" {
                // 獲取目標視圖控制器
                        if let productDetailVC = segue.destination as? ProductDetailVC {
                            // 在這裡可以設置ProductDetailViewController的屬性或進行其他必要的操作
                            // 例如，設置商品信息
                            productDetailVC.productStruct = structForNextVC
                            productDetailVC.selectedProductId = selectedProductId//假設你有一個屬性用於存儲商品ID
                        }
            }
        }
    
    
}
