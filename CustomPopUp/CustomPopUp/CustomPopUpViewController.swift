//
//  CustomPopUpViewController.swift
//  CustomPopUp
//
//  Created by 최희진 on 2023/04/03.
//

import UIKit

class CustomPopUpViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var bgBtn: UIButton!
    @IBOutlet weak var subscribeBtn: UIButton!
    @IBOutlet weak var openNaverBtn: UIButton!
    @IBOutlet weak var openBlogBtn: UIButton!
    var myPopUpDelegete : PopUpDelegate?
    
    var subscribeBtnCompletionClosure: (() -> Void)?

    
    override func viewDidLoad(){
        super.viewDidLoad()
        print("호출")
        contentView.layer.cornerRadius = 30 //모서리 둥글
        subscribeBtn.layer.cornerRadius = 10
        openNaverBtn.layer.cornerRadius = 10
        openBlogBtn.layer.cornerRadius = 10
    }
    
    //MARK: -IBAction
    //가이드라인에서 찾기 편함
    
    @IBAction func onBgBtnClicked(_ sender: UIButton) {
        print("bgBtn 클릭")
        self.dismiss(animated: true, completion: nil)//현재 창 닫기
    }
    
    @IBAction func onSubscribeBtnClicked(_ sender: UIButton) {
        print("SubBtn 클릭")
        
        self.dismiss(animated: true, completion: nil)
        
        //컴플레션 블럭 호출
        if let subscribeBtnCompletionClosure = subscribeBtnCompletionClosure{
            //메인에 알린다.
            subscribeBtnCompletionClosure()
        }
    }
    
    @IBAction func onOpenNaverBtnClicked(_ sender: UIButton) {
        print("CustomPopUpViewController : openNaverBtn 클릭")
        self.dismiss(animated: true, completion: nil)
        //이벤트를 눌러 ViewController에서 수신하게 된다.
        myPopUpDelegete?.onOpenNaverBtnClicked()
    }
    
    @IBAction func onBlogBtnClicked(_ sender: UIButton) {
        print("CustomPopUpViewController : onBlogBtnClicked() ")
        NotificationCenter.default.post(name: Notification.Name(rawValue: notificationName), object: nil)
        dismiss(animated: true, completion: nil)
    }
}
