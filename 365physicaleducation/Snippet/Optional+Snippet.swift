//
//  Optional+Snippet.swift
//  Snippet
//
//  Created by sunny on 2017/12/20.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

import Foundation

public extension Optional {
    
    /// 强制要求这个 optional 不为空
    ///
    /// 这个方法返回 optional 的值，或者在optional 为空的时候触发 error
    ///
    ///
    /// - Parameters:
    ///   - hint: 为空抛出的错误信息
    ///
    /// - Returns: optional 的值.
    func require(hint hintExpression: @autoclosure() -> String? = nil,
                 file: StaticString = #file,
                 line: UInt = #line) -> Wrapped {
        guard let unwrapped = self else {
            var message = "required value was nil \(file), at line \(line)"
            if let hint = hintExpression() {
                message.append(". Debugging hit: \(hint)")
            }
            #if !os(Linux)
                let exception = NSException(name: .invalidArgumentException,
                                            reason: message,
                                            userInfo: nil)
                exception.raise()
            #endif
            
            preconditionFailure(message)
        }
        return unwrapped
    }
    
    @discardableResult
    func ifSome(_ handler: (Wrapped) -> Void) -> Optional {
        switch self {
        case .some(let wrapped): handler(wrapped); return self;
        case .none: return self
        }
    }
    
    @discardableResult
    func ifNone(_ handler: () -> ()) -> Optional {
        switch self {
        case .some: return self;
        case .none: handler(); return self
        }
    }
    
    var not: Bool {
        switch self {
        case .none: return false
        case .some(let wrapped):
            if let value = wrapped as? Bool {
                return !value
            } else {
                return false
            }
        }
    }
    
    var hasSome: Bool {
        switch self {
        case .none: return false
        case .some: return true
        }
    }
    
    /// 用来代替 ?? 操作符, 这样写可读性高些
    ///
    /// - Sample:
    //  var a: String? = nil
    //  let res = a.or("b")
    func `or`(value: Wrapped?) -> Optional {
        return self ?? value
    }
    
}

extension Bool {
    var not: Bool {
        return !self
    }
}

