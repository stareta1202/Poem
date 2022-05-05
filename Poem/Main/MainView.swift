//
//  MainView.swift
//  Poem
//
//  Created by 이용준 on 2022/04/21.
//

import SwiftUI

struct MainView: View {
    @State private var showModal = false
    
    @State private var selectedTab: Int = 0

    let tabs: [Tab] = [
        .init(icon: Image(systemName: "music.note"), title: "따끈따끈한 시"),
        .init(icon: Image(systemName: "film.fill"), title: "주간 시"),
//        .init(icon: Image(systemName: "book.fill"), title: "내가 팔로워하는 작가들의 시")
    ]
    
    @StateObject private var core = MainCore()
    
    var body: some View {
        VStack {
            NavigationView {
                GeometryReader { geo in
                    VStack(spacing: 0) {
                        // Tabs
                        Tabs(tabs: tabs, geoWidth: geo.size.width, selectedTab: $selectedTab)
                        
                        // Views
                        TabView(selection: $selectedTab,
                                content: {
                            AllPoemView()
                                .tag(0)
                            Demo2View()
                                .tag(1)
                            Demo3View()
                                .tag(2)
                        })
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    }
                }
//                Text("Hello ")
                    .toolbar {
                        ToolbarItem(id: "add") {
                            Button("시 쓰기") {
                                showModal = true
                            }
                            .fullScreenCover(isPresented: $showModal) {
                                AddView(presentable: $showModal)
                            }
                        }
                    }
            }


            
        }
    }
}





struct Demo2View: View {
    var body: some View {
        VStack {
            Text("22")
        }
        .padding()
    }
}

struct Demo3View: View {
    var body: some View {
        VStack {
            Text("3")
        }
        .padding()
    }
}
