//
//  ViewController.swift
//  Mr.GoodBean
//
//  Created by jamie on 2023/9/7.
//

import UIKit
import FirebaseCore
import FirebaseDatabase


class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.import Firebase
        
        // 取得 Firebase Database 的參考
        let database = Database.database().reference()
        
        // 創建一個包含資料的字典
        //        let shopdata: [String: Any] = [
        //            "users": [
        //                "user_id_1": [
        //                    "username": "user1",
        //                    "email": "user1@example.com",
        //                    "timestamp": Date().timeIntervalSince1970
        //                ],
        //                "user_id_2": [
        //                    "username": "user2",
        //                    "email": "user2@example.com",
        //                    "timestamp": Date().timeIntervalSince1970
        //                ]
        //            ],
        //            "products": [
        //                "product_id_1": [
        //                    "name": "Product 1",
        //                    "description": "Description for Product 1",
        //                    "price": 10.99,
        //                    "timestamp": Date().timeIntervalSince1970
        //                ],
        //                "product_id_2": [
        //                    "name": "Product 2",
        //                    "description": "Description for Product 2",
        //                    "price": 19.99,
        //                    "timestamp": Date().timeIntervalSince1970
        //                ]
        //            ],
        //            "carts": [
        //                "user_id_1": [
        //                    "product_id_1": [
        //                        "quantity": 3,
        //                        "timestamp": Date().timeIntervalSince1970
        //                    ],
        //                    "product_id_2": [
        //                        "quantity": 1,
        //                        "timestamp": Date().timeIntervalSince1970
        //                    ]
        //                ],
        //                "user_id_2": [
        //                    "product_id_2": [
        //                        "quantity": 2,
        //                        "timestamp": Date().timeIntervalSince1970
        //                    ]
        //                ]
        //            ]
        //        ]
        //
        //
        //        // 將資料寫入 Firebase 中的 "follows" 節點
        //        database.child("carts").childByAutoId().setValue(shopdata["carts"]) { (error, ref) in
        //            if let error = error {
        //                print("Error writing to Firebase: \(error)")
        //            } else {
        //                print("Data written successfully.")
        //            }
        //        }
        
        // 新增test
        //        let ref = database.child("users").childByAutoId()
        //        let user: [String:Any] = [
        //                "post": "oooooaooaa",
        //                "hobby": "gaaagaagagaa",
        //                "timestamp": ServerValue.timestamp()
        //            ]
        //
        //            ref.setValue(user) { (error, _) in
        //                if let error = error {
        //                    print("Error creating user: \(error)")
        //                } else {
        //                    print("User created successfully")
        //                }
        //            }
        //
        
        FirebaseCRUD.shared.deleteUser(userID: "-NdnUZaShXEi1RJPHEUQ")
        
        
        
    }

}

