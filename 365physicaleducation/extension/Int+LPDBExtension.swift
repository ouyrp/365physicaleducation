//
//  Int+LPDBExtension.swift
//  LPDBusiness
//
//  Created by EyreFree on 16/12/9.
//  Copyright © 2016年 LPD. All rights reserved.
//

import Foundation
import UIKit

extension Int {

    //计算位数
    func count() -> Int {
        return "\(self)".count
    }

    //转 Float
    func f() -> Float {
        return Float(self)
    }

    //转 CGFloat
    func cf() -> CGFloat {
        return CGFloat(self)
    }
}

extension Int64 {

    //计算位数
    func count() -> Int {
        return "\(self)".count
    }

    //转 Float
    func f() -> Float {
        return Float(self)
    }

    //转 CGFloat
    func cf() -> CGFloat {
        return CGFloat(self)
    }
}

extension String {
    func additive(_ value: Int) -> String {
        if let intValue = Int(self) {
            return "\(intValue + value)"
        }
        return self
    }
}


