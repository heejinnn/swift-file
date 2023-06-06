//
//  ViewController.swift
//  tableView_example
//
//  Created by 최희진 on 2023/06/04.
//

import UIKit

class Feed {
    let name : String
    var isLike : Bool = false
    
    init (name: String){
        self.name = name
    }
    
}


class ViewController: UIViewController {

    @IBOutlet weak var peopleTableView: UITableView!
    
    @IBOutlet weak var dataTextField: UITextField!
    @IBOutlet weak var addBtn: UIButton!
    
    var nameArray = [Feed(name: "나야나"), Feed(name: "스위프트")]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        peopleTableView.dataSource = self
        peopleTableView.delegate = self
        // Do any additional setup after loading the view.
        setup()
    }
    func setup(){
        dataTextField.placeholder = "이름을 입력하시오"
        dataTextField.borderStyle = .roundedRect
        dataTextField.clearButtonMode = .always // 전체 삭제버튼
        dataTextField.returnKeyType = .next // 키보드의 return버튼 next로 바꾸기
    }
    
    
    @IBAction func addBtnClicked(_ sender: UIButton) {
        nameArray.append(contentsOf: [Feed(name: dataTextField.text!)])
        peopleTableView.reloadData()
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = peopleTableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath) as!UIPeopleViewCell
        
        if self.nameArray.count > 0 {
            let nameData = nameArray[indexPath.row]
            
            cell.updateUI(with: nameData)
        }

        cell.likeBtnAction = { [weak self] currentBtnState in
                   guard let self = self else { return }
                   //
                   self.nameArray[indexPath.row].isLike = !currentBtnState
       //            self.myTableView.reloadRows(at: [indexPath], with: .automatic)
               }
    
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nameArray.count
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
                self.nameArray.remove(at: indexPath.row) // 3
                self.peopleTableView.deleteRows(at: [indexPath], with: .automatic)
                   success(true)
               }
               delete.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
