//
//  RegisterViewController.swift
//  StackPratice
//
//  Created by 최희진 on 2023/04/02.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var btnLoginView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    @IBAction func onLoginViewBtnClicked(_ sender: UIButton) {
        print(" 로그인 버튼 클릭 ")
        //네비게이션 뷰 컨트롤러 pop한다.
        self.navigationController?.popViewController(animated: true)
    }
    
}
