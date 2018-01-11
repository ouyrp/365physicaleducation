//
//  AppDelegate.swift
//  365physicaleducation
//
//  Created by ouyang on 2017/12/14.
//  Copyright © 2017年 ouyang. All rights reserved.
//

import UIKit
import RxSwift
import UserNotifications

let appKey = "77eb4635421dd411e5b24208"
let channel = "APP STORE"
let isProduction = true

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, JPUSHRegisterDelegate {
    
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
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabbar
        window?.makeKeyAndVisible()
        
        HTTP.request(ConfigApi())
            .asObservable()
            .mapModel(ConfigEntity.self)
            .subscribe(onNext: {
                [weak self] in
                if let strongSelf = self {
                    if $0.on_status == "1" {
                        let webcontroller = OUYWebViewController()
                        webcontroller.gankURL = $0.on_url
                        webcontroller.czUrl = $0.cz_url
                        webcontroller.btoomerHidden = true
                        strongSelf.window?.rootViewController?.present(webcontroller, animated: false, completion: nil)
                    }
                }
                print($0)
                }, onError: {
                    print($0)
            }).disposed(by: disposeBag)
        
        if #available(iOS 10, *) {
            let entity = JPUSHRegisterEntity()
            entity.types = NSInteger(UNAuthorizationOptions.alert.rawValue) |
                NSInteger(UNAuthorizationOptions.sound.rawValue) |
                NSInteger(UNAuthorizationOptions.badge.rawValue)
            JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
            
        } else if #available(iOS 8, *) {
            // 可以自定义 categories
            JPUSHService.register(
                forRemoteNotificationTypes: UIUserNotificationType.badge.rawValue |
                    UIUserNotificationType.sound.rawValue |
                    UIUserNotificationType.alert.rawValue,
                categories: nil)
        } else {
            // ios 8 以前 categories 必须为nil
            JPUSHService.register(
                forRemoteNotificationTypes: UIRemoteNotificationType.badge.rawValue |
                    UIRemoteNotificationType.sound.rawValue |
                    UIRemoteNotificationType.alert.rawValue,
                categories: nil)
        }
        
        JPUSHService.setup(withOption: launchOptions, appKey: appKey, channel: channel, apsForProduction: isProduction)
        return true
    }
    
    
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        
        //    let userInfo = response.notification.request.content.userInfo
        //    let request = response.notification.request // 收到推送的请求
        //    let content = request.content // 收到推送的消息内容
        //
        //    let badge = content.badge // 推送消息的角标
        //    let body = content.body   // 推送消息体
        //    let sound = content.sound // 推送消息的声音
        //    let subtitle = content.subtitle // 推送消息的副标题
        //    let title = content.title // 推送消息的标题
        let userInfo = response.notification.request.content.userInfo;
        if userInfo.keys .contains("url" as NSObject) {
            if let url = userInfo["url" as NSObject] {
                noticeWebPush(url: url as! String)
            }
        }
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!,
                                 withCompletionHandler completionHandler: ((Int) -> Void)!) {
        //    let userInfo = notification.request.content.userInfo
        //
        //    let request = notification.request // 收到推送的请求
        //    let content = request.content // 收到推送的消息内容
        //
        //    let badge = content.badge // 推送消息的角标
        //    let body = content.body   // 推送消息体
        //    let sound = content.sound // 推送消息的声音
        //    let subtitle = content.subtitle // 推送消息的副标题
        //    let title = content.title // 推送消息的标题
        let userInfo = notification.request.content.userInfo
        if userInfo.keys .contains("url" as NSObject) {
            if let url = userInfo["url" as NSObject] {
                noticeWebPush(url: url as! String)
            }
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0
        application.cancelAllLocalNotifications()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("get the deviceToken  \(deviceToken)")
        NotificationCenter.default.post(name: Notification.Name(rawValue: "DidRegisterRemoteNotification"), object: deviceToken)
        JPUSHService.registerDeviceToken(deviceToken)
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("did fail to register for remote notification with error ", error)
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        JPUSHService.handleRemoteNotification(userInfo)
        print("受到通知", userInfo)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "AddNotificationCount"), object: nil)  //把  要addnotificationcount
        if userInfo.keys .contains("url" as NSObject) {
            if let url = userInfo["url" as NSObject] {
                noticeWebPush(url: url as! String)
            }
        }
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        JPUSHService.showLocalNotification(atFront: notification, identifierKey: nil)
    }
    
    @available(iOS 7, *)
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        
    }
    
    @available(iOS 7, *)
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, completionHandler: @escaping () -> Void) {
        
    }
    
    @available(iOS 7, *)
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [AnyHashable: Any], withResponseInfo responseInfo: [AnyHashable: Any], completionHandler: @escaping () -> Void) {
        if userInfo.keys .contains("url" as NSObject) {
            if let url = userInfo["url" as NSObject] {
                noticeWebPush(url: url as! String)
            }
        }
    }
    
    // 清除badge 和 通知栏的信息
    func applicationWillEnterForeground(application: UIApplication) {
        application.applicationIconBadgeNumber = 0
        application.cancelAllLocalNotifications()
    }
    
    private func noticeWebPush(url: String) {
        let controller = OUYWebViewController()
        controller.gankURL = url
        window?.rootViewController?.present(controller, animated: true, completion: nil)
    }
    
}

