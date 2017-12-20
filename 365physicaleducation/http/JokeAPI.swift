//
//  JokeAPI.swift
//  365physicaleducation
//
//  Created by sunny on 2017/12/20.
//  Copyright © 2017年 ouyang. All rights reserved.
//

import Foundation

struct JokeAPI: PDAPIConvertible {
    var path = "341-1"
    var page: Int = 1
    
    func parameters() -> [String : Any] {
        return ["showapi_appid":"52061",
                "showapi_sign":"ea8cb6970d834a6f89a3d5509f369ea1",
                "num": "15",
                "page":"\(page)"]
    }
}
