//
//  APILaugh.swift
//  PandaSwift
//
//  Created by ouyang on 2017/12/15.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

import Foundation

struct LaughApi: PDAPIConvertible {
    func parameters() -> [String : Any]? {
        return ["showapi_appid":"52061",
                "showapi_sign":"ea8cb6970d834a6f89a3d5509f369ea1",
                "num": "10"]
    }
    
    var path = "341-1"
}


struct LaughEntity: Codable {
    var description: String
    var picUrl: String
    var title: String
    var ctime: String
    var url: String
}
