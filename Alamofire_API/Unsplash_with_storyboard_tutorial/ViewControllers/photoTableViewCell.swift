//
//  photoTableViewCell.swift
//  Unsplash_with_storyboard_tutorial
//
//  Created by 최희진 on 2023/06/18.
//

import UIKit

class photoTableViewCell: UITableViewCell {

    @IBOutlet weak var photoName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
