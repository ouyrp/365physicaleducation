//
//  CartoonViewController.swift
//  365physicaleducation
//
//  Created by sunny on 2017/12/21.
//  Copyright © 2017年 ouyang. All rights reserved.
//

import UIKit

class CartoonController: WMPageController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        preloadPolicy       = .near
        pageAnimatable      = false
        menuViewStyle       = .line
        titleSizeSelected   = self.titleSizeNormal
        showOnNavigationBar = false
        dataSource          = self
        titles = [
            "恐怖","故事","段子手","冷知识",
            "奇趣","电影","搞笑","萌宠","新奇",
            "环球","摄影","玩艺","插画"]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "黑白漫画"
    }
}

extension CartoonController {
    override func numbersOfChildControllers(in pageController: WMPageController) -> Int {
        return titles!.count
    }
    override func pageController(_ pageController: WMPageController, titleAt index: Int) -> String {
        return titles![index]
    }
    override func pageController(_ pageController: WMPageController, viewControllerAt index: Int) -> UIViewController {
        var type: CartoonType = .chahua
        switch index {
        case 0: type = .kongbu
        case 1: type = .gushi
        case 2: type = .duanzi
        case 3: type = .lenzhishi
        case 4: type = .qiqu
        case 5: type = .dianying
        case 6: type = .gaoxiao
        case 7: type = .mengchong
        case 8: type = .xinqi
        case 9: type = .huanqiu
        case 10: type = .sheying
        case 11: type = .wanyi
        case 12: type = .chahua
        default: type = .chahua
        }
        print(type)
        return CartoonViewController(type)
    }
}

