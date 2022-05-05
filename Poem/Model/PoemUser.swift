//
//  User.swift
//  Poem
//
//  Created by 이용준 on 2022/04/26.
//

import Foundation

class PoemUser: Codable {
    var uuid: String
    var email: String
    var password: String
    var username: String?
    var phoneNumber: String?
    
    init(
        uuid: String,
        email: String,
        password: String
    ) {
        self.email = email
        self.uuid = uuid
        self.password = password
    }
}
