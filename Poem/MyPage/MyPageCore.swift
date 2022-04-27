//
//  MyPageCore.swift
//  Poem
//
//  Created by 이용준 on 2022/04/27.
//

import Foundation
import Combine
import SwiftUI

class MyPageCore: ObservableObject {
    @Published var models: [MyPageModel]
    @Published var loggedIn: Bool = false
    @Published var NotLoggedIn: Bool = true
    private var subscription = Set<AnyCancellable>()
    init() {
        self.models = [
            MyPageModel(.myLike),
            MyPageModel(.myPost)
        ]
        AuthService.shared.user$
            .removeDuplicates()
            .sink { [unowned self] user in
                if user != nil {
                    self.models.insert(MyPageModel(.myInfo), at: 0)
                    self.models = self.models.filter({ $0.type != .logIn})
                    self.models.append(MyPageModel(.logOut))
                } else {
                    self.models = self.models.filter({ $0.type != .myInfo && $0.type != .logOut})
                    self.models.insert(.init(.logIn), at: 0)
                }
            }
            .store(in: &subscription)
        
        AuthService.shared.user$
            .map({ user in
                return user != nil ? true : false
            })
            .assign(to: &self.$loggedIn)
        AuthService.shared.user$
            .map({ user in
                return user != nil ? false : true
            })
            .assign(to: &self.$NotLoggedIn)
    }
    
    func logOut() {
        try? AuthService.shared.logOut()
    }
}

class MyPageModel: Hashable {
    var title: String
    var type: MyPageComponent
    var image: Image
    var selected: Bool = false

    init(
        _ type: MyPageComponent
    ) {
        
        self.type = type
        
        switch type {
        case .myPost:
            self.image = Image(systemName: "plus")
            self.title = "내 게시물"
        case .myLike:
            self.image = Image(systemName: "plus")
            self.title = "내 좋아요"
        case .myInfo:
            self.image = Image(systemName: "plus")
            self.title = "내 정보"
        case .logIn:
            self.image = Image(systemName: "plus")
            self.title = "로그인"
        case .logOut:
            self.image = Image(systemName: "plus")
            self.title = "로그아웃"
        case .withdraw:
            self.image = Image(systemName: "plus")
            self.title = "회원탈퇴"
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(type)
    }
    
    static func == (lhs: MyPageModel, rhs: MyPageModel) -> Bool {
        return lhs.title == rhs.title && lhs.type == rhs.type
    }
}


enum MyPageComponent: Hashable {
    case myPost
    case myLike
    case logIn
    case myInfo
    case logOut
    case withdraw
}
