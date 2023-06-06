//
//  MyLikeBtn.swift
//  tableView_example
//
//  Created by 최희진 on 2023/06/04.
//

import Foundation
import UIKit

class MyLikeBtn : UIButton {
    var isActivated : Bool = false
    let activatedImage = UIImage(systemName: "heart.fill")?.withTintColor(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)).withRenderingMode(.alwaysOriginal)
    let normalImage = UIImage(systemName: "heart")?.withTintColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)).withRenderingMode(.alwaysOriginal)

   
    override func awakeFromNib() {
        super.awakeFromNib()
        print("MyLikeBtn - awakeFromNib() called")
        configureAction()
    }
    
    func setState(_ newValue : Bool){
        print("MyLikeBtn - setState() called")
        
        //1. 현재 버튼의 상태 변경
        self.isActivated = newValue
        
        self.setImage(self.isActivated ? activatedImage : normalImage, for: .normal ) //normal은 일반적인 버튼 상태일때
        
    }
    fileprivate func configureAction(){
            print("MyHeartBtn - configureAction() called")
            self.addTarget(self, action: #selector(onBtnClicked(_:)), for: .touchUpInside)
    }
    @objc fileprivate func onBtnClicked(_ sender: UIButton){
            print("MyHeartBtn - onBtnClicked() called")
            self.isActivated.toggle()
        setState(self.isActivated)//다시 새로고침
    }
}
