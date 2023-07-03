//
//  ViewController.swift
//  LifeCycle
//
//  Created by 최희진 on 2023/05/18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ClickBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("1st - viewDidLoad()")
    }
    override func viewWillAppear(_ animated: Bool) {
        print("1st - viewWillAppear")
    }
    override func viewDidAppear(_ animated: Bool) {
        print("1st - viewDidAppear")
        print("===================")
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("1st - viewWillDisappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("1st - viewDidDisappear")
    }

    @IBAction func onClickBtnClicked(_ sender: UIButton) {
        
    }
    
}

