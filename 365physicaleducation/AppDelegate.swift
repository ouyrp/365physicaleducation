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

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        HTTP.request(ConfigApi())
            .asObservable()
            .mapModel(ConfigEntity.self)
            .subscribe(onNext: {
                print($0)
            }, onError: {
                print($0)
            }).disposed(by: DisposeBag())

        
        let tabbar = UITabBarController()
        
        tabbar.viewControllers = [
            UINavigationController(rootViewController: ViewController()),
            UINavigationController(rootViewController: JokeViewController())
        ]
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabbar
        window?.makeKeyAndVisible()
        
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

