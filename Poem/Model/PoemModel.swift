//
//  PoemModel.swift
//  Poem
//
//  Created by 이용준 on 2022/04/25.
//

import Foundation
import UIKit

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
}

class PoemComment: Codable {
    var id: String = ""
    var userId: String = ""
    var createdAt: Date = Date()
    var modifiedAt: Date = Date()
}
