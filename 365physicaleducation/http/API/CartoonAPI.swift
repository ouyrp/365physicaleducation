//
//  CartoonAPI.swift
//  365physicaleducation
//
//  Created by sunny on 2017/12/21.
//  Copyright © 2017年 ouyang. All rights reserved.
//

import Foundation

// MMP 接口定义用的是拼音
enum CartoonType: String {
    case kongbu = "/category/weimanhua/kbmh"       // 恐怖漫画
    case gushi = "/category/weimanhua/gushimanhua" // 故事漫画
    case duanzi = "/category/duanzishou"           // 段子手
    case lenzhishi = "/category/lengzhishi"        // 冷知识
    case qiqu = "/category/weimanhua/qiqu"         // 奇趣
     case dianying = "/category/dianying"          // 电影
    case gaoxiao = "/category/gaoxiao"             // 搞笑
    case mengchong = "/category/mengchong"         // 萌宠
    case xinqi = "/category/xinqi"                 // 新奇
    case huanqiu = "/category/huanqiu"             // 环球
    case sheying = "/category/sheying"             // 摄影
    case wanyi = "/category/wanyi"                 // 玩艺
    case chahua = "/category/chahua"               // 插画
}

struct CartoonAPI: PDAPIConvertible {
    func parameters() -> [String : Any]? {
        return ["showapi_appid":"52061",
                "showapi_sign":"ea8cb6970d834a6f89a3d5509f369ea1",
                "num": "15",
                "page":"\(page)",
                "type":type.rawValue]
    }
    
    var path = "958-1"
    var page: Int = 1
    var type: CartoonType = .kongbu
    
    init(with page: Int, type: CartoonType) {
        self.page = page
        self.type = type
    }

    func method() -> HTTPMethod {
        return .post
    }
    
}

struct CartoonEntity: Codable {
    var thumbnailList: [String] = []
    var link: String = ""
    var title: String = ""
    var id: String = ""
    var time: String = ""
}









