//
//  ViewController.swift
//  pagerView_tutorial
//
//  Created by 최희진 on 2023/04/14.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchTextInput: UITextField!
    @IBOutlet weak var searchControl: UISegmentedControl!
    @IBOutlet weak var titleImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchTextInput.layer.cornerRadius = 10
        
    }
    


}

