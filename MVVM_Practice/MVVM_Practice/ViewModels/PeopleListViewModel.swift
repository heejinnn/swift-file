//
//  PeopleListViewModel.swift
//  MVVM_Practice
//
//  Created by 최희진 on 2023/06/26.
//

import Foundation

struct PeopleListViewModel {
    let articles: [People]
    
    
}
extension PeopleListViewModel{
    var numberOfSections: Int {
        return 1
    }

    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.articles.count
    }

    func peopleAtIndex(_ index: Int) -> PeopleViewModel {
        let people = self.articles[index]
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
    var title: String? {
        return self.people.title
    }
    var author: String? {
        return self.people.author
    }
//    var employee_age: Int? {
//        return self.people.employee_age
//    }
}
