//
//  AllPoemView.swift
//  Poem
//
//  Created by 이용준 on 2022/05/05.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import CodableFirebase

struct AllPoemView: View {
    @StateObject var core = AllPoemCore()
    var body: some View {
        VStack {
            List($core.poems, id: \.id) { model in
                Text(model.title.wrappedValue)
            }
            
        }
        .padding()
        
    }
}

class AllPoemCore: ObservableObject {
    @Published var poems: [Poem] = []
    let getService = GetService.shared
    private let _yesterday = Calendar.current.date(byAdding: .day, value: -2, to:Date())!
    init() {
        getRecentPoems()
    }
    
    func getRecentPoems() {
        getService.db.collection("poem")
            .whereField("createdAt", isGreaterThan: Timestamp.init(date: _yesterday))
            .getDocuments {[weak self] snap, error in
            guard let self = self else { return }
            if let snap = snap {
                for doc in snap.documents {
                    do {
                        let model = try FirestoreDecoder().decode(Poem.self, from: doc.data())
                        self.poems.append(model)
                    } catch {
                        print("error \(error)")
                    }
                }
            }
        }
    }
    
}
