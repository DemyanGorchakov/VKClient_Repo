//
//  Service.swift
//  VKClient
//
//  Created by Демьян Горчаков on 26.12.2022.
//

import Foundation
import Alamofire
import RealmSwift

class  Service {
    
    let baseUrl = "https://api.vk.com/method"
    
    func getFriends(token: String, completion: @escaping ([Friend]) -> ()) {
        let url = baseUrl + "/friends.get"
        
        let parameters: Parameters = [
            "access_token": token,
            "field": "city",
            "v": "5.131"
        ]
        
        AF.request(url, method: .post, parameters: parameters).response { res in
            if let data = res.data {
                if let friends = try? JSONDecoder().decode([Friends].self, from: data).response {
                    completion(friends)
                }
            }
        }
    }
    
    private func saveToRealm(friends: [Friends]) {
        let realm = try! Realm()

        try! realm.write({
            realm.add(friends)
        })
    }
}
