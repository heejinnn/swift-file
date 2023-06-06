//
//  UIPeopleViewCell.swift
//  tableView_example
//
//  Created by 최희진 on 2023/06/04.
//

import UIKit

class UIPeopleViewCell: UITableViewCell {

    @IBOutlet weak var peopleName: UILabel!
    @IBOutlet weak var likeBtn: MyLikeBtn!
    

    var likeBtnAction : ((Bool) -> Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func onLikeBtnClicked(_ sender: UIButton) {
        print("heart 버튼")
        likeBtnAction?(likeBtn.isActivated)
    }
    
    func updateUI(with data : Feed){
        likeBtn.setState(data.isLike)
        peopleName.text = data.name
    }
    

}
