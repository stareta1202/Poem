//
//  PoemApp.swift
//  Poem
//
//  Created by 이용준 on 2022/04/21.
//

import SwiftUI
import Firebase

@main
struct PoemApp: App {
    
    init () {
        FirebaseApp.configure()
        
    }
    
    var body: some Scene {
        WindowGroup {
            TabView {
//                ContentView()
//                    .tabItem {
//                        Text("menu")
//                    }
                MainView()
                    .tabItem {
                        Text("Main")
                    }
                MyPageView()
                    .tabItem {
                        Text("MyPAge")
                    }
                
            }
            
        }
    }
}
