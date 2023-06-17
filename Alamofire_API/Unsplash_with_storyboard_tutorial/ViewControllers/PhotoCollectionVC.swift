//
//  PhotoCollectionVC.swift
//  Unsplash_with_storyboard_tutorial
//
//  Created by 최희진 on 2023/04/14.
//

import UIKit

class PhotoCollectionVC : UIViewController {
    
    var vcTitle : String = "" {
        didSet{
            print("PhotoCollectionVC - vcTitle didSet()")
            self.title = vcTitle
        }
    }
    
    var photosDataArr = [Photo]()
   
    
    @IBOutlet weak var photoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoTableView.register(UINib(nibName:"photoTableViewCell",bundle: nil), forCellReuseIdentifier: "photoTableViewCell")
        print("PhotoCollectionVC - viewDidLoad() called")
    }
}
extension PhotoCollectionVC : UITableViewDelegate, UITableViewDataSource{
    
    //tableView cell의 object
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print(photosDataArr.count)
        let cell = photoTableView.dequeueReusableCell(withIdentifier: "photoTableViewCell", for: indexPath) as!photoTableViewCell
        
        cell.photoName.text = self.photosDataArr[indexPath.row].username
                
        return cell
    }
    
    //tableView item 개수
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosDataArr.count;
    }
}

