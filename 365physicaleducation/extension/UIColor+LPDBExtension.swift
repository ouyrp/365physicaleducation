//
//  UIColor+LPDBExtension.swift
//  LPDBusiness
//
//  Created by EyreFree on 16/12/8.
//  Copyright © 2016年 LPD. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    //用十六进制数值初始化颜色，便于生成设计图上标明的十六进制颜色
    convenience init(hexInt: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hexInt & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hexInt & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hexInt & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
