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
    
    func load(_ more: Bool = false) {
        
        HTTP.request(JokeAPI())
            .asObservable()
            .mapJSON()
            .subscribe(onNext: { _  in
                
            }, onError: { _ in
                
            }).disposed(by: bag)
        
        
    }
    
    
}
