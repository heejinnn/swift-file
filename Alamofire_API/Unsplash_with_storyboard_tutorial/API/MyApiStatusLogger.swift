//
//  MyApiStatusLogger.swift
//  Unsplash_with_storyboard_tutorial
//
//  Created by 최희진 on 2023/05/11.
//

import Foundation
import Alamofire

final class MyApiStatusLogger : EventMonitor {
    let queue = DispatchQueue(label: "MyApiStatusLogger")
    
//    func requestDidResume(_ request: Request) {
//        print("MyApiStatusLogger - requestDidResume")
//        debugPrint(request)
//    }
    
    func request(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
        guard let statusCode = request.response?.statusCode else{return}
        
        print("MyApiStatusLogger - statusCode : \(statusCode)")
        debugPrint(request)
    }
}
