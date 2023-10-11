//
//  StoryListCellTableViewCell.swift
//  Mr.GoodBean
//
//  Created by jamie on 2023/10/11.
//

import UIKit

class StoryListCellTableViewCell: UITableViewCell {
    @IBOutlet weak var StoreBannerImageView: UIImageView!
    @IBOutlet weak var StoreIconImageVIew: UIImageView!
    @IBOutlet weak var StoreNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        StoreIconImageVIew.layer.cornerRadius = 39
        StoreBannerImageView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
