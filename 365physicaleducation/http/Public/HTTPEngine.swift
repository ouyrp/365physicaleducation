
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

func alamofireCertificateTrust(session: URLSession, challenge: URLAuthenticationChallenge) -> (URLSession.AuthChallengeDisposition, URLCredential?) {
    
    let method = challenge.protectionSpace.authenticationMethod
    
    //认证服务器证书
    //SecTrustRef validation required.  Applies to any protocol.
    if method == NSURLAuthenticationMethodServerTrust {
        
        //二选一
        //双向认证 (需要cer)
        //return self.serverTrust(session: session, challenge: challenge)
        
        //host认证 (这里不使用服务器证书认证，只需自定义的几个host即可信任)
        return selfSignedTrust(session: session, challenge: challenge)
        
    }
        
        //认证客户端证书
        //SSL Client certificate.  Applies to any protocol.
    else if method == NSURLAuthenticationMethodClientCertificate {
        
        return clientTrust(session: session, challenge: challenge);
        
    }
        
        // 其它情况（不接受认证）
    else {
        
        return (.cancelAuthenticationChallenge, nil)
        
    }
}

func clientTrust(session: URLSession, challenge: URLAuthenticationChallenge) -> (URLSession.AuthChallengeDisposition, URLCredential?) {
    
    let disposition = URLSession.AuthChallengeDisposition.useCredential
    var credential: URLCredential?
    
    //获取项目中P12证书文件的路径
    let path: String = Bundle.main.path(forResource: "haofenshu", ofType: "p12")!
    let PKCS12Data = NSData(contentsOfFile:path)!
    let key : NSString = kSecImportExportPassphrase as NSString
    let options : NSDictionary = [key : "123456"] //客户端证书密码
    
    var items: CFArray?
    let error = SecPKCS12Import(PKCS12Data, options, &items)
    
    if error == errSecSuccess {
        
        if let itemArr = items as? NSArray,
            let item = itemArr.firstObject as? Dictionary<String, AnyObject> {
            
            // grab the identity
            let identityPointer = item["identity"];
            let secIdentityRef = identityPointer as! SecIdentity
            
            // grab the trust
            // let trustPointer = item["trust"]
            // let trustRef = trustPointer as! SecTrust
            
            // grab the cert
            let chainPointer = item["chain"]
            let chainRef = chainPointer as? [Any]
            
            // persistence: Credential should be stored only for this session
            credential = URLCredential.init(identity: secIdentityRef, certificates: chainRef, persistence: URLCredential.Persistence.forSession)
            
        }
        
    }
    
    return (disposition, credential)
}

let selfSignedHosts = ["yue.haofenshu.com"]

func selfSignedTrust(session: URLSession, challenge: URLAuthenticationChallenge) -> (URLSession.AuthChallengeDisposition, URLCredential?) {
    
    var disposition: URLSession.AuthChallengeDisposition = .performDefaultHandling
    var credential: URLCredential?
    
    if selfSignedHosts.contains(challenge.protectionSpace.host) {
        
        disposition = URLSession.AuthChallengeDisposition.useCredential
        credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
        
    }
    
    return (disposition, credential)
}

