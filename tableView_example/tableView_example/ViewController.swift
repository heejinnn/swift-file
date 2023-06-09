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
    var isLike : Bool = false
    
    init (name: String , id : Int){
        self.name = name
        self.id = id
    }
    
}


class ViewController: UIViewController {

    @IBOutlet weak var peopleTableView: UITableView!
    
    @IBOutlet weak var dataTextField: UITextField!
    @IBOutlet weak var addBtn: UIButton!
    
    var nameArray = [Feed(name: "aaa", id: 0), Feed(name: "bbb" , id: 1)]
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
        let textCount = dataTextField.text?.count //textField 의 글자수를 저장
        if(textCount == 0){
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
    
    
    @IBAction func addBtnClicked(_ sender: UIButton) {
        nameArray.append(contentsOf: [Feed(name: dataTextField.text!, id: nameArray.count)])
        peopleTableView.reloadData()
    }
    
}

extension ViewController: UITextFieldDelegate{
    
    func filterText(_ query : String){
        filterData.removeAll()
        
        for array in nameArray{
            if array.name.lowercased().starts(with: query.lowercased()){
                guard let index = nameArray.firstIndex(where: { $0.name == array.name}) else { return }
                filterData.append(contentsOf: [Feed(name: array.name, id: index)])
            }
        }
       
        peopleTableView.reloadData()
        filtered = true
    }
    
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
            
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = peopleTableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath) as!UIPeopleViewCell
   
        
        print(filterData.count)
        if filterData.count != 0{
            cell.peopleName?.text = filterData[indexPath.row].name
            
            
            if self.filterData.count > 0 {
                let namesData = filterData[indexPath.row]
                cell.updateUI(with: namesData)
            }
            cell.likeBtnAction = { [weak self] currentBtnState in
                       guard let self = self else { return }
                       //
                       self.filterData[indexPath.row].isLike = !currentBtnState
           //            self.myTableView.reloadRows(at: [indexPath], with: .automatic)
            }
            
        }
        else {
            
            cell.peopleName?.text = nameArray[indexPath.row].name
            if self.nameArray.count > 0 {
                let nameData = nameArray[indexPath.row]
                nameData.id = indexPath.row  //id 수정
                cell.updateUI(with: nameData)
            }

            cell.likeBtnAction = { [weak self] currentBtnState in
                       guard let self = self else { return }
                       //
                       self.nameArray[indexPath.row].isLike = !currentBtnState
           //            self.myTableView.reloadRows(at: [indexPath], with: .automatic)
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
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
                self.nameArray.remove(at: indexPath.row) // 3
                self.peopleTableView.deleteRows(at: [indexPath], with: .automatic)
                self.peopleTableView.reloadData()
            
                success(true)
               }
               delete.backgroundColor = .systemRed
            
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
