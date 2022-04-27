//
//  AddService.swift
//  Poem
//
//  Created by 이용준 on 2022/04/26.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore
import CodableFirebase

class AddService {
    static let shared = AddService()
    private var db: Firestore

    init() {
        db = Firestore.firestore()
    }
    
    func addPoem(_ poem: Poem) {
        let data = try! FirestoreEncoder().encode(poem)
        db.collection("poem").document(poem.id).setData(data)
    }
}
