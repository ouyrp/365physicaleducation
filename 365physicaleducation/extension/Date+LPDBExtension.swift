//
//  Date+LPDBExtension.swift
//  LPDBusiness
//
//  Created by EyreFree on 16/12/15.
//  Copyright © 2016年 LPD. All rights reserved.
//

import Foundation

extension Date {

    //MARK:- 格式转换
    func toString(format: String = "yyyy-MM-dd HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = NSTimeZone.local
        return dateFormatter.string(from: self)
    }

    //时间戳转日期(多于 10 位截断)
    static func fromTimeStamp(value: Int64) -> Date {
        var finalValue = value
        let count = value.count() - 10
        if count > 0 {
            finalValue = value / Int64(10^^count)
        }
        return Date(timeIntervalSince1970: Double(finalValue))
    }
}

