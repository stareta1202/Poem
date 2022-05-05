//
//  PoemModel.swift
//  Poem
//
//  Created by 이용준 on 2022/04/25.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseFirestore.FIRTimestamp

class Poem: Codable {
    var id: String = UUID().uuidString
    var title: String = ""
    var content: String = ""
    var writerId: String = ""
    var createdAt: Date = Date()
    var modifiedAt: Date = Date()
    var likes: Int = 0
    var seen: Int = 0
    var comments: [PoemComment] = []
    enum CodingKeys: String, CodingKey {
        case id, title, content, writerId, createdAt, modifiedAt, likes, seen, comments
    }
    
    init() {
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        content = try container.decode(String.self, forKey: .content)
        writerId = try container.decode(String.self, forKey: .writerId)
        let _createdAt = try container.decode(Timestamp.self, forKey: .createdAt).dateValue()
        createdAt = _createdAt
        let _modifiedAt = try container.decode(Timestamp.self, forKey: .modifiedAt).dateValue()
        modifiedAt = _modifiedAt
        likes = try container.decode(Int.self, forKey: .likes)
        seen = try container.decode(Int.self, forKey: .seen)
        comments = try container.decode([PoemComment].self, forKey: .comments)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(content, forKey: .content)
        try container.encode(writerId, forKey: .writerId)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(modifiedAt, forKey: .modifiedAt)
        try container.encode(likes, forKey: .likes)
        try container.encode(seen, forKey: .seen)
        try container.encode(comments, forKey: .comments)
    }
}

class PoemComment: Codable {
    var id: String = UUID().uuidString
    var userId: String = ""
    var createdAt: Date = Date()
    var modifiedAt: Date = Date()
    
    enum CodingKeys: String, CodingKey {
        case id, userId, createdAt, modifiedAt
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        userId = try container.decode(String.self, forKey: .userId)
        let _createdAt = try container.decode(String.self, forKey: .createdAt)
        createdAt = _createdAt.iso8601 ?? Date()
        let _modifiedAt = try container.decode(String.self, forKey: .modifiedAt)
        modifiedAt = _modifiedAt.iso8601 ?? Date()
    }
}
