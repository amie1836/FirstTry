//
//  Login.swift
//  Mr.GoodBean
//
//  Created by jamie on 2023/9/12.
//

import Foundation
import Firebase

class Login {
    // 註冊新帳號
    func registerUser(username: String, email: String, password: String) {
        let ref = Database.database().reference().child("users")
        let user = [
            "username": username,
            "email": email,
            "password": password // 不建議在實際應用中存儲密碼明文
        ]
        
        let userID = UUID().uuidString // 生成一個唯一的用戶 ID，這只是示例
        ref.child(userID).setValue(user) { (error, _) in
            if let error = error {
                print("Error registering user: \(error)")
            } else {
                print("User registered successfully")
            }
        }
    }

    // 登錄帳號
    func loginUser(email: String, password: String) {
        let ref = Database.database().reference().child("users")
        
        ref.queryOrdered(byChild: "email").queryEqual(toValue: email).observeSingleEvent(of: .value) { (snapshot) in
            if let userDict = snapshot.value as? [String: Any],
               let storedPassword = userDict["password"] as? String {
                if storedPassword == password {
                    print("User logged in successfully")
                } else {
                    print("Invalid password")
                }
            } else {
                print("User not found")
            }
        }
    }

}
