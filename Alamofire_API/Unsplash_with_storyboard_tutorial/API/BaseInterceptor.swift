//
//  BaseInterceptor.swift
//  Unsplash_with_storyboard_tutorial
//
//  Created by 최희진 on 2023/04/23.
//

import Foundation
import Alamofire

//상속받는 클래스를 RequestInterceptor
class BaseInterceptor : RequestInterceptor{
    //RequestInterceptor에서는 adapt와 retry가 존재
    
    
    //api를 request될 때 같이 호출, 마지막에 컴플레션 항상 같이 호출해야 함. 호출하지 않으면 멈춰있음.
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        print("BaseInterceptor - adapt() ")
        
        var request = urlRequest
        //헤더 추가
        request.addValue("application/json: charset=UTF-8", forHTTPHeaderField: "Content-type")
        request.addValue("application/json: charset=UTF-8", forHTTPHeaderField: "Accept")
        
        //공통 파라미터 추가
        var dictionary = [String : String]()

        dictionary.updateValue(API.CLIENT_ID, forKey: "client_id")

        do{
            request = try URLEncodedFormParameterEncoder().encode(dictionary, into: request)
        }catch{
            print(error)
        }
        
        completion(.success(request))
    }
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("BaseInterceptor - retry()")
        
        guard let statusCode = request.response?.statusCode else {
            completion(.doNotRetry)
            return
        }
        let data = ["statusCode" : statusCode]
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION.API.AUTH_FAIL), object: nil, userInfo: data)
        
        
        //응답에 대한 결과에 따라 api 다시 호출할지 여부
        completion(.doNotRetry)
    }
}
