//
//  Namespace.swift
//  YYSwift
//
//  Created by Phoenix on 2017/12/12.
//  Copyright © 2017年 Phoenix. All rights reserved.
//

import Foundation

public protocol NamespaceWrappable {
    associatedtype WrapperType
    var yy: WrapperType { get }
    static var yy: WrapperType.Type { get }
}

public extension NamespaceWrappable {
    var yy: NamespaceWrapper<Self> {
        return NamespaceWrapper(value: self)
    }
    
    static var yy: NamespaceWrapper<Self>.Type {
        return NamespaceWrapper.self
    }
}

public protocol TypeWrapperProtocol {
    associatedtype WrappedType
    var wrappedValue: WrappedType { get }
    init(value: WrappedType)
}

public struct NamespaceWrapper<T>: TypeWrapperProtocol {
    public let wrappedValue: T
    public init(value: T) {
        self.wrappedValue = value
    }
}
