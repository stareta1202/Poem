//
//  LoginView.swift
//  Poem
//
//  Created by 이용준 on 2022/04/26.
//

import Foundation
import SwiftUI
import FirebaseAuth
import Combine

struct LoginView: View {
    @StateObject var core = LoginCore()
    @Binding var presentable: Bool
    var body: some View {
        VStack {
            Spacer(minLength: 20)
            HStack {
                Spacer(minLength: 12)
                Text("이메일")
                    .frame(maxWidth: .infinity,  alignment: .leading)
                    .foregroundColor(.secondary)
                    .font(Font.system(size: 12))
                Spacer()
            }
            HStack {
                Spacer(minLength: 16)
                TextField("이메일을 입력해주세요", text: $core.email)
                    .font(Font.system(size: 20))
                Spacer()
            }
            HStack {
                Spacer(minLength: 16)
                Text(core.emailValidMessage)
                    .foregroundColor(.secondary)
                    .font(Font.system(size: 12))
                Spacer()
            }
            
            HStack {
                Spacer(minLength: 12)
                Text("비밀번호")
                    .frame(maxWidth: .infinity,  alignment: .leading)
                    .foregroundColor(.secondary)
                    .font(Font.system(size: 12))
                Spacer()
            }
            HStack {
                Spacer(minLength: 16)
                TextField("비밀번호를 입력해주세요", text: $core.password)
                    .font(Font.system(size: 20))
                Spacer()
            }
            HStack {
                Spacer(minLength: 16)
                Text(core.passwordValidMessage)
                    .foregroundColor(.secondary)
                    .font(Font.system(size: 12))
                Spacer()
            }
            
            HStack {
                Button("회원가입") {
                    core.notLoggedIn = true
                }
                .sheet(isPresented: $core.notLoggedIn) {
                    SignUpEmailPasswordView(notSignedUp: $core.notLoggedIn)
                }
            }
            
            Spacer()
            Button {
                core.logIn { result in
                    presentable = result ? false : true
                }

            } label: {
                Text("로그인")
            }
            .disabled(core.loginValidate)

        }
        
    }
}

class LoginCore: ObservableObject {
    private var subscription = Set<AnyCancellable>()
    typealias ErrorFactory = LoginViewErrorFactory
    @Published var email: String = ""
    @Published var emailValidMessage: String = ""
    @Published var password: String = ""
    @Published var passwordValidMessage: String = "6글자 이상 입력해주세요"
    @Published var loginValidate: Bool = false
    @Published var user: User? = nil
    @Published var notLoggedIn: Bool = false
    
    init () {
        
        AuthService.shared.user$.assign(to: &self.$user)
        AuthService.shared.user$.map { user in
            return user != nil ? false : true
        }
        .dropFirst()
        .assign(to: &self.$notLoggedIn)
        
        self.$email
            .map { [unowned self] email in
                guard email != "" else { return "" }
                return self.isValidEmail(email) ? "⭕️ 확인" : "올바르지 않은 양식입니다"
            }
            .assign(to: &self.$emailValidMessage)
        self.$password
            .map { password in
                return password.count >= 6 ? "⭕️ 확인" :  "6글자 이상 입력해주세요"
            }
            .assign(to: &self.$passwordValidMessage)
        
        Publishers.CombineLatest(
            self.$email,
            self.$password
        )
        .map { [unowned self] email, password in
            return self.isValidEmail(email) && password.count >= 6 ? false : true
        }
        .assign(to: &self.$loginValidate)
            
    }
    
    func isValidEmail$(_ email: String) -> AnyPublisher<Bool, Never> {
        return self.$email.map { [unowned self] email in
            return self.isValidEmail(email)
        }
        .eraseToAnyPublisher()
        
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    func logIn(_ completion: @escaping (_ result: Bool) -> Void) {
        AuthService.shared.logIn(email, password) { success in
            completion(success)
        }
    }
    
}
enum LoginViewErrorFactory: ErrorFactory {
    
    enum Code: Int {
        case invalidEmail = 0
    }
    
    static func invalidEmail() -> NSError {
        return NSError(domain: domain, code: Code.invalidEmail.rawValue)
    }
}
