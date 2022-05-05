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
import Combine

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

class GetService {
    static let shared = GetService()
    var db: Firestore
    init() {
        db = Firestore.firestore()
    }
    
    func getAll() throws -> [Poem] {
        var poems: [Poem] = []
        
        db.collection("poem").getDocuments { snap, error in
            if let snap = snap {
                for doc in snap.documents {
                    do {
                        let model = try FirestoreDecoder().decode(Poem.self, from: doc.data())
                        poems.append(model)
                    } catch {
                        print("error \(error)")
                    }

                }
            }
        }
        return poems
    }
}
