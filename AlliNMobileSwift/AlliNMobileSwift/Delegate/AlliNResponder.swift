//
//  AlliNResponder.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 13/07/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//

import Foundation

import UserNotifications;

open class AlliNResponder : UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    var alliNDelegate: AlliNDelegate?;
    
    open func application(_ application: UIApplication, alliNDelegate: AlliNDelegate, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        self.alliNDelegate = alliNDelegate;
        
        AlliNPush.initInstance();
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self;
        }
        
        return true;
    }
    
    @available(iOS 10.0, *)
    open func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler();
        
        if let pushFactory = PushFactory.getInstance() {
            pushFactory.notificationClick(response.actionIdentifier);
        }
    }
    
    open func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        completionHandler(.newData);
        
        AlliNPush.getInstance().receiveNotification(alliNDelegate, userInfo: userInfo as NSDictionary);
    }
    
    private var executed : Bool = false;
    
    open func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let configuration = try! ConfigurationEntity(deviceToken: deviceToken);
        
        if (!self.executed) {
            self.executed = true;
            
            AlliNPush.getInstance().configure(configuration);
        }
    }
}
