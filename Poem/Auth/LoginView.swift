//
//  LoginView.swift
//  Poem
//
//  Created by 이용준 on 2022/04/26.
//

import Foundation
import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @StateObject var core = LoginCore()
    var body: some View {
        VStack {
            TextField("이메일을 입력해주세요", text: $core.user.email)
            TextField("비밀번호를 입력해주세요", text: $core.user.password)
            
        }
        
    }
}

class LoginCore: ObservableObject {
    @Published var user: UserData = .init("", "", "")
    
    init () {
    }
    
}
