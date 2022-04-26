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
    init() {
        self.models = [
            MyPageModel(.auth),
            MyPageModel(.myLike),
            MyPageModel(.myPost)
        ]
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
        case .auth:
            self.image = Image(systemName: "plus")
            self.title = "내 정보"
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
    case auth
}
