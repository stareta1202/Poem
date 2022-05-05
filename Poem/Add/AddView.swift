//
//  AddView.swift
//  Poem
//
//  Created by 이용준 on 2022/04/26.
//

import SwiftUI

struct AddView: View {
    @StateObject var core = AddCore()
    @Binding var presentable: Bool
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("제목")
                        .foregroundColor(.secondary)
                    Spacer()
                    Spacer(minLength: 16)
                }
                HStack {
                    TextEditor(text: $core.poem.title)
                        .multilineTextAlignment(.leading)
                        .padding()
                    Spacer(minLength: 20)
                    
                }

                HStack {
                    Text("내용")
                        .foregroundColor(.secondary)
                    Spacer(minLength: 16)
                }
                
                HStack {
                    Spacer(minLength: 20)
                    TextEditor(text: $core.poem.content)
                        .multilineTextAlignment(.leading)
                        .padding()
                    Spacer(minLength: 20)
                    
                }
                
            }
            .onTapGesture { }
            .onLongPressGesture(minimumDuration: 0, maximumDistance: 0, perform: { }, onPressingChanged: { isPress in
                if isPress { self.endEditing()}
            })
            .toolbar {
                
                ToolbarItemGroup(placement: .bottomBar) {
                    Button {
                        self.presentable.toggle()
                        
                    } label: {
                        Image(systemName: "trash")
                    }
                    Spacer()
                    
                    Button {
                        core.add()
                        self.presentable.toggle()
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                    Spacer()
                    
                    Button {
                        self.presentable.toggle()
                        
                    } label: {
                        Image(systemName: "folder")
                    }
                }
            }
        }
    }
}

class AddCore: ObservableObject {
    @Published var poem = Poem()
    private var addSerivce: AddService
    init () {
        addSerivce = AddService.shared
    }
    
    func add() {
        addSerivce.addPoem(poem)
    }
}

extension View {
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
