//
//  AuthService.swift
//  Poem
//
//  Created by 이용준 on 2022/04/27.
//

import Foundation
import Combine
import Firebase
import FirebaseAuth

class AuthService {
    static let shared = AuthService()
    var auth: Auth
    var handle: AuthStateDidChangeListenerHandle?
    var user: User?
    var user$ = CurrentValueSubject<User?, Never>(nil)
    
    init() {
        auth = Auth.auth()
        if let user = auth.currentUser {
            print("🔴 currentUser \(user)")
            self.user = user
            self.user$.send(user)
        }
        
        self.handle = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            guard let self = self else { return }
            print("🔴 handle user \(user)")
            self.user = user
            self.user$.send(user)

        }
    }
    
    func logIn(_ email: String, _ password: String, _ completionBlock: @escaping (_ success: Bool) -> Void) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let user = result?.user {
                print(4040404,user)
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }
    
    func signUp(_ email: String, _ password: String, _ completionBlock: @escaping (_ success: Bool, _ result: AuthDataResult?) -> Void) {
        return auth.createUser(withEmail: email, password: password) { result, error in
            if let user = result?.user {
                print(4040404,user)
                completionBlock(true, result)
            } else {
                print(5050505, "error \(error)")
                completionBlock(false, nil)
            }
        }
    }
    
    func logOut() throws {
        try auth.signOut()
    }
    
    
}

enum AuthServiceErrorFactory: ErrorFactory {
    
    enum Code: Int {
        case loginFailed = 0
    }
    
    static func loginFailed(_ error: Error) -> NSError {
        return NSError(domain: domain, code: Code.loginFailed.rawValue)
    }
}
