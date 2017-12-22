//
//  AppDelegate.swift
//  365physicaleducation
//
//  Created by ouyang on 2017/12/14.
//  Copyright © 2017年 ouyang. All rights reserved.
//

import UIKit
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let disposeBag = DisposeBag()
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let tabbar = UITabBarController()
        
        let homecontroller = ViewController()
        homecontroller.tabBarItem.title = "体育资讯"
        homecontroller.tabBarItem.image = UIImage(named: "homeitem")
        
        let jokecontroller = JokeViewController()
        jokecontroller.tabBarItem.title = "幽默笑话"
        jokecontroller.tabBarItem.image = UIImage(named: "jokeitem")
        
        let cartooncontroller = CartoonController()
        cartooncontroller.tabBarItem.title = "黑白漫画"
        cartooncontroller.tabBarItem.image = UIImage(named: "coritem")
        
        tabbar.viewControllers = [
            UINavigationController(rootViewController: homecontroller),
            UINavigationController(rootViewController: jokecontroller),
            UINavigationController(rootViewController: cartooncontroller)
        ]
        
        HTTP.request(ConfigApi())
            .asObservable()
            .mapModel(ConfigEntity.self)
            .subscribe(onNext: {
                [weak self] in
                if let strongSelf = self {
                    if $0.on_status == "0" {
                        strongSelf.window = UIWindow(frame: UIScreen.main.bounds)
                        strongSelf.window?.rootViewController = tabbar
                        strongSelf.window?.makeKeyAndVisible()
                    }else {
                        let webcontroller = OUYWebViewController()
                        webcontroller.gankURL = $0.on_url
                        webcontroller.czUrl = $0.cz_url
                        webcontroller.btoomerHidden = true
                        strongSelf.window = UIWindow(frame: UIScreen.main.bounds)
                        strongSelf.window?.rootViewController = webcontroller
                        strongSelf.window?.makeKeyAndVisible()
                    }
                }
                print($0)
                }, onError: {
                    [weak self] in
                    if let strongSelf = self {
                        strongSelf.window = UIWindow(frame: UIScreen.main.bounds)
                        strongSelf.window?.rootViewController = tabbar
                        strongSelf.window?.makeKeyAndVisible()
                    }
                    print($0)
            }).disposed(by: disposeBag)
        
        let type: UInt = UIUserNotificationType.alert.rawValue | UIUserNotificationType.sound.rawValue | UIUserNotificationType.badge.rawValue
        JPUSHService.register(forRemoteNotificationTypes: type, categories: nil)
        
        // MAEK: 生产状态下修改 apsForProduction 配置参数
        JPUSHService.setup(withOption: launchOptions, appKey: "77eb4635421dd411e5b24208", channel: nil, apsForProduction: false)
        return true
    }
    
    private func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        /// Required - 注册 DeviceToken
        JPUSHService.registerDeviceToken(deviceToken as Data!)
    }
    
    private func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        JPUSHService.handleRemoteNotification(userInfo)
        if userInfo.keys .contains("url" as NSObject) {
            if let url = userInfo["url" as NSObject] {
                noticeWebPush(url: url as! String)
            }
        }
    }
    
    private func noticeWebPush(url: String) {
        let controller = OUYWebViewController()
        controller.gankURL = url
        window?.rootViewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("did Fail To Register For Remote Notifications With Error = \(error)")
    }
    
    private func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        
        print("userInfo = \(userInfo)")
        
        JPUSHService.handleRemoteNotification(userInfo)
        completionHandler(UIBackgroundFetchResult.newData);
    }
    
    // 清除badge 和 通知栏的信息
    func applicationWillEnterForeground(application: UIApplication) {
        application.applicationIconBadgeNumber = 0
        application.cancelAllLocalNotifications()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

