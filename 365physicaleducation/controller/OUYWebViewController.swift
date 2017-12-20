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
    var webView: WKWebView!
    public var gankURL: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "新闻详情"
        addWKWebView()
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
