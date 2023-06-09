

import UIKit



class BaseVC : UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("BaseVC - viewWillAppear ")

        //인증 실패 노티피케이션 등록
        NotificationCenter.default.addObserver(self, selector: #selector(showErrorPopup(notification:)), name: NSNotification.Name(rawValue: NOTIFICATION.API.AUTH_FAIL), object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //인증 실패 노티피케이션 등록 해제
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: NOTIFICATION.API.AUTH_FAIL), object: nil)
    }
    
    //MARK : - objc methods
    
    @objc func showErrorPopup(notification: NSNotification){
        print("BaseVC - showErrorPopUp()")
        
        if let data = notification.userInfo?["statusCode"]{//statusCode라는 이름으로 데이터가 있다면
            print("showErrorPopup() data: \(data)")
            
            //메인쓰레드에서 돌리기 즉 UI 스레드
            DispatchQueue.main.async{
                self.view.makeToast("\(data) 에러 입니다 ", duration: 1.5, position: .center)
            }
           
        }
        
    }
    
}


