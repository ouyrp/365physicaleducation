
//
//  APIList.swift
//  PandaApi
//
//  Created by sunny on 2017/11/29.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

// 这种文件可能有很多, 用来声明每个具体的 API

import Foundation

struct TestApi: PDAPIConvertible {
    var path = "196-1"
    var page:NSString?
    func parameters() -> [String : Any] {
        return ["showapi_appid":"52061",
                "showapi_sign":"ea8cb6970d834a6f89a3d5509f369ea1",
                "num": "15",
                "page":page ?? "1"]
    }
}


struct TestEntity: Codable {
    var description: String
    var picUrl: String
    var title: String
    var ctime: String
    var url: String
}



