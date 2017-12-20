//
//  ChainableView+Snippet.swift
//  Snippet
//
//  Created by sunny on 2017/10/20.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

import UIKit
import SnapKit

extension UIView: NamespaceWrappable { }
extension NamespaceWrapper where T: UIView {
    
    public func adhere(toSuperView: UIView) -> T {
        toSuperView.addSubview(wrapperValue)
        return wrapperValue
    }
    
    @discardableResult
    func layout(_ snapKitMaker: (ConstraintMaker) -> Void) -> T {
        wrapperValue.snp.makeConstraints { (make) in
            snapKitMaker(make)
        }
        return wrapperValue
    }
    
    @discardableResult
    func config(_ config: (T) -> Void) -> T {
        config(wrapperValue)
        return wrapperValue
    }
}
