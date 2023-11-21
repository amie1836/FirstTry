//
//  TestLoginVC.swift
//  Mr.GoodBean
//
//  Created by jamie on 2023/10/16.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseDatabase

class TestLoginVC: UIViewController {
    
    let databaseRef = Database.database().reference()
    var userDataforDelegate = [String:Any]()

    @IBOutlet weak var MrGoodBeanImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MrGoodBeanImageView.image = UIImage(named: "MrGoodBean.jpg")
        MrGoodBeanImageView.contentMode = .scaleAspectFit
        nameLabel.text = "Mr.GoodBean"
        // Do any additional setup after loading the view.
        
        // 下載用戶資料
       // 模仿挑選（比對）出特定筆資料
        databaseRef.child("users").queryOrdered(byChild: "email").queryEqual(toValue: "user1@example.com").observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                if let data = snapshot.value as? [String: Any] {
                    // 处理数据
                    for (userId, userData) in data {
                        if let userDataDict = userData as? [String: Any] {
                            DataFromFireBase.shared.currentUserKey = userId
                            DataFromFireBase.shared.currentUser = userDataDict
                            FirebaseCRUD.shared.query(child1: "carts", childForSearch: "user_id", Equal: userId) { dict in
                                DataFromFireBase.shared.cartOfUser = dict
                            }
                        }
                    }
                }
            } else {
                // 数据不存在
                print("未找到特定数据")
            }
            
            FirebaseCRUD.shared.query(child1: "users", childForSearch: "storerole", Equal: "店家") { dict in
                DataFromFireBase.shared.allStoreDataDict = dict
                DataFromFireBase.shared.allStoreID = Array(dict.keys)
                print("所有商家資料下載完畢")
            }
            
            
            
            FirebaseCRUD.shared.query(child1: "products", childForSearch: "storeID", Equal: DataFromFireBase.shared.currentUserKey) { products in
                DataFromFireBase.shared.productOfUser = products
                DataFromFireBase.shared.productsKeys = Array(products.keys)
                print("登入商家產品下載完畢")
                //下載後跳轉
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                       UIView.transition(with: self.view.window!, duration: 0.5, options: .transitionCrossDissolve, animations: {
                           let storyboard = self.storyboard
                           if let storeListVC = storyboard?.instantiateViewController(withIdentifier: "StoreListVC") {
                               
                               let navigationController = UINavigationController(rootViewController: storeListVC)
                               if let tabbarController = storyboard?.instantiateViewController(withIdentifier: "tabBarController") as? UITabBarController {
                                   self.view.window?.rootViewController = tabbarController
                               }
                               //self.view.window?.rootViewController = navigationController
                           }
                       }, completion: nil)
                   }
            }
        }
        
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
