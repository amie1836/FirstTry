//
//  FirebaseCRUD.swift
//  Mr.GoodBean
//
//  Created by jamie on 2023/9/8.
//

import Foundation
import Firebase
import FirebaseDatabase

class FirebaseCRUD {
    static var shared = FirebaseCRUD()
    private init () {}
    
    //新增
    func createUser(username: String, email: String, database: DatabaseReference ) {
        let ref = database.child("users").childByAutoId()
        let user: [String:Any] = [
            "post": "\(username)",
            "hobby": "\(email)",
            "timestamp": ServerValue.timestamp()
        ]
        
        ref.setValue(user) { (error, _) in
            if let error = error {
                print("Error creating user: \(error)")
            } else {
                print("User created successfully")
            }
        }
    }
    
    //讀取所有資料
    func readUsers(completion: @escaping ([String: Any]) -> Void) {
        let ref = Database.database().reference().child("users")
        
        ref.observeSingleEvent(of: .value) { (snapshot) in
            if let value = snapshot.value as? [String: Any] {
                completion(value)
            } else {
                completion([:])
            }
        }
    }
    
    // 更新用戶的 email
    func updateUser(userID: String, newEmail: String) {
        let ref = Database.database().reference().child("users").child(userID)
        let updatedData:[String:Any] = [
            "email": newEmail,
            "timestamp": ServerValue.timestamp()
        ]
        
        ref.updateChildValues(updatedData) { (error, _) in
            if let error = error {
                print("Error updating user: \(error)")
            } else {
                print("User updated successfully")
            }
        }
    }
    
    // 刪除用戶
    func deleteUser(userID: String) {
        let ref = Database.database().reference().child("users").child(userID)
        
        ref.removeValue { (error, _) in
            if let error = error {
                print("Error deleting user: \(error)")
            } else {
                print("User deleted successfully")
            }
        }
    }
    
    // 刪除購物車
    func deletCart() {
        let ref =
        Database.database().reference().child("carts")
        
        ref.removeValue { error, _ in
            if let error = error {
                print("Error deleting carts: \(error)")
            } else {
                print("Carts deleted successfully")
            }
        }
    }


   // 查詢
    func query(child1:String, childForSearch:String, Equal:String, completion: @escaping ([String: Any]) -> Void)  {
        Database.database().reference().child(child1).queryOrdered(byChild: childForSearch).queryEqual(toValue: Equal).observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                if let data = snapshot.value as? [String: Any] {
                    // 处理数据
                    completion(data)
                } else {
                    completion([:])
            }
            } else {
                // 数据不存在
                print("未找到特定数据")
            }
        }
        
    }
    
    
}
