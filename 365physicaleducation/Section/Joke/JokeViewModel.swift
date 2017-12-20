//
//  JokeViewModel.swift
//  365physicaleducation
//
//  Created by sunny on 2017/12/20.
//  Copyright © 2017年 ouyang. All rights reserved.
//

import Foundation
import RxSwift

final class JokeViewModel {
    
    var bag = DisposeBag()
    var jokeList: [JokeEntity] = []
    var output: PublishSubject<Bool> = PublishSubject()
    
    private var currantPage: Int = 0
    func load(_ more: Bool = false) {
        
        if more {
            currantPage += 1
        } else {
            currantPage = 1
        }
        
        HTTP.request(JokeAPI(with: currantPage))
            .asObservable()
            .mapArray(JokeEntity.self, path: "showapi_res_body.contentlist")
            .subscribe(onNext: { [weak self] in
                
                if more {
                    self?.jokeList.append(contentsOf: $0)
                } else {
                    self?.jokeList = $0
                }
                self?.output.onNext(true)
                
            }, onError: { [weak self] in
                
                print($0)
                self?.output.onNext(false)
                
            }).disposed(by: bag)
        
        
    }
    
    
}


