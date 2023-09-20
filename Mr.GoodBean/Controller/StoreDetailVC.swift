//
//  NewViewController.swift
//  Mr.GoodBean
//
//  Created by jamie on 2023/9/7.
//

import UIKit

class StoreDetailVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var sotreDescribeTextView : UITextView!
    var bannerImageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 設置背景橫幅
                bannerImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 190))
                bannerImageView.image = UIImage(named: "white_cat_and_dog.jpg") // 背景橫幅的圖片
                bannerImageView.contentMode = .scaleAspectFill
                bannerImageView.clipsToBounds = true
                view.addSubview(bannerImageView)
                
                // 設置圓形頭像
                let avatarImageView = UIImageView(frame: CGRect(x: 23, y: 76, width: 90, height: 90))
                avatarImageView.image = UIImage(named: "Genshin_activate.jpeg") // 頭像的圖片
                avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
                avatarImageView.clipsToBounds = true
                view.addSubview(avatarImageView)

        // 加入UITextView
//        NSLayoutConstraint.activate([sotreDescribeTV.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor), sotreDescribeTV.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16)])
               sotreDescribeTextView = UITextView(frame: CGRect(x: 0, y: bannerImageView.frame.maxY, width: view.frame.width, height: 128))
                sotreDescribeTextView.backgroundColor = UIColor.white // 設置背景色
                sotreDescribeTextView.text = "在這裡輸入商家資訊..." // 預設文本
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

    // 實現UICollectionViewDataSource方法
            func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                // 返回商品數量
                //return yourProductArray.count
                return 12
            }

            func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                // 創建和配置UICollectionViewCell
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
                let productImageView = UIImageView(frame: cell.contentView.bounds)
                //productImageView.image = UIImage(named: yourProductArray[indexPath.item])
                productImageView.image = UIImage(named: "women.jpg")
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
    }
   

}
