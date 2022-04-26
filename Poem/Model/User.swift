//
//  User.swift
//  Poem
//
//  Created by 이용준 on 2022/04/26.
//

import Foundation

class UserData: Codable {
    var uuid: String
    var email: String
    var password: String
    
    init(
        _ uuid: String,
        _ email: String,
        _ password: String
    ) {
        self.email = uuid
        self.uuid = uuid
        self.password = password
    }
}
