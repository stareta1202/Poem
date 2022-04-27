//
//  MyPageView.swift
//  Poem
//
//  Created by 이용준 on 2022/04/26.
//

import Foundation
import SwiftUI

struct MyPageView: View {
    @StateObject var core: MyPageCore = .init()
    var body: some View {
        VStack {
            NavigationView  {
                List($core.models, id: \.hashValue) { model in
                    
                    if self.core.loggedIn {
                        switch model.type.wrappedValue {
                        case .logOut:
                            Button {
                                core.logOut()
                            } label: {
                                Text("로그아웃")
                            }

                        default:
                            NavigationLink {
                            } label: {
                                MyPageViewCell(image: model.image, title: model.title, selected: model.selected)
                            }
                        }

                    } else {
                        if model.type.wrappedValue == .logIn {
                            MyPageAuthCell(image: model.image, title: model.title, selected: model.selected, isLoggedIn: $core.loggedIn, notLoggedIn: $core.NotLoggedIn)
                        } else {
                            MyPageViewCell(image: model.image, title: model.title, selected: model.selected)
                        }
                    }
                }
            }

        }
        .padding()
    }
}

struct MyPageViewCell: View {
    @Binding var image: Image
    @Binding var title: String
    @Binding var selected: Bool
    
    var body: some View {
        HStack {
            image
            Spacer()
            Text("\(title)")
        }
    }
}

struct MyPageAuthCell: View {
    @Binding var image: Image
    @Binding var title: String
    @Binding var selected: Bool
    @Binding var isLoggedIn: Bool
    @Binding var notLoggedIn: Bool
    @State var showModal: Bool = false
    
    var body: some View  {
        Button {
            self.showModal = !showModal
        } label: {
            HStack {
                image
                Spacer()
                Text("\(title)")
            }
        }
        .sheet(isPresented: $showModal) {
            LoginView(presentable: $showModal)
        }

    }
}
