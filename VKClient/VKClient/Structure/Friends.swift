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

struct Friends: Object, Decodable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var items: List<Friend>
}

struct Friend: Object, Decodable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var id: Int
    @Persisted var firstName: String
    @Persisted var lastName: String
    
    enum CodinKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
