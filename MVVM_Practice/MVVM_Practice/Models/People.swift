//
//  People.swift
//  MVVM_Practice
//
//  Created by 최희진 on 2023/06/26.
//

import Foundation

//struct PeopleList: Decodable {
//    let peoples: [People]
//}
//
//struct People: Decodable {
//
//    let id: Int?
//    let peopleName: String?
//    let peopleAge: Int?
//}


import Foundation

struct PeopleList: Decodable {
    let articles: [People]
}

struct People: Decodable {
 
    let title: String?
    let author: String?
    //let employee_age: Int?
}
