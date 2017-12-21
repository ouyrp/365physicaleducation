//
//  PandaAPIList.swift
//  PandaApi
//
//  Created by sunny on 2017/11/27.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

import Foundation

// 这个文件用来配置 请求通用的东西。。相当于一个配置文件

// 配置基础URL
extension APIConvertible {
    func baseURL() -> String {
        return "http://route.showapi.com/"
    }
}

// 配置全局请求方法
extension APIConvertible {
    func method() -> HTTPMethod {
        return .get
    }
}

// 配置全局请求超时时间
extension APIConvertible {
    func timeoutInterval() -> TimeInterval {
        return 30
    }
}

// 配置请求 header
extension APIConvertible {
    func headers() -> HTTPHeaders? {
//        return nil
        return ["X-Bmob-Application-Id": "a2d8ed021635d48469767d4aea5ff9e8",
                "X-Bmob-REST-API-Key": "28708615d663b72656cbe919330ba46e"]
    }
}

protocol PDAPIConvertible: APIConvertible {
    
}

extension PDAPIConvertible {
    var path: String { return "" }
}




