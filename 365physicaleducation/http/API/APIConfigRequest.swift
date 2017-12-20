//
//  APIConfigRequest.swift
//  365physicaleducation
//
//  Created by ouyang on 2017/12/20.
//  Copyright © 2017年 ouyang. All rights reserved.
//

import Foundation

struct ConfigApi: PDAPIConvertible {
    var path = "classes/appinfo2/6tHwFFFq"
    var page: Int = 0
    
    func parameters() -> [String : Any] {
        return ["X-Bmob-Application-Id": "a2d8ed021635d48469767d4aea5ff9e8",
                "X-Bmob-REST-API-Key": "28708615d663b72656cbe919330ba46e"]
    }
    
    func baseURL() -> String {
         return "https://api.bmob.cn/1/"
    }
}


struct ConfigEntity: Codable {
    var createdAt: String
    var cz_url: String
    var objectId: String
    var on_status: String
    var on_url: String
    var updatedAt: String
}
