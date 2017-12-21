
//
//  HTTPEngine.swift
//  PandaApi
//
//  Created by sunny on 2017/11/27.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

// 这里用来发起请求

let HTTP = HTTPEngine()

final class HTTPEngine {
    fileprivate init() {
                validateHTTPS()  // 初始化的时候配置 HTTPS
    }
    // 最后返回的东西我看情况了
    func request(_ api: APIConvertible) -> Observable<Alamofire.DataResponse<Data>> {
        return Observable.create({ (observable) -> Disposable in
            
            let request = Alamofire.request(
                api.baseURL()+api.path,
                method: api.method(),
                parameters: api.parameters(),
                encoding: URLEncoding.default,
                headers: api.headers())
            
            request.responseString(completionHandler: { (res) in
                //                observable.onNext(res)
                // 我喜欢在这里做 Logger
                print(res)
            }).responseData(completionHandler: { (res) in
                observable.onNext(res)
            })
            
            request.resume()
            
            return Disposables.create {
                request.cancel()
            }
        })
    }
}

// HTTPS 我只是写出来了，不知道对不对
func validateHTTPS() {
    let manager = SessionManager.default
    manager.delegate.sessionDidReceiveChallenge = { session, challenge in
        
        var disposition: URLSession.AuthChallengeDisposition = .performDefaultHandling
        var credential: URLCredential?
        
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            disposition = URLSession.AuthChallengeDisposition.useCredential
            credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
        } else {
            if challenge.previousFailureCount > 0 {
                disposition = .cancelAuthenticationChallenge
            } else {
                credential = manager.session.configuration.urlCredentialStorage?.defaultCredential(for: challenge.protectionSpace)
                
                if credential != nil {
                    disposition = .useCredential
                }
            }
        }
        return (disposition, credential)
    }
}


