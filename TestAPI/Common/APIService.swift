//
//  Server.swift
//  TestAPI
//
//  Created by Никита on 12/05/2019.
//  Copyright © 2019 Никита. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

final class Service {
    let token = "ZFx4HSJ-p1-MLOBGot"
    let url = "https://bnet.i-partner.ru/testAPI/"
    let headers = ["token" : "ZFx4HSJ-p1-MLOBGot"]
    var session: String?
    
    init(){
        session = UserDefaults.standard.string(forKey: "session")
    }
    
    // first launch
    func getSession(complitition: @escaping (String?, Error?) -> Void){
        Alamofire.request(url, method: .post, parameters: ["a" : "new_session"], encoding: URLEncoding.default, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success:
                    guard let jsonData = response.data else { return }
                    do {
                        let data = try JSON(data: jsonData)
                        guard let newSession = data["data"]["session"].string else { return }
                        if self.session == nil {
                          complitition(newSession, nil)
                        } else {
                            return
                        }
                    }
                    catch {
                        print("error")
                    }

                case .failure(let error):
                    print(error.localizedDescription)
                    complitition(nil, error)
                }
        }
    }
    
    func getPosts(complitition: @escaping ([PostModel], Error?) -> Void) {
        guard let requestSession = session else { return }
        Alamofire.request(url, method: .post, parameters: ["a": "get_entries", "session": requestSession], encoding: URLEncoding.default, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success:
                    var posts = [PostModel]()
                    do {
                        let data = try! JSONDecoder().decode(AllPost.self, from: response.data!)
                        data.data[0].forEach{ posts.append($0) }
                        complitition(posts, nil)
                    }
                case .failure(let error):
                    complitition([], error)
                }
        }
    }
    
    func addEntry(text: String) {
        guard let requestSession = session else { return }
        Alamofire.request(url, method: .post, parameters: ["a" : "add_entry", "body" : text, "session": requestSession], encoding: URLEncoding.default, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success:
                    print("success post")
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
}
