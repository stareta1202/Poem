//
//  MainView.swift
//  Poem
//
//  Created by 이용준 on 2022/04/21.
//

import SwiftUI

struct MainView: View {
    
    @State private var showModal = false
    @StateObject private var core = MainCore()
    
    var body: some View {
        VStack {
            NavigationView {
                Text("Hello ")
                    .toolbar {
                        ToolbarItem(id: "add") {
                            Button("aaa") {
                                showModal = true
                            }
                            .sheet(isPresented: $showModal) {
                                AddView(presentable: $showModal)
                            }
                        }
                    }
            }
            
        }
    }
}


