//
//  PurchaseVC.swift
//  Mr.GoodBean
//
//  Created by jamie on 2023/9/21.
//

import UIKit

class PurchaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 50
        preferredContentSize = CGSize(width: 393, height: 90)
        
        
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 393, height: 200))
                customView.backgroundColor = UIColor.blue
                self.view.addSubview(customView)
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
