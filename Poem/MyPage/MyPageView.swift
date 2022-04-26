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
                    
                    NavigationLink(<#T##title: StringProtocol##StringProtocol#>, destination: <#T##() -> _#>)
                    MyPageViewCell(image: model.image, title: model.title, selected: model.selected)
                        .onTapGesture {
    //                        switch model.type.wrappedValue {
    //                        case .myPost:
    //                        case .myLike:
    //                        case .auth:
    //                        }
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
