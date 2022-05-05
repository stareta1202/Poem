//
//  SignUpCore.swift
//  Poem
//
//  Created by 이용준 on 2022/04/29.
//

import Foundation
import Combine


class SignUpEmailPasswordCore: ObservableObject {
    private var subscription = Set<AnyCancellable>()
    private var authService = AuthService.shared
    typealias ErrorFactory = LoginViewErrorFactory
    @Published var email: String = ""
    @Published var emailValidMessage: String = ""
    @Published var password: String = ""
    @Published var passwordValidMessage: String = "6글자 이상 입력해주세요"
    @Published var loginValidate: Bool = false
    @Published var signedUp: Bool = false
    
    @Published var userName: String = ""
    @Published var phoneNumber: String = ""
    @Published var isValidNumber: Bool = false
    @Published var isValidNumberMessage: String = ""
    
    init () {
        
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
        
        self.$phoneNumber
            .map { number in
                return number.count == 11 ? "⭕️ 확인" : ""
            }
            .assign(to: &self.$isValidNumberMessage)
        
        
        Publishers.CombineLatest(
            self.$email,
            self.$password
        )
        .map { [unowned self] email, password in
            
            return self.isValidEmail(email) && password.count >= 6  ? false : true
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
    
    func signUp(_ completion: @escaping (Bool) -> Void = { _ in }) {
        authService.signUp(email, password) { [unowned self] success, result in
            guard let uid = result?.user.uid else { return }
            guard let _email = result?.user.email else { return }
            print("😭 email \(email)")
            print("😭 uid \(uid)")
            
            let poemUser = PoemUser(uuid: uid, email: _email, password: self.password)
            print("😭 poemUser email \(poemUser.email)")
            if phoneNumber.count > 0 {
                poemUser.phoneNumber = phoneNumber
            }
            if userName.count > 0 {
                poemUser.username = userName
            }
            UserAddService.shared.addPoemUser(poemUser)
            completion(success)
        }
    }
    
}
enum SignUpEmailPasswordErrorFactory: ErrorFactory {
    
    enum Code: Int {
        case invalidEmail = 0
    }
    
    static func invalidEmail() -> NSError {
        return NSError(domain: domain, code: Code.invalidEmail.rawValue)
    }
}

