//
//  UserListVC.swift
//  Unsplash_with_storyboard_tutorial
//
//  Created by 최희진 on 2023/04/14.
//

import UIKit

class UserListVC : UIViewController  {
    
    @IBOutlet weak var userTableView: UITableView!
    
    var vcTitle : String = "" {
        didSet{
            print("UserListVC - vcTitle didSet()")
            self.title = vcTitle
        }
    }
    
    var userDataArr = [User]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("UserListVC - viewDidLoad() called")
        
        userTableView.register(UINib(nibName:"userTableViewCell",bundle: nil), forCellReuseIdentifier: "userTableViewCell")
        print("PhotoCollectionVC - viewDidLoad() called")
    }
}

extension UserListVC : UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableView.dequeueReusableCell(withIdentifier: "userTableViewCell", for: indexPath)as!userTableViewCell
        
        cell.userIDLabel.text = self.userDataArr[indexPath.row].id
        
        return cell
        
        
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDataArr.count;
    }
}
