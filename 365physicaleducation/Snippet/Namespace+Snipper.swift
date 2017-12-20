//
//  Namespace+Snippet.swift
//  Snippet
//
//  Created by sunny on 2017/10/20.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

import Foundation

// 命名空间
public protocol NamespaceWrappable {
    associatedtype WrapperType
    var sunny: WrapperType { get }
    static var sunny: WrapperType.Type { get }
}

public extension NamespaceWrappable {
    var sunny: NamespaceWrapper<Self> {
        return NamespaceWrapper(value: self)
    }
    
    static var sunny: NamespaceWrapper<Self>.Type {
        return NamespaceWrapper.self
    }
}

public struct NamespaceWrapper<T> {
    public let wrapperValue: T
    public init(value: T) {
        self.wrapperValue = value
    }
}
