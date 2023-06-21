//
//  MyAlamofireManager.swift
//  Unsplash_with_storyboard_tutorial
//
//  Created by 최희진 on 2023/04/23.
//

import Foundation
import Alamofire
import SwiftyJSON

final class MyAlamofireManager {
    
    //싱글턴 적용
    static let shared = MyAlamofireManager()//자기 자신의 인스턴스를 가져옴
    
    //인터셉터 (공통 파라미터나, JWT)
    let interceptors = Interceptor(interceptors:
                    [
                        BaseInterceptor()//인터셉터 여러개 추가 가능
                    ])
    
    //로거 설정
    //자료형이 EventMonitor
    let monitors = [MyLogger(), MyApiStatusLogger()] as [EventMonitor]//여러개 추가 가능
    
    
    //세션 설정
    //Alamofire의 세션
    var session : Session
    
    private init(){
        session = Session(interceptor: interceptors, eventMonitors: monitors)
    }
    
    
    //MARK: - Alamofire methods
    //이 함수를 호출할 때는 매개변수로 searchTerm 사용
    func getPhotos(searchTerm userInput: String, Completion: @escaping (Result<[Photo],MyError>)-> Void){//이 메소드에서 사용하는 매개변수 이름은 userInput
        //컴플레션 블럭이어서 Void 넣어줌
        print("MyAlamofireManager - getPhotos() called userInput : \(userInput) ")
            self
                //.shared는 싱글턴으로 가져오기 때문에 필요 x
                .session //세션 설정
                .request(MySearchRouter.searchPhotos(term: userInput))
                .validate(statusCode: 200..<401)//200에서 401이전까지만
                .responseJSON(completionHandler: {response in
                    
                    guard let responseValue = response.value else {return}
                    
                    let responseJson = JSON(responseValue)//Json 덩어리가 들어옴
                    
                    let jsonArray = responseJson["results"]//key가 results
                    var photos = [Photo]()
                    
                    for(index, subJson): (String, JSON) in jsonArray{
                        for i in 0..<5{
                            if index == "\(i)"{
                                
                                guard let thumbnail = subJson["urls"]["thumb"].string,
                                      let username = subJson["user"]["username"].string,
                                      let createdAt = subJson["created_at"].string else {return}
                                
                                let likesCount = subJson["likes"].intValue
                                
                                let photoItem = Photo(thumbnail: thumbnail, username: username, likesCount: likesCount, createdAt: createdAt)
                                
                                //배열에 넣고
                                photos.append(photoItem)
                            }
                        }
                    }
                    if photos.count > 0 {
                        Completion(.success(photos))
                    }else{
                        Completion(.failure(.noContent))
                    }
                    
                    
                })
        
    }
    
    func getUsers(searchTerm userInput: String, Completion: @escaping (Result<[User],MyError>)-> Void){
        
        print("MyAlamofireManager - getUsers() called userInput : \(userInput) ")
            self
                //.shared는 싱글턴으로 가져오기 때문에 필요 x
                .session //세션 설정
                .request(MySearchRouter.searchUsers(term: userInput))
                .validate(statusCode: 200..<401)//200에서 401이전까지만
                .responseJSON(completionHandler: {response in
                 
                    guard let responseValue = response.value else {return}
                    
                    let responseJson = JSON(responseValue)
                    let jsonArray = responseJson["results"]
                    
                    var users = [User]()
                    
                    for(index, subJson): (String, JSON) in jsonArray{
                        for i in 0..<3{
                            if index == "\(i)"{
                    
                                guard let username = subJson["username"].string,
                                      let id = subJson["id"].string else {return}

                                let userData = User(username: username, id: id)

                                //배열에 넣고
                                users.append(userData)
                            }
                        }
                    }
                    if users.count > 0 {
                        Completion(.success(users))
                    }else{
                        Completion(.failure(.noContent))
                    }
                
                })
        
    }
    
}
