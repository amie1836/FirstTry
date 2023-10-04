//
//  ViewController.swift
//  Mr.GoodBean
//
//  Created by jamie on 2023/9/7.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseDatabase

let FirebaseUserData : [String:Any] = [:]

class TestViewController: UIViewController {

    // 取得 Firebase Database 的參考
    let database = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.import Firebase
        
        // 取得 Firebase Database 的參考
        //let database = Database.database().reference()
        
        //準備圖檔資料
        var iconBase64 = String()
        if  let icon = UIImage(named: "Roy&Wong.jpg") {
            let imageStruct = DataFromFireBase.ImagetoBase64.init(Image: icon)
            iconBase64 =  imageStruct.toImageBase64()!
        }
        
        var product1Base64 = String()
        if  let product1 = UIImage(named: "product1.jpeg") {
            let productStruct = DataFromFireBase.ImagetoBase64.init(Image: product1)
            product1Base64 =  productStruct.toImageBase64()!
        }
        
        var product2Base64 = String()
        if  let product2 = UIImage(named: "product2.png") {
            let productStruct = DataFromFireBase.ImagetoBase64.init(Image: product2)
            product2Base64 =  productStruct.toImageBase64()!
        }
        
        //創建一個包含資料的字典
        let shopdata: [String: Any] = [
            "users": [
                //"user_id_1": [
                "username": "店家roy",
                "email": "user1@example.com",
                "password": "000000",
                "storerole": true,
                "icon": iconBase64,
                "descriptions": "熊蓋齁",
                "following_store_id" : 1 ,
                "timestamp": Date().timeIntervalSince1970
                //                        ],
                //                        "user_id_2": [
                //                            "username": "買家roy",
                //                            "email": "user2@example.com",
                //                            "timestamp": Date().timeIntervalSince1970
                //                        ]
            ],
            "products": [
                "product_id_1": [
                    "name": "衣索比亞 古吉",
                    "price": 299,
                    "descriptionShort": "水洗 225g , 風味描述：花香、萊姆、巧克力、李子、紅茶、滑口多汁、回甘餘韻, 烘焙程度 :淺焙",
                    "descriptionLong": """
                            描述
                            這款來自衣索比亞古吉地區的咖啡豆，是一種非常特別的單品豆，具有獨特的風味特色和優良的品質。古吉地區位於衣索比亞南部，擁有豐富的高品質咖啡豆產區，其中又以這款「古吉」最為知名。
                            
                            這款咖啡豆海拔高達1900至2100公尺，品種是衣索比亞原生種Heirloom，採用山泉水洗的方式進行加工處理，可以帶出咖啡本身的風味。在品質上，這款咖啡豆被評為等級AA，屬於高品質的單品豆。
                            
                            風味上，這款咖啡豆具有鮮明的花香和萊姆香氣，口感滑順且多汁，並帶有巧克力和李子的甜味，以及紅茶的茶香。整體來說，這款咖啡豆具有回甘餘韻，口感豐富，非常適合手沖咖啡。如果您喜愛咖啡的豐富風味和繽紛口感，這款衣索比亞古吉咖啡豆絕對是您不容錯過的選擇。
                            """,
                    "storeID": "N294oijskjngr",
                    "amount": 10,
                    "picture": product1Base64,
                    "timestamp": Date().timeIntervalSince1970
                ],
                "product_id_2": [
                    "name": "Product 2",
                    "price": 10.99,
                    "description": "Description for Product 2",
                    "storeID": "N294oijskjngr",
                    "amount": 8,
                    "picture": product2Base64,
                    "timestamp": Date().timeIntervalSince1970
                ]
            ],
            "carts": [
                //                        "user_id_1": [
                "product_id_1": [
                    "quantity": 3,
                    "timestamp": Date().timeIntervalSince1970
                ],
                "product_id_2": [
                    "quantity": 1,
                    "timestamp": Date().timeIntervalSince1970
                ]
                //                        ],
                //                        "user_id_2": [
                //                            "product_id_2": [
                //                                "quantity": 2,
                //                                "timestamp": Date().timeIntervalSince1970
                //                            ]
                //                        ]
            ]
        ]
        
        
        // 將資料寫入 Firebase 中的  節點
        
