//
//  Operator+LPDBExtension.swift
//  LPDBusiness
//
//  Created by EyreFree on 16/12/15.
//  Copyright © 2016年 LPD. All rights reserved.
//

import Foundation

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ^^ : PowerPrecedence
func ^^ (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}
