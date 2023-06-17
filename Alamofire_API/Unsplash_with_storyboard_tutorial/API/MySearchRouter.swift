//
//  MySearchRouter.swift
//  Unsplash_with_storyboard_tutorial
//
//  Created by 최희진 on 2023/05/11.
//

import Foundation
import Alamofire

// 검색관련 api

enum MySearchRouter: URLRequestConvertible {
    case searchPhotos(term: String)
    case searchUsers(term: String)

    var baseURL: URL {
        return URL(string: API.BASE_URL + "search/")! //여기서 나온 값이 baseURL이다.
    }

    var method: HTTPMethod {
        //return .get
        
        switch self{
        case .searchPhotos, .searchUsers:
            return .get
        }
        
//        switch self {
//        case .searchPhotos:
//            return .get
//        case .searchUsers:
//            return .post
//        }
    }

    var path: String {
        switch self {
        case .searchPhotos:
            return "photos/"
        case .searchUsers:
            return "users/"
        }
    }
    
    var parameters : [String : String] {
        switch self{
        case let .searchUsers(term), let .searchPhotos(term)://enum으로 들어온 애를 사용하려면 let을 사용
            return ["query" : term]
        }
    }

    func asURLRequest() throws -> URLRequest {
        print("MySearchRouter - asURLRequest()")
        
        let url = baseURL.appendingPathComponent(path) //url에다가 String을 붙인다.
        
        var request = URLRequest(url: url)
        request.method = method
        
        request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)//알아서 에러 발생하면 밖으로 빠짐

        return request
    }
}
