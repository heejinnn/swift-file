//
//  ViewController.swift
//  MVVM_Practice
//
//  Created by 최희진 on 2023/06/26.
//

import UIKit

class PeopleTableViewController: UITableViewController {

    private var peopleListVM: PeopleListViewModel!

        override func viewDidLoad() {
            super.viewDidLoad()

            setup()
        }

        private func setup() {
            self.navigationController?.navigationBar.prefersLargeTitles = true

            let url = URL(string: "https://dummy.restapiexample.com/api/v1/employees")!
            DummyAPI().getPeoples(url: url) { //1
                (peoples) in

                if let peoples = peoples {
                    self.peopleListVM = PeopleListViewModel(peoples: peoples)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
                
}

extension PeopleTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.peopleListVM.numberOfRowsInSection(section)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.peopleListVM == nil ? 0 : self.peopleListVM.numberOfSections
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PeopleTableViewCell", for: indexPath) as? PeopleTableViewCell
        else {fatalError("no matched articleTableViewCell identifier")}

        let peopleVM = self.peopleListVM.peopleAtIndex(indexPath.row) //3
        cell.nameLabel?.text = peopleVM.employeeName
        cell.idLabel?.text = "\(peopleVM.id)"
        return cell
    }

}
