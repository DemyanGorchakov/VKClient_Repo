//
//  Friends.swift
//  VKClient
//
//  Created by Демьян Горчаков on 26.12.2022.
//

import Foundation
import RealmSwift


struct ResponseFriend: Decodable {
    var response: Friends
}

struct Friends: Decodable {
    var items: [Friend]
}

struct Friend: Object, Decodable {
    @Persisted var id: Int
    @Persisted var firstName: String
    @Persisted var lastName: String
    
    enum CodinKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