        // 建立參考物件已獲取唯一鍵
        let usersRef = database.child("users").childByAutoId()
        let usersUniqueKey = usersRef.key
        // 使用唯一键构建路径
        // 顯示隱藏的completion功能：option + Enter
        let specificDataRef = database.child("users").child(usersUniqueKey!)
        
        
        
        usersRef.setValue(shopdata["users"]) { (error, ref) in
            if let error = error {
                print("Error writing to Firebase: \(error)")
            } else {
                print("Data written successfully.")
            }
        }
        
        
        if let DictProduct = shopdata["products"] as? [String:Any] {
            let product1 = DictProduct["product_id_1"]
            let product2 = DictProduct["product_id_2"]
            
            for _ in 1...6 {
                
                let updateStordID : [String:Any] = ["storeID": usersUniqueKey!]
                
                let product1Ref = database.child("products").childByAutoId()
                let product1UniqueKey = product1Ref.key
                
                product1Ref.setValue(product1) { (error, ref) in
                    if let error = error {
                        print("Error writing to Firebase: \(error)")
                    } else {
                        print("Data written successfully.")
                    }
                }
                
                product1Ref.updateChildValues(updateStordID) { (error, ref) in
                    if let error = error {
                        print("Error writing to Firebase: \(error)")
                    } else {
                        print("Data written successfully.")
                    }
                }
                
                
                let product2Ref = database.child("products").childByAutoId()
                
                product2Ref.setValue(product2) { (error, ref) in
                    if let error = error {
                        print("Error writing to Firebase: \(error)")
                    } else {
                        print("Data written successfully.")
                    }
                }
                
                
                product2Ref.updateChildValues(updateStordID) { (error, ref) in
                    if let error = error {
                        print("Error writing to Firebase: \(error)")
                    } else {
                        print("Data written successfully.")
                    }
                }
            }
            
        }
        
        database.child("carts").childByAutoId().setValue(shopdata["carts"]) { (error, ref) in
            if let error = error {
                print("Error writing to Firebase: \(error)")
            } else {
                print("Data written successfully.")
            }
        }
        
        // MARK: 加載要上传的图像
        //        if let image = UIImage(named: "Genshin_activate.jpeg") {
        //            // 将图像转换为 Base64 字符串
        //            if let imageData = image.jpegData(compressionQuality: 0.5) {
        //                let base64String = imageData.base64EncodedString()
        //
        //                //test
        //                let base64ImageString = DataFromFireBase.ImageBase64.init(base64String: base64String)
        //                base64ImageString.toImageData()
        //
        //                // 存储 Base64 字符串到 Realtime Database
        //                let dataToSave : [String:Any] = [
        //                    "username": "顧客roy",
        //                    "email": "user1@example.com",
        //                    "password": "000000",
        //                    "storerole": false,
        //                    "icon": base64String,
        //                    "following_store_id" : 1 ,
        //                    "timestamp": Date().timeIntervalSince1970
        //                ]
        //
        //
        //
        //                //上傳資料
        //                //顯示隱藏的completion功能：option + Enter
        //                specificDataRef.setValue(dataToSave) { (error, ref) in
        //                    if let error = error {
        //                        print("存储失败：\(error.localizedDescription)")
        //                    } else {
        //                        print("存储成功")
                                database.child("users").queryOrdered(byChild: "email").queryEqual(toValue: "user1@example.com").observeSingleEvent(of: .value) { (snapshot) in
                                        if snapshot.exists() {
                                            // 数据存在，可以处理它
                                            if let data = snapshot.value as? [String: Any] {
                                                // 处理数据
                                                for (userId, userData) in data {
                                                    if let userDataDict = userData as? [String: Any] {
                                                        print("User ID: \(userId)")
                                                        print("User Data: \(userDataDict)")
                                                    }
                                                }
                                            }
                                        } else {
                                            // 数据不存在
                                            print("未找到特定数据")
                                        }
                                    }
        
        
//                                }
//                        }
//                    }
//                }
        
        
        
        
        
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
        
        //FirebaseCRUD.shared.deleteUser(userID: "-NdnUZaShXEi1RJPHEUQ")
        
        // FirebaseCRUD.shared.readUsers { <#[String : Any]#> in }
        
        
    }

}

