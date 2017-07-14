//
//  PushFactory.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 28/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//

import Foundation;
import UserNotifications;

class PushFactory {
    private static var pushFactory: PushFactory?;
    
    public static func getInstance(_ clearInstance : Bool = false) -> PushFactory? {
        if (pushFactory == nil || clearInstance) {
            pushFactory = PushFactory();
        }
        
        return pushFactory;
    }
    
    private init() {
        self.alliNDelegate = nil;
        self.keys = [];
        self.clickNotification = nil;
    }
    
    private var alliNDelegate : AlliNDelegate?;
    private var keys: [String] = [];
    private var clickNotification: (() -> Void)?;
    private var notificationCenter = UNUserNotificationCenter.current();
    
    public func showNotification(userInfo: NSDictionary, alliNDelegate : AlliNDelegate?, _ clickNotification: @escaping () -> Void) {
//        var attachments : [UNNotificationAttachment] = [];
//        
//        if let image = userInfo.object(forKey: NotificationConstant.IMAGE) as? String {
//            let task = URLSession.shared.dataTask(with: URL(string: image)!, completionHandler: { (data, response, error) in
//                if (error == nil) {
//                    do {
//                        let imageUrl = URL(string: image);
//                        
//                        attachments.append(try UNNotificationAttachment(identifier: image, url: imageUrl!, options: nil));
//                    } catch let error {
//                        print("Error load image \(error)");
//                    }
//                }
//            });
//            
//            task.resume();
//        } else {
            self.showNotificationComplete(userInfo, attachments: nil, alliNDelegate: alliNDelegate, clickNotification: clickNotification);
//        }
    }
    
    private func showNotificationComplete(_ userInfo: NSDictionary, attachments : [UNNotificationAttachment]?, alliNDelegate : AlliNDelegate?, clickNotification: @escaping () -> Void) {
        self.alliNDelegate = alliNDelegate;
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
        
        if let _ = attachments {
            notificationContent.attachments = attachments!;
        }
        
        let notificationCategory = UNNotificationCategory(identifier: NotificationConstant.ALLIN_CATEGORY, actions: actions, intentIdentifiers: [], options: []);
        let notificationRequest = UNNotificationRequest(identifier: NotificationConstant.ALLIN_REQUEST, content: notificationContent, trigger: notificationTrigger);
        
        self.notificationCenter.setNotificationCategories([notificationCategory]);
        self.notificationCenter.removeAllPendingNotificationRequests();
        self.notificationCenter.add(notificationRequest);
    }
    
    private func addActions(_ actions: [NSDictionary]?) -> [UNNotificationAction] {
        var notificationActions: [UNNotificationAction] = [];
        
        if let actionsArray = actions {
            for action in actionsArray {
                let identifier = action[ActionConstant.ACTION] as! String;
                let title = action[ActionConstant.TEXT] as! String;
                
                notificationActions.append(UNNotificationAction(identifier: identifier, title: title, options: []))
                
                self.keys.append(identifier);
            }
        }
        
        return notificationActions;
    }
    
    public func notificationClick(_ actionIdentifier: String) {
        if (self.keys.contains(actionIdentifier)) {
            self.alliNDelegate?.onAction(action: actionIdentifier, fromServer: false);
        } else {
            clickNotification?();
        }
    }
}
