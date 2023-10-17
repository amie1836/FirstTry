//
//  DataFromFireBase.swift
//  Mr.GoodBean
//
//  Created by jamie on 2023/9/11.
//

import Foundation
import UIKit

class DataFromFireBase {
    
    static var shared = DataFromFireBase()
    private init() {
        
    }
    
    var allStoreDataDict = [String:Any]()
    var allStoreID = [String]()
    var loadingUserDataDict = [String:Any]()
    
    var currentUser = [String:Any]()
    var currentUserKey = String()
    var cartOfUser = [String:Any]()

    var productOfUser = [String:Any]()
    var productsKeys = [String]()
    
    var didAddCart = false
    
    struct user {
            var username: String
            var email: String
            var password: String
            var storerole: String
            var icon: String
            var following_store_id : String
            var descriptions : String
        //  var bannerData : String
            var timestamp: Double
            
        func iconToData (icon:String) -> Data? {
            let iconData = Base64ToIamge(base64String: icon)
            return iconData.toImageData()
        }
    }
    
    struct Product {
        var name : String
        var price : Int
        var amount : Int
        var descriptionShort : String
        var descriptionLong : String
        var picture : String
        var storeID : String
        var timestamp : Double
        
    }
    
    struct Cart {
        var user_id  : String
        var product_id : String
        var spec : String
        var grind : String
        var amount : Int
        var timestamp : Double
        
        func  cartStructToDict(completition: @escaping ([String:Any]) -> Void) {
            let dict: [String:Any] = [
                "user_id" :user_id,
                "product_id" : product_id,
                "spec" : spec,
                "grund" : grind,
                "amount" : amount,
                "timeStamp" : timestamp
            ]
            completition(dict)
        }
    }
    
    func dictToUserStruct(from dict:[String:Any], completion: @escaping (user) -> Void) {
        if let username = dict["username"] as? String,
           let email = dict["email"] as? String,
           let password = dict["password"] as? String,
           let storerole = dict["storerole"] as? String,
           let icon = dict["icon"] as? String,
           let following_store_id = dict["following_store_id"] as? String,
           let descriptions = dict["descriptions"] as? String,
           let timestamp = dict["timestamp"] as? Double
        {
            let user = user(username: username, email: email, password: password, storerole: storerole, icon: icon, following_store_id: following_store_id, descriptions: descriptions, timestamp: timestamp)
            completion(user)
        } else {
            print("轉換失敗")
        }
    }
    
    func dictToProductStruct(from dict:[String: Any], completion: @escaping (Product) -> Void ){
        if let name = dict["name"] as? String,
           let price = dict["price"] as? Int,
           let amount = dict["amount"] as? Int,
           let descriptionShort = dict["descriptionShort"] as? String,
           let descriptionLong = dict["descriptionLong"] as? String,
           let picture = dict["picture"] as? String,
           let storeID = dict["storeID"] as? String,
           let timestamp = dict["timestamp"] as? Double
           {
            let product = Product(name: name, price: price, amount: amount, descriptionShort: descriptionShort, descriptionLong: descriptionLong, picture: picture, storeID: storeID, timestamp: timestamp)
                    completion(product)
        } else{
            //        return nil // 如果数据不完整或类型不匹配，返回nil
            print("轉換struct失敗")
        }
    }
    
    struct Base64ToIamge {
        let base64String: String  // Base64 格式的图像数据的字符串

        // 将 Base64 字符串转换为 Data 类型的方法
        func toImageData() -> Data? {
            if let data = Data(base64Encoded: base64String) {
                return data
            }
            return nil
        }
    }
    
    struct ImagetoBase64 {
        let Image:UIImage // Data格式
        
        func toImageBase64() -> String? {
            if let jpegData = Image.jpegData(compressionQuality: 0.5){
                let base64String = jpegData.base64EncodedString()
                return base64String
            }
            return nil
        }
        
    }
    
    
}

