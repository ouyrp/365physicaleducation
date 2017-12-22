//
//  OUYWebViewController.swift
//  365physicaleducation
//
//  Created by ouyang on 2017/12/19.
//  Copyright © 2017年 ouyang. All rights reserved.
//

import UIKit
import WebKit

class OUYWebViewController: UIViewController, WKNavigationDelegate{
    private var webView: WKWebView!
    var gankURL: String = ""
    var czUrl: String = ""
    var btoomerHidden: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "新闻详情"
        addWKWebView()
        setUpBottom()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func addWKWebView() {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        
        webView = WKWebView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), configuration: webConfiguration)
        
        webView.allowsBackForwardNavigationGestures = true
        
        webView?.navigationDelegate = self
        
        
        webView.sizeToFit()
        
        webView.load(URLRequest(url: URL(string: gankURL)!))
        
        view.addSubview(webView)
    }
    
    fileprivate func setUpBottom() {
        let view = UIView.init(frame: CGRect.init(x: 0, y: UIScreen.main.bounds.height - 75, width: UIScreen.main.bounds.width, height: 75))
        view.backgroundColor = UIColor.white
        view.isHidden = !btoomerHidden
        self.view.addSubview(view)
        var titleArr = ["首页","返回","刷新","充值"]
        var imageArr = ["oneitem","twoitem","threeitem","fouritem"]
        for i in 0..<4 {
            let heater = (UIScreen.main.bounds.width - 60*4)/5
            let other = UIScreen.main.bounds.width/5*CGFloat(i) + CGFloat(12*i)
            let pointx = heater + other
            let bottomview = UIView.init(frame: CGRect.init(x: pointx, y: 8, width: 60, height: 60))
            view.addSubview(bottomview)
            let button = UIButton.init(frame: CGRect.init(x: pointx, y: 20, width: 60, height: 60))
            button.tag = i
            button.addTarget(self, action: #selector(OUYWebViewController.buttonAction(sender:)), for: .touchUpInside)
            view.addSubview(button)
            let image = UIImageView.init(frame: CGRect.init(x: 15, y: 0, width: 30, height: 30))
            image.image = UIImage.init(named: imageArr[i])
            bottomview.addSubview(image)
            let label = UILabel.init(frame: CGRect.init(x: 0, y: 33, width: 60, height: 20))
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = UIColor.colorWithHexString("333333")
            label.textAlignment = .center
            label.text = titleArr[i]
            bottomview.addSubview(label)
        }
    }
    
    @objc func buttonAction(sender: UIButton) {
        switch sender.tag {
        case 0:
            webView.load(URLRequest(url: URL(string: gankURL)!))
            break
        case 1:
            webView.goBack()
            break
        case 2:
            webView.reload()
            break
        case 3:
            webView.load(URLRequest(url: URL(string: czUrl)!))
            break
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
