//
//  ViewController.swift
//  CustomPopUp
//
//  Created by 최희진 on 2023/04/03.
//

import UIKit
import WebKit

let notificationName = "btnClickNotification"

class ViewController: UIViewController, PopUpDelegate{
    
    @IBOutlet weak var myWebView: WKWebView!
    
    @IBOutlet weak var createPopUpBtn: UIButton!
    
    //ViewController가 메모리에서 해제가 될 때
    deinit{
        NotificationCenter.default.removeObserver(self)
        //메모리에서 노티피케이션 등록 해제
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //노티피케이션이라는 방송 수신기를 장착한다.
        NotificationCenter.default.addObserver(self, selector: #selector(loadWebView), name: NSNotification.Name(rawValue: notificationName),  object: nil)
        //selector는 수신기에서 방송이 들어왔을 때 행하는 액션들
        //object 방송이 되면서 데이터가 전송될 수 있는데 그런 데이터들 값들
        
        //등록 해제를 꼭 해줘야함
    }
    @objc fileprivate func loadWebView(){//@objc 라고 적어야 selector에서 사용 가능
        print("ViewController - loadWebView()")
        let BlogAddress = URL(string: "http://blog.naver.com/")
        self.myWebView.load(URLRequest(url: BlogAddress!))
        
    }

    @IBAction func onCreatePopUpBtnClicked(_ sender: UIButton) {
        print("팝업 버튼 클릭")
        
        //스토리보드 가져오기
        let stortboard = UIStoryboard.init(name: "PopUp", bundle: nil)
        
        //스토리보드를 통해 뷰컨트롤러 가져오기
        let customPopUpVC = stortboard.instantiateViewController(withIdentifier: "AlertPopVC") as! CustomPopUpViewController
        
        //뷰 컨트롤러가 보여지는 스타일
        customPopUpVC.modalPresentationStyle = .overCurrentContext
        
        //뷰 컨트롤러가 사라지는 스타일
        customPopUpVC.modalTransitionStyle = .crossDissolve
        
        customPopUpVC.subscribeBtnCompletionClosure = {
            print("컴플레션 블럭이 호출되었다.")
            let myChannelUrl = URL(string: "https://www.youtube.com/")
            self.myWebView.load(URLRequest(url: myChannelUrl!))
        }
        
        //View Controller와 Delegate 서로 연결해줌.
        customPopUpVC.myPopUpDelegete = self
        //self는 Viewcontroller가 아닌 CustomPopUpViewController의 myPopUpDelegate를 가리키는 거다.
        
        //현재에 있는 뷰 컨트롤러에서 위에서 바로 진행
        self.present(customPopUpVC, animated: true, completion: nil) //alertPopUpVC를 보여줌.
    }
    
    
    //MARK: - PopUpDelegate methods
    func onOpenNaverBtnClicked() {
        print("ViewController - onOpenNaverBtnClicked() called")
        //여기까지는 받는다는 설정을 한 것, 따로 연결을 해줘야함.
        let myChannelUrl = URL(string: "https://www.naver.com/")
        self.myWebView.load(URLRequest(url: myChannelUrl!))
        
    }
    

}

