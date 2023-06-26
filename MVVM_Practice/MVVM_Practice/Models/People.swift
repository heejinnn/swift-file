//
//  People.swift
//  MVVM_Practice
//
//  Created by 최희진 on 2023/06/26.
//

import Foundation

struct PeopleList: Decodable {
    let peoples: [People]
}

struct People: Decodable {
 
    let id: Int?
    let peopleName: String?
    let peopleAge: Int?
}
