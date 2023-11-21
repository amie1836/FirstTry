//
//  UserDetailVC.swift
//  Mr.GoodBean
//
//  Created by jamie on 2023/10/11.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseDatabase

class UserDetailVC: UIViewController,UITabBarControllerDelegate {
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var cartBtn: UIButton!
    
    @IBOutlet weak var cartCollectionView: UICollectionView!
    
    // 資料
    let ref = Database.database().reference()
    var cartOfUser = DataFromFireBase.shared.cartOfUser
    var currentUser = DataFromFireBase.shared.currentUser
    var totalCost = Int()
    var productIDArray = [String]()
    var productImageArray = [UIImage]()
    
    // 切換回來時重新載入資料
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if DataFromFireBase.shared.didAddCart == true {
            
            totalCost = 0
            productIDArray = [String]()
            
            FirebaseCRUD.shared.query(child1: "carts", childForSearch: "user_id", Equal: DataFromFireBase.shared.currentUserKey) { [self] dict in
                
                DataFromFireBase.shared.cartOfUser = dict
                cartOfUser = dict
                
                guard let cartValueArray = cartOfUser.values.map({ $0
                }) as? [[String:Any]] else {
                    return
                }
                
                
                
                for i in 0...cartValueArray.count - 1 {
                    let singleCartDict = cartValueArray[i]
                    if let amount = singleCartDict["amount"] as? Int,
                       let productID = singleCartDict["product_id"] as? String
                    {
                        ref.child("products").child(productID).observeSingleEvent(of: .value) { (snapshot) in
                            guard let snapShot = snapshot.value as? [String:Any] else {
                                assertionFailure("資料結構有誤")
                                return
                            }
                            guard let price = snapShot["price"] as? Int else {
                                assertionFailure("資料內容有誤")
                                return
                            }
                            self.totalCost += amount * price
                            self.totalLabel.text = "NT$\(self.totalCost)"
                        }
                        //                amountArray.append(amount)
                        self.productIDArray.append(productID)
                        self.cartCollectionView.reloadData()
                    }
                }
            }
            DataFromFireBase.shared.didAddCart = false
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalLabel.text = "NT$0"
        
        if let userIconBase64 = currentUser["icon"] as? String,
           let userName = currentUser["username"] as? String
        {   let ImageStruct =  DataFromFireBase.Base64ToIamge(base64String: userIconBase64)
            if let userIconData = ImageStruct.toImageData() {
                photoImageView.contentMode = .scaleAspectFill
                photoImageView.layer.cornerRadius = 72.5
                photoImageView.image = UIImage(data:userIconData )
                photoImageView.image = UIImage(named: "Genshin_activate.jpeg")
            }
            nameLabel.text = userName
            nameLabel.text = "我愛原神"
        }
        
        guard let cartValueArray = cartOfUser.values.map({ $0
        }) as? [[String:Any]] else {
            return
        }
        
//        var amountArray = [Int]()
//        var productIDArray = [""]
        if cartValueArray.count > 0 {
            for i in 0...cartValueArray.count - 1 {
                let singleCartDict = cartValueArray[i]
                if let amount = singleCartDict["amount"] as? Int,
                   let productID = singleCartDict["product_id"] as? String
                {
                    ref.child("products").child(productID).observeSingleEvent(of: .value) { (snapshot) in
                        guard let snapShot = snapshot.value as? [String:Any] else {
                            assertionFailure("資料結構有誤")
                            return
                        }
                        guard let price = snapShot["price"] as? Int else {
                            assertionFailure("資料內容有誤")
                            return
                        }
                        self.totalCost += amount * price
                        self.totalLabel.text = "NT$\(self.totalCost)"
                    }
                    //                amountArray.append(amount)
                    productIDArray.append(productID)
                }
            }
        }
        cartCollectionView.dataSource = self
        cartCollectionView.delegate = self
        cartCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        

//        if let collectionViewLayout = cartCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            collectionViewLayout.scrollDirection = .horizontal
//        }

        
        // Do any additional setup after loading
//        totalLabel.text = "NT$\(totalCost)"
//        for i in 0...productIDArray.count - 1 {
//            ref.child("products").child(productIDArray[i]).observeSingleEvent(of: .value) { snapshot in
//                guard let dict = snapshot.value as? [String:Any] else {
//                    assertionFailure("資料下載錯誤")
//                    return
//                }
//                guard let photoBase64 =  dict["picture"] as? String else
//                {
//                    assertionFailure("資料格式錯誤")
//                    return
//                }
//                let photoToData = DataFromFireBase.Base64ToIamge(base64String: photoBase64)
//                if let data = photoToData.toImageData() {
//                    self.photoImageView.image = UIImage(data: data)
//                }
//            }
//        }
        
        //NotificationCenter
//        NotificationCenter.default.addObserver(self, selector: #selector(downloadCartImage), name: Notification.Name("CartAdd"), object: nil)
    }
    
//    func downloadData(completion: @escaping () -> Void) {
//        // 模拟下载过程，这里可以替换为您的实际下载代码
//
//        DispatchQueue.global().async {
//            // 模拟下载操作，等待2秒
//            sleep(2)
//            // 下载完成后执行闭包
//            completion()
//        }
//    }
    
    @IBAction func cartBtnPressed(_ sender: Any) {
        productIDArray = [String]()
        totalLabel.text = "NT$0"
        cartCollectionView.reloadData()
        
        FirebaseCRUD.shared.deletCart()
        
    }
    
//    @objc func downloadCartImage() {
//
//        for i in 0...productIDArray.count - 1 {
//            ref.child("products").child(productIDArray[i]).observeSingleEvent(of: .value) { (snapshot,_) in
//                guard let dict = snapshot.value as? [String:Any] else {
//                    assertionFailure("資料下載錯誤")
//                    return
//                }
//                guard let photoBase64 =  dict["picture"] as? String else
//                {
//                    assertionFailure("資料格式錯誤")
//                    return
//                }
//                let photoToData = DataFromFireBase.Base64ToIamge(base64String: photoBase64)
//                if let data = photoToData.toImageData() {
//                   // photoImageView.image = UIImage(data: data)
//                    self.productImageArray.append(UIImage(data:data)!)
//                }
//            }
//        }
//
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

extension UserDetailVC: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productIDArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        var photoImageView = UIImageView(frame: cell.contentView.bounds)
        if let existingImageView = cell.contentView.viewWithTag(100) as? UIImageView {
                photoImageView = existingImageView
            } else {
                photoImageView = UIImageView(frame: cell.contentView.bounds)
                photoImageView.tag = 100
                cell.contentView.addSubview(photoImageView)
            }
        
        
        ref.child("products").child(productIDArray[indexPath.row]).observeSingleEvent(of: .value) { snapshot in
                guard let dict = snapshot.value as? [String:Any] else {
                    assertionFailure("資料下載錯誤")
                    return
                }
                guard let photoBase64 =  dict["picture"] as? String else
                {
                    assertionFailure("資料格式錯誤")
                    return
                }
                let photoToData = DataFromFireBase.Base64ToIamge(base64String: photoBase64)
                if let data = photoToData.toImageData() {
                    photoImageView.image = UIImage(data: data)
                   
                }
             
            }
        
//        photoImageView.image = productImageArray[indexPath.row]
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var view: UICollectionReusableView!
        
        if kind == UICollectionView.elementKindSectionHeader {
            view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
            
            let label = view.viewWithTag(100) as! UILabel
            label.text = "購物車內容"
        }
        return view
    }
}
