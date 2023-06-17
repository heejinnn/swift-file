//
//  UserListVC.swift
//  Unsplash_with_storyboard_tutorial
//
//  Created by 최희진 on 2023/04/14.
//

import UIKit

class UserListVC : BaseVC  {
    
    @IBOutlet weak var userListLabel: UILabel!
    
//    var userData : String = "" {
//        didSet{
//            print("UserListVC - vcTitle didSet()")
//            self.userListLabel.text = userData
//        }
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("UserListVC - viewDidLoad() called")
    }
}
