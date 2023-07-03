//
//  SecondViewController.swift
//  LifeCycle
//
//  Created by 최희진 on 2023/05/18.
//

import UIKit

class SecondViewController: UIViewController{
    override func viewDidLoad() {
        print("2nd - viewDidLoad()")
    }
    override func viewWillAppear(_ animated: Bool) {
        print("2nd - viewWillAppear")
    }
    override func viewDidAppear(_ animated: Bool) {
        print("2nd - viewDidAppear")
        print("===================")
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("2nd - viewWillDisappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("2nd - viewDidDisappear")
    }
}
