//
//  TestDownloadVC.swift
//  Mr.GoodBean
//
//  Created by jamie on 2023/9/30.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseDatabase
import FirebaseStorage


class TestDownloadVC: UIViewController {

    let databaseRef = Database.database().reference()
    var userDataforDelegate = [String:Any]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
//    func updateData(data: [String : Any]) {
//        data = userDataforDelegate
//    }
//
    
    @IBAction func DownloadBtnPressed(_ sender: Any) {
        // 下載用戶資料
       // 模仿挑選（比對）出特定筆資料
        databaseRef.child("users").queryOrdered(byChild: "email").queryEqual(toValue: "user1@example.com").observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                if let data = snapshot.value as? [String: Any] {
                    // 处理数据
                    for (userId, userData) in data {
                        if let userDataDict = userData as? [String: Any] {
//                            print("User ID: \(userId)")
//                            print("User Data: \(userDataDict)")
                            DataFromFireBase.shared.currentUserKey = userId
                            DataFromFireBase.shared.currentUser = userDataDict
                        }
                    }
                }
            } else {
                // 数据不存在
                print("未找到特定数据")
            }
            FirebaseCRUD.shared.query(child1: "products", childForSearch: "storeID", Equal: DataFromFireBase.shared.currentUserKey) { products in
                DataFromFireBase.shared.productOfUser = products
                DataFromFireBase.shared.productsKeys = Array(products.keys)
                print("登入商家產品下載完畢")
            }
            
        }
        
        FirebaseCRUD.shared.query(child1: "users", childForSearch: "storerole", Equal: "店家") { dict in
            DataFromFireBase.shared.allStoreDataDict = dict
            DataFromFireBase.shared.allStoreID = Array(dict.keys)
            print("所有商家資料下載完畢")
        }
//        FirebaseCRUD.shared.query(child1: "products", childForSearch: "storeID", Equal: DataFromFireBase.shared.userKey) { products in
//            DataFromFireBase.shared.productOfUser = products
//
//        }
    }
    
    @IBAction func goBtnPressed(_ sender: Any) {
        
        let storyboard = self.storyboard
        if let storeListVC = storyboard?.instantiateViewController(withIdentifier: "StoreListVC") {
            let navigationController = UINavigationController(rootViewController: storeListVC)
            self.view.window?.rootViewController = navigationController
        }
        //productData
//        var productKeyArray = [String]()
//        FirebaseCRUD.shared.query(child1: "products", childForSearch: "storeID", Equal: DataFromFireBase.shared.userKey) { products in
//            productKeyArray = Array(products.keys)
//            DataFromFireBase.shared.productOfUser = products
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
    }
    
//    func fetchData() {
//        print("userDataForDelegate\(userDataforDelegate)")
//        delegate?.dataDidUpdate(data: userDataforDelegate)
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


