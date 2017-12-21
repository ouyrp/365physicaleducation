//
//  CartoonViewController.swift
//  365physicaleducation
//
//  Created by sunny on 2017/12/21.
//  Copyright © 2017年 ouyang. All rights reserved.
//

import UIKit

class CartoonController: UIViewController {
    
    var slideTabKit: SlideTabKit = SlideTabKit()
    var vcs: [UIViewController] = []
    var titles: [String] =
        ["恐怖漫画","故事漫画","段子手","冷知识",
         "奇趣","电影","搞笑","萌宠","新奇",
         "环球","摄影","玩艺","插画"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "黑白漫画"
        
        titles.forEach { _ in
            let vc = CartoonViewController(.kongbu)
            vc.view.backgroundColor = UIColor.randomColor
            vcs.append(vc)
        }
        
        view.addSubview(slideTabKit.slideTabBar)
        slideTabKit.slideTabBar.snp.makeConstraints { (make) in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.left.right.equalTo(view)
            make.height.equalTo(40)
        }
        slideTabKit.slideTabBar.resetting(titles: titles)
        
        view.addSubview(slideTabKit.slideScrollView)
        slideTabKit.slideScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(slideTabKit.slideTabBar.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
        slideTabKit.slideScrollView.resetting(childViews: vcs.map({ (vc) -> UIView in
            return vc.view
        }))
    }
}
