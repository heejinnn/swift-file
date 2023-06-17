//
//  ViewController.swift
//  Unsplash_with_storyboard_tutorial
//
//  Created by 최희진 on 2023/04/14.
//

import UIKit
import Toast_Swift
import Alamofire

class HomeVC: BaseVC, UISearchBarDelegate, UIGestureRecognizerDelegate{

    @IBOutlet weak var searchIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchFilterSegment: UISegmentedControl!
    
    var keyboardDismissTabGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: HomeVC.self, action: nil)
   
    //MARK: - override method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("HomeVC - viewDidLoad() called")
        
        //ui 설정
        self.searchBtn.layer.cornerRadius = 10
        self.searchBar.searchBarStyle = .minimal
        
        //delegate 연결을 해줘야 함
        self.searchBar.delegate = self
        
        //delegate 연결
        self.keyboardDismissTabGesture.delegate = self
        //제스처 추가하기
        self.view.addGestureRecognizer(keyboardDismissTabGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //포커싱 주기
        self.searchBar.becomeFirstResponder()
    }
    
    //화면이 넘어가기 전에 준비
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("HomeVC - prepare() called")
        switch segue.identifier{
            
        case SEGUE_ID.USER_LIST_VC:
            //다음 화면의 뷰컨트롤러 가져온다
            let nextUserListVC = segue.destination as! UserListVC
            guard let userInputValue = self.searchBar.text else {return}
            nextUserListVC.vcTitle = userInputValue + "🤪"
            
        case SEGUE_ID.PHOTO_COLLECTION_VC:
            let nextPhotoCollectionVC = segue.destination as! PhotoCollectionVC
            guard let PhotoInputValue = self.searchBar.text else {return}
            nextPhotoCollectionVC.vcTitle = PhotoInputValue + "😄"
    
        default:
            print("default")
        }
    }
    
    //view가 appear가 될때
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("HomeVC - viewWillAppear()")
        //키보드 올라가는 이벤트를 받는 처리
        //키보드 노티 등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowHandle(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideHandle), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("HomeVC - viewWillDisappear()")
        //키보드 노티 해제
        NotificationCenter.default.removeObserver(self,name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self,name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - fileprivate methods
    fileprivate func pushVC(){
        var segueId : String = ""
        switch searchFilterSegment.selectedSegmentIndex {
        case 0:
            segueId = "PhotoCollectionVC"
            
        case 1:
            segueId = "goToUserListVC"
            
        default:
            segueId = "PhotoCollectionVC"
        }
         
        //화면이동
        self.performSegue(withIdentifier: segueId, sender: self)
        
    }
    
    @objc func keyboardWillShowHandle(notification: NSNotification){
        print("HomeVC - keyboardWillShowHandle()")
        
        //키보드 사이즈 가져오기
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print("keyboardSize : \(keyboardSize.height)")
            print("searchBtn.frame.origin.y : \(searchBtn.frame.origin.y)")
            
            if(keyboardSize.height < searchBtn.frame.origin.y){
                //키보드가 우리가 원하는 뷰를 가렸을 때
                print("키보드가 버튼을 덮었다")
                let distance = keyboardSize.height - searchBtn.frame.origin.y
                self.view.frame.origin.y = distance - searchBtn.frame.height
            }
        }
    }
    
    @objc func keyboardWillHideHandle(){
        print("HomeVC - keyboardWillHideHandle()")
        //원래 상태로
        self.view.frame.origin.y = 0
        
    }
    
    //MARK: - IBAction method
    @IBAction func searchFilterValueChanged(_ sender: UISegmentedControl) {
        print("HomeVC - searchFilterValueChanged() called")
        
        var searchBarTitle = ""
        switch sender.selectedSegmentIndex{
        case 0:
            searchBarTitle = "사진 키워드"
        case 1:
            searchBarTitle = "사용자 이름"
        default:
            searchBarTitle = "사진 키워드"
        }
        self.searchBar.placeholder = searchBarTitle + "입력"
        
        //키보드 포커싱 주기
        self.searchBar.becomeFirstResponder()
    }
    
    @IBAction func onSearchBtnClicked(_ sender: UIButton) {
        print("HomeVC - onSearchBtnClicked() called")
        
        //af로 url에 요청을 하고 response 받기

        guard let userInput = self.searchBar.text else {return}
        
       // var urlToCall : URLRequestConvertible?
        
        switch searchFilterSegment.selectedSegmentIndex{
        case 0:
            //urlToCall = MySearchRouter.searchPhotos(term: userInput)
            MyAlamofireManager
                .shared
                .getPhotos(searchTerm: userInput, Completion: {[weak self] result in
                    
                    //ARC(자동 메모리 사용 수 계산)
                    //메모리를 많이 사용하면 자동으로 기존 메모리를 삭제
                    //self는 메모리 카운트를 증가
                    //weak self를 사용해 메모리를 가지고 있는 것을 방지
                    // 다음과 같이 self.메소드등 self를 사용해야 하는 경우 weak self로 메모리에 계속 잡아두고 있는 것을 방지
                    
                    guard let self = self else{return}
                    
                    switch result {
                    case .success(let fetchedPhotos):
                        print("dsds")
                        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "PhotoCollectionVC") as? PhotoCollectionVC else {return}
                        nextVC.photosDataArr = fetchedPhotos
                        nextVC.vcTitle = userInput + "😄"
                        nextVC.modalPresentationStyle = .fullScreen
                        self.navigationController?.pushViewController(nextVC, animated: true)
                        
                    case .failure(let error):
                        print("HomeVC - getPhotos.failure - error : \(error.rawValue)")//enum 타입에서 값을 가져올 때 rawValue
                    }
                })
            
        case 1:
            print("dd")
           // urlToCall = MySearchRouter.searchUsers(term: userInput)
            
        default:
            print("default")
        }
            
        
    }
    
    //MARK: - UISearchBar Delegate methods
    //SearchBar에 입력시 감지
    
    //searchBar에서 search 버튼 클릭시
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("HomeVC - searchBarSearchButtonClicked()")
        
        guard let userInputString = searchBar.text else{return}
        
        if userInputString.isEmpty{
            self.view.makeToast("📣 검색 키워드를 입력해주세요 ", duration: 1.5, position: .center)
        }
        else{
            //pushVC()
            searchBar.resignFirstResponder()
        }
    }
    
    //사용자가 검색 텍스트를 변경한 경우
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("HomeVC - searchBarDidChange()")
        
        //사용자가 입력한 값이 없을 때
        if(searchText.isEmpty){
            self.searchBtn.isHidden = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                //서치바의 x 눌렀을 때 포커싱 해제
                searchBar.resignFirstResponder()
            })
            
        }
        else{
            self.searchBtn.isHidden = false
        }
    }
    
    //검색 텍스트를 지정된 텍스트로 변경하는 경우
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        //값이 비어있다면 0
        let inputTextCount = searchBar.text?.appending(text).count ?? 0
        
        if(inputTextCount >= 12){
            //컨트롤 + 커맨드 + 스페이스 : 이모티콘 창
            self.view.makeToast("📢 12자 까지만 입력가능합니다. ", duration: 1.5, position: .center)
        }

        return inputTextCount <= 12
    }
    
    //MARK: - UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        print("HomeVC - gestureRecognizer shouldReceive() ")
        //터치로 들어온 뷰에 따라 return 값
        if(touch.view?.isDescendant(of: searchFilterSegment) == true){
            print("세그먼트 터치")
            return false
        }
        else if(touch.view?.isDescendant(of: searchBar) == true){
            print("서치바 터치")
            return false
        }
        else{
            print("화면 터치")
            //키보드가 내려가게 함.
            view.endEditing(true)
            return true
        }
    }
    
    
}

