//
//  ViewController.swift
//  tableView_example
//
//  Created by 최희진 on 2023/06/04.
//

import UIKit

class Feed {
    let name : String
    var id : Int
    var isLike : Bool
    
    init (name: String , id : Int, isLike : Bool){
        self.name = name
        self.id = id
        self.isLike = isLike
    }
    
}

class ViewController: UIViewController {

    @IBOutlet weak var peopleTableView: UITableView!
    @IBOutlet weak var dataTextField: UITextField!
    @IBOutlet weak var addBtn: UIButton!
    
    var nameArray = [Feed(name: "나야나", id: 0, isLike: false), Feed(name: "스위프트" , id: 1, isLike: false)]
    var filterData = [Feed]()
    var filtered = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        peopleTableView.dataSource = self
        peopleTableView.delegate = self
        dataTextField.delegate = self
        
        self.dataTextField.addTarget(self, action: #selector(textFieldDidChanacge), for: .editingChanged)
     
        setup()
    }
    
    @objc func textFieldDidChanacge() {
        let textCount = dataTextField.text?.count //textField의 글자수를 저장
        if(textCount == 0){//textField이 빈값인 경우
            filtered = false
            filterData.removeAll()
            peopleTableView.reloadData()
        }
        
    }
    
    func setup(){
        dataTextField.placeholder = "이름을 입력하시오"
        dataTextField.borderStyle = .roundedRect
        dataTextField.clearButtonMode = .always // 전체 삭제버튼
        dataTextField.returnKeyType = .next // 키보드의 return버튼 next로 바꾸기
    }
    
    //테이블 뷰 데이터 추가 액션
    @IBAction func addBtnClicked(_ sender: UIButton) {
        nameArray.append(contentsOf: [Feed(name: dataTextField.text!, id: nameArray.count, isLike: false)])
        peopleTableView.reloadData()
    }
    
}

//MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate{
    
    //키보드 리턴 or 엔터 키
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

           if textField == self.dataTextField {
               if let text = dataTextField.text{
                   
                   if !textField.text!.trimmingCharacters(in: .whitespaces).isEmpty { // 공백 아닌 문자열이 있을 경우
                       filterText(text)
                   }
               }
           }
           dataTextField.endEditing(true) //키패드 닫기
        
           return true

    }
    
    //textField에 공백 아닌 문자열이 있는 경우
    func filterText(_ query : String){
        filterData.removeAll()//중복 제거
        
        //입력된 text가 nameArray의 name과 일치한다면 filterData에 추가
        
        //nameArray 배열 내 원소 순회
        for array in nameArray{
            if array.name.lowercased().starts(with: query.lowercased()){
                //nameArray 배열의 앞에서부터 조회해서 일치하는 index 반환
                guard let index = nameArray.firstIndex(where: { $0.name == array.name}) else { return }
                filterData.append(contentsOf: [Feed(name: array.name, id: index, isLike: array.isLike)])
            }
        }
       
        peopleTableView.reloadData()
        filtered = true
    }
            
}

//MARK: - UITableView DataSource/Delegate
extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = peopleTableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath) as!UIPeopleViewCell
   
        if filterData.count != 0{//검색한 내용이 있다면
            
            if self.filterData.count > 0 {
                let namesData = filterData[indexPath.row]
                cell.updateUI(with: namesData)
            }
            
            cell.likeBtnAction = { [weak self] currentBtnState in
                guard let self = self else { return }
                self.nameArray[self.filterData[indexPath.row].id].isLike = !currentBtnState
           
            }
        }
        
        else {
            
            if self.nameArray.count > 0 {
                let nameData = nameArray[indexPath.row]
                nameData.id = indexPath.row  //id 수정
                cell.updateUI(with: nameData)
            }

            cell.likeBtnAction = { [weak self] currentBtnState in
                guard let self = self else { return }
                self.nameArray[indexPath.row].isLike = !currentBtnState
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if filterData.count != 0 {
            return filterData.count
        }
        
        return filtered ? 0 :  nameArray.count
    }
    
    //테이블 뷰 셀 스와이프 액션(오른쪽)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //삭제 버튼 구현
        let delete = UIContextualAction(style: .normal, title: "Delete") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
                
                self.nameArray.remove(at: indexPath.row)//해당 index 배열에서 삭제
                self.peopleTableView.deleteRows(at: [indexPath], with: .automatic)
                self.peopleTableView.reloadData()
            
                success(true)
        }
        delete.backgroundColor = .systemRed
            
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
