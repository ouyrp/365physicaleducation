//
//  JokeAPI.swift
//  365physicaleducation
//
//  Created by sunny on 2017/12/20.
//  Copyright © 2017年 ouyang. All rights reserved.
//

import Foundation

struct JokeAPI: PDAPIConvertible {
    func parameters() -> [String : Any]? {
        return ["showapi_appid":"52061",
                "showapi_sign":"ea8cb6970d834a6f89a3d5509f369ea1",
                "num": "15",
                "page":"\(page)"]
    }
    
    var path = "341-1"
    var page: Int = 1
    
    init(with page: Int) {
        self.page = page
    }
}

struct JokeEntity: Codable {
    var text: String = ""
    var title: String = ""
    var type: Int = 0
    var createTime: String = ""
    
    private enum CodingKeys: String, CodingKey {
        case text = "text"
        case title = "title"
        case type = "type"
        case createTime = "ct"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        text = try container.decode(String.self, forKey: .text)
        title = try container.decode(String.self, forKey: .title)
        type = try container.decode(Int.self, forKey: .type)
        createTime = try container.decode(String.self, forKey: .createTime)
    }
}


