//
//  userTableViewCell.swift
//  Unsplash_with_storyboard_tutorial
//
//  Created by 최희진 on 2023/06/21.
//

import UIKit

class userTableViewCell: UITableViewCell {

    @IBOutlet weak var userIDLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
