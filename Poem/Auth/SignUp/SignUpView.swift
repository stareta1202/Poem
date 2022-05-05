//
//  SignUpView.swift
//  Poem
//
//  Created by 이용준 on 2022/04/26.
//

import Foundation
import SwiftUI
import Combine

struct SignUpEmailPasswordView: View {
    @StateObject var core = SignUpEmailPasswordCore()
    @Binding var notSignedUp: Bool
    @Binding var loginViewDismissAble: Bool
    var body: some View {
        VStack {
            
            Spacer(minLength: 20)
            HStack {
                Spacer(minLength: 12)
                Text("이메일 (필수)")
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
                Text("비밀번호 (필수)")
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
            VStack {
                PhoneValidView(phoneNumber: $core.phoneNumber, validNumberMessage: $core.isValidNumberMessage)
                UserNameView(userName: $core.userName)
            }
            
            Spacer()
            Button {
                core.signUp { success in
                    notSignedUp = success ? false : true
                    loginViewDismissAble = success ? false : true
                }
            } label: {
                Text("회원가입")
            }
            .disabled(core.loginValidate)
        }
        
    }
}

struct PhoneValidView: View {
    @Binding var phoneNumber: String
    @Binding var validNumberMessage: String
    var body: some View {
        HStack {
            Spacer(minLength: 12)
            Text("전화번호 (선택사항) ")
                .frame(maxWidth: .infinity,  alignment: .leading)
                .foregroundColor(.secondary)
                .font(Font.system(size: 12))
            Spacer()
        }

        HStack {
            Spacer(minLength: 16)
            TextField("전화번호를 입력해주세요", text: $phoneNumber)
                .font(Font.system(size: 20))
            Spacer()
        }

        HStack {
            Spacer(minLength: 16)
            Text(validNumberMessage)
                .foregroundColor(.secondary)
                .font(Font.system(size: 12))
            Spacer()
        }
        
    }
}
struct UserNameView: View {
    @Binding var userName: String

    var body: some View {
        HStack {
            Spacer(minLength: 12)
            Text("닉네임 (선택사항) ")
                .frame(maxWidth: .infinity,  alignment: .leading)
                .foregroundColor(.secondary)
                .font(Font.system(size: 12))
            Spacer()
        }

        HStack {
            Spacer(minLength: 16)
            TextField("닉네임을 입력해주세요", text: $userName)
                .font(Font.system(size: 20))
            Spacer()
        }
    }
}

