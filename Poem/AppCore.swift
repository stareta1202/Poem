//
//  AppCore.swift
//  Poem
//
//  Created by 이용준 on 2022/04/26.
//

import Foundation
import Combine
import FirebaseAuth

class AppCore: ObservableObject {
    @Published var user: User?
    
    
    init () {
        if let user = Auth.auth().currentUser {
            self.user = user
        }
    }
}
