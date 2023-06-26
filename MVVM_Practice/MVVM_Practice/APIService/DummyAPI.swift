//
//  DummyAPI.swift
//  MVVM_Practice
//
//  Created by 최희진 on 2023/06/26.
//

import Foundation

class DummyAPI {
    func getPeoples(url: URL, completion: @escaping ([People]?) -> ()) {
        
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            if let error = error {
                print(error)
                //completion(nil)
            }
           
            else if let data = data {
                let peopleList = try? JSONDecoder().decode(PeopleList.self, from: data)
                print(peopleList)
                if let peopleList = peopleList {
                    completion(peopleList.articles)
                }
                print(peopleList?.articles)
                
            }
            
        }.resume()
    }
}
