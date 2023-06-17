//
//  PhotoCollectionVC.swift
//  Unsplash_with_storyboard_tutorial
//
//  Created by 최희진 on 2023/04/14.
//

import UIKit

class PhotoCollectionVC : BaseVC {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoTableView.register(UINib(nibName:"photoTableViewCell",bundle: nil), forCellReuseIdentifier: "photoTableViewCell")
        
        print("PhotoCollectionVC - viewDidLoad() called")
    }
}

