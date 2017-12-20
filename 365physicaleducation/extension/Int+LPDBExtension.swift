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
        return String(self).characters.count
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
        return String(self).characters.count
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

