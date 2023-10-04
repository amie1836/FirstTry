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
    private init(){
    }
    var currentUser = [String:Any]()
    var productOfUser = [String:Any]()
    var userKey = String()
    var productsKeys = [String]()
//    struct user {
//            var username: String
//            var email: String
//            var password: String
//            var storerole: Bool
//            var icon: String
//            var following_store_id : Int
//            var timestamp: Double
//            
//        func iconToData () -> Data? {
//            let iconData = ImageBase64(base64String: icon)
//            return iconData.toImageData()
//        }
//    }
    
    struct product {
        
    }
    
    struct ImageBase64 {
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

