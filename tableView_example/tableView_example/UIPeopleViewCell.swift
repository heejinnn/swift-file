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
    
    var cellIndex : Int = 0 

    var likeBtnAction : ((Bool) -> Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func onLikeBtnClicked(_ sender: UIButton) {
        likeBtnAction?(likeBtn.isActivated)
        //print(cellIndex)
    }
    
    func updateUI(with data : Feed){
        print("UIPeopleViewCell - updateUI()")
        likeBtn.setState(data.isLike)
        peopleName.text = data.name
        cellIndex = data.id
    }

}
