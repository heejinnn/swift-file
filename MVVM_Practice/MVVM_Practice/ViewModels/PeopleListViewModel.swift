//
//  PeopleListViewModel.swift
//  MVVM_Practice
//
//  Created by 최희진 on 2023/06/26.
//

import Foundation

struct PeopleListViewModel {
    let peoples: [People]
    
    
}
extension PeopleListViewModel{
    var numberOfSections: Int {
        return 1
    }

    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.peoples.count
    }

    func peopleAtIndex(_ index: Int) -> PeopleViewModel {
        let people = self.peoples[index]
        return PeopleViewModel(people)
    }
}

struct PeopleViewModel {
    private let people: People
}

extension PeopleViewModel {
    init(_ people: People) {
        self.people = people
    }
}

extension PeopleViewModel {
    var id: Int? {
        return self.people.id
    }
    var employeeName: String? {
        return self.people.peopleName
    }
    var employeeAge: Int? {
        return self.people.peopleAge
    }
}
