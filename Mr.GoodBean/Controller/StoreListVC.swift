//
//  StoreListVC.swift
//  Mr.GoodBean
//
//  Created by jamie on 2023/10/11.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseDatabase

class StoreListVC: UITableViewController {

    var allStoreID = DataFromFireBase.shared.allStoreID
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "StoryListCellTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "StoreListCell")
        //self.view.addSubview(tableView)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return  1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allStoreID.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreListCell", for: indexPath) as! StoryListCellTableViewCell

        // Configure the cell...
        let didSelectedStore = allStoreID[indexPath.row]
       // let ref = Database.database().reference()
//        if let dict = DataFromFireBase.shared.allStoreDataDict[didSelectedStore] as? [String:Any] {
//            DataFromFireBase.shared.loadingUserDataDict = dict
//        }
        guard let selectedUserDict = DataFromFireBase.shared.allStoreDataDict["\(didSelectedStore)"] as? [String:Any] else {
            assertionFailure("***轉檔失敗***")
            return cell
        }
        DataFromFireBase.shared.dictToUserStruct(from: selectedUserDict) { userDataStruct in
            cell.StoreBannerImageView.image = UIImage(named: "white_cat_and_dog.jpg")
            if let data = userDataStruct.iconToData(icon: userDataStruct.icon) {
                cell.StoreIconImageVIew.image = UIImage(data: data)
            }
            cell.StoreNameLabel.text = userDataStruct.username
        }
        
        //cell.StoreBannerImageView =

        return cell
    }
 
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
