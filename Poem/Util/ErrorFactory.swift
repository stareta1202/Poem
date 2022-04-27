//
//  ErrorFactory.swift
//  Poem
//
//  Created by 이용준 on 2022/04/27.
//

import Foundation

protocol ErrorFactory {
    static var domain: String { get }
    associatedtype Code: RawRepresentable where Code.RawValue == Int
}

extension ErrorFactory {
    static var domain: String { "\(Self.self)"}
}
