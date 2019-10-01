//
//  AlliNResponder.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 13/07/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//

import Foundation
import UserNotifications;

open class AlliNResponder : UIResponder, UIApplicationDelegate {
    open func application(_ application: UIApplication, alliNDelegate: AlliNDelegate, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        AlliNPush.registerForPushNotifications();
        AlliNPush.getInstance().setAlliNDelegate(alliNDelegate: alliNDelegate);
        
        return true;
    }
    
    @available(iOS 10.0, *)
    open func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler();
        
        if let pushFactory = PushFactory.getInstance() {
            pushFactory.notificationClick(response.actionIdentifier);
        }
    }

    open func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        if let delegate = AlliNPush.getInstance().getAlliNDelegate() {
            AlliNPush.getInstance().receiveNotification(delegate, userInfo: userInfo as NSDictionary);
        }
    }
    
    open func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        completionHandler(.newData);
        
        if let delegate = AlliNPush.getInstance().getAlliNDelegate() {
            AlliNPush.getInstance().receiveNotification(delegate, userInfo: userInfo as NSDictionary);
        }
    }
    
    private var executed : Bool = false
    
    open func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        if (!self.executed) {
            self.executed = true
            
            let configuration = try! ConfigurationEntity(deviceToken: deviceToken)
            
            AlliNPush.getInstance().configure(configuration);
        }
    }
}
