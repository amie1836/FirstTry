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
    var userDataDict = [String:Any]()
    var productImageArray = [Data]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userDataDict = DataFromFireBase.shared.currentUser
        print("\(userDataDict)")
        //userData
        var userIconData = Data()
        var userBanner = Data()
        var userDescription = String()
        var userName = String()
        
        if let IcondataFromFunc = AnytoData(Dict: userDataDict["icon"]) {
            userIconData = IcondataFromFunc
        }
        if let DesStringFromFunc = AnytoString(Dict: userDataDict["descriptions"]) {
            userDescription = DesStringFromFunc
        }
        if let NameStringFromFunc = AnytoString(Dict: userDataDict["username"]) {
            userName = NameStringFromFunc
        }
        
        //productPicDataArray
         let productKeyDict = DataFromFireBase.shared.productOfUser
        for i in 0...productKeyDict.count - 1 {
            if let productDetailDict = productKeyDict[DataFromFireBase.shared.productsKeys[i]] as? [String:Any] {
                if let productPicBase64 = productDetailDict["picture"] as? String {
                   let productPicBase64Struct = DataFromFireBase.ImageBase64(base64String: productPicBase64)
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
        view.addSubview(avatarImageView)
        
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
        let Base64Struct = DataFromFireBase.ImageBase64(base64String:AnyFromDict  )
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
        //                        let selectedProduct = yourProductArray[indexPath.row] // 替換成你的商品數據
        
        // 創建ProductDetailViewController的實例
        //let productDetailVC = ProductDetailVC()
        //                        productDetailVC.productID = selectedProduct // 傳遞商品信息，例如ID或其他需要的數據
        
        // 使用導航控制器將ProductDetailViewController推送到堆棧中
        //                        navigationController?.pushViewController(productDetailVC, animated: true)
        //                print("item picked")
        performSegue(withIdentifier: "productSegue", sender: indexPath)
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
    //        if segue.identifier == "showProductDetail" {
    //            // 獲取目標視圖控制器
    //                    if let productDetailVC = segue.destination as? ProductDetailVC {
    //                        // 在這裡可以設置ProductDetailViewController的屬性或進行其他必要的操作
    //                        // 例如，設置商品信息
    //                        //productDetailVC.productID = selectedProductID // 假設你有一個屬性用於存儲商品ID
    //                    }
    //        }
    //    }
    //
    //
}
