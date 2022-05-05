//
//  UserAddService.swift
//  Poem
//
//  Created by 이용준 on 2022/04/29.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore
import CodableFirebase

class UserAddService {
    static let shared = UserAddService()
    private var db: Firestore

    init() {
        db = Firestore.firestore()
    }
    
    func addPoemUser(_ poemUser: PoemUser) {
        let data = try! FirestoreEncoder().encode(poemUser)
        db.collection("user").document(poemUser.uuid).setData(data)
    }
}
