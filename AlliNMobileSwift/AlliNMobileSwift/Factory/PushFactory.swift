//
//  PushFactory.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 28/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//

import Foundation;
import UserNotifications;

class PushFactory : NSObject, UNUserNotificationCenterDelegate {
    private var alliNDelegate : AlliNDelegate;
    private var keys: [String] = [];
    private var clickNotification: (() -> Void)?;
    
    init(_ alliNDelegate : AlliNDelegate) {
        self.alliNDelegate = alliNDelegate;
        
        super.init();
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (accept, error) in
            if (!accept) {
                print("[PUSH] User denied notification");
            }
        }
        
        UNUserNotificationCenter.current().delegate = self;
    }
    
    func showNotification(userInfo: NSDictionary, _ clickNotification: @escaping () -> Void) {
        self.clickNotification = clickNotification;
        
        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: Date(timeInterval: 61.0, since: Date()).dateComponents, repeats: false);
        let body = userInfo.object(forKey: NotificationConstant.BODY) as! String;
        let title = userInfo.object(forKey: NotificationConstant.TITLE) as! String;
        var actions: [UNNotificationAction] = [];
        
        if let actionsList = userInfo.object(forKey: NotificationConstant.ACTION) as? [NSDictionary] {
            actions = self.addActions(actionsList);
        }
        
        let notificationContent = UNMutableNotificationContent();
        notificationContent.title = title;
        notificationContent.body = body;
        notificationContent.sound = UNNotificationSound.default();
        notificationContent.categoryIdentifier = NotificationConstant.ALLIN_CATEGORY;
        
        let notificationCategory = UNNotificationCategory(identifier: NotificationConstant.ALLIN_CATEGORY, actions: actions, intentIdentifiers: [], options: []);
        let notificationRequest = UNNotificationRequest(identifier: NotificationConstant.ALLIN_REQUEST, content: notificationContent, trigger: notificationTrigger);
        
        UNUserNotificationCenter.current().setNotificationCategories([notificationCategory]);
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests();
        UNUserNotificationCenter.current().add(notificationRequest, withCompletionHandler: nil);
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.badge]);
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if (self.keys.contains(response.actionIdentifier)) {
            alliNDelegate.onAction(action: response.actionIdentifier, fromServer: false);
        } else {
            clickNotification!();
        }
    }
    
    private func addActions(_ actions: [NSDictionary]?) -> [UNNotificationAction] {
        var notificationActions: [UNNotificationAction] = [];
        
        if let actionsArray = actions {
            for action in actionsArray {
                let identifier = action[ActionConstant.ACTION] as! String;
                let title = action[ActionConstant.TEXT] as! String;
                
                notificationActions.append(UNNotificationAction(identifier: identifier, title: title, options: [.foreground]))
                
                self.keys.append(identifier);
            }
        }
        
        return notificationActions;
    }
}
