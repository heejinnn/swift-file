//
//  MyLogger.swift
//  Unsplash_with_storyboard_tutorial
//
//  Created by 최희진 on 2023/05/11.
//

import Foundation
import Alamofire

final class MyLogger : EventMonitor {
    let queue = DispatchQueue(label: "MyLogger")
    
    func requestDidResume(_ request: Request) {
        print("MyLogger - requestDidResume")
        debugPrint(request)
    }
    
    func request(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
        print("MyLogger - request.didParseResponse()")
        debugPrint(request)
    }
}
