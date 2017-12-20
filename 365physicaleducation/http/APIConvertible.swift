//
//  APIConvertible.swift
//  PandaApi
//
//  Created by sunny on 2017/11/27.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

import Foundation
import Alamofire

// 用来描述请求

typealias HTTPMethod = Alamofire.HTTPMethod
typealias HTTPHeaders = Alamofire.HTTPHeaders


protocol APIConvertible {

    func baseURL() -> String
    func method() -> HTTPMethod
    func headers() -> HTTPHeaders?
    func parameters() -> [String: Any]
    func timeoutInterval() -> TimeInterval
    
    /// Request url
    var path: String { get }
}


