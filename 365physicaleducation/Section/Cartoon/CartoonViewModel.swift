//
//  CartoonViewModel.swift
//  365physicaleducation
//
//  Created by sunny on 2017/12/21.
//  Copyright © 2017年 ouyang. All rights reserved.
//

import Foundation
import RxSwift

final class CartoonViewModel {
    
    var bag = DisposeBag()
    let type: CartoonType
    var output: PublishSubject<Bool> = PublishSubject()

    init(_ type: CartoonType) {
        self.type = type
    }

    private var currantPage: Int = 1
    
    func load(_ more: Bool = false) {
        
        if more {
            currantPage += 1
        } else {
            currantPage = 1
        }
        
        HTTP.request(CartoonAPI(with: currantPage))
            .asObservable()
//            .mapArray(JokeEntity.self, path: "showapi_res_body.contentlist")
            .mapJSON()
            .subscribe(onNext: { [weak self] _ in
                
//                if more {
//                    self?.jokeList.append(contentsOf: $0)
//                } else {
//                    self?.jokeList = $0
//                }
//                self?.output.onNext(true)
//
                }, onError: { [weak self] in
                    
                    print($0)
                    self?.output.onNext(false)
                    
            }).disposed(by: bag)
    }
    
}
