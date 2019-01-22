//
//  PushFactory.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 28/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//

import Foundation;
import UserNotifications;

@available(iOS 10.0, *)
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
        if let image = userInfo.object(forKey: NotificationConstant.IMAGE) as? String, let url = URL(string: image) {
            guard let imageData = NSData(contentsOf: url) else {
                self.showNotificationComplete(userInfo, attachments: nil, alliNDelegate: alliNDelegate, clickNotification: clickNotification);
                
                return;
            }
            
            var attachments : [UNNotificationAttachment] = [];
            
            let dotIndex = image.range(of: ".", options: .backwards)?.lowerBound;
            let strLastCharacter = image.endIndex;
            let imageExtension = image[dotIndex!..<strLastCharacter];
            
            if let attachment = UNNotificationAttachment.create(imageFileIdentifier: "\(image.md5)\(imageExtension)", data: imageData, options: nil) {
                attachments.append(attachment);
            }
            
            self.showNotificationComplete(userInfo, attachments: attachments, alliNDelegate: alliNDelegate, clickNotification: clickNotification);
        } else {
            self.showNotificationComplete(userInfo, attachments: nil, alliNDelegate: alliNDelegate, clickNotification: clickNotification);
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0];
    }
    
    private func showNotificationComplete(_ userInfo: NSDictionary, attachments : [UNNotificationAttachment]?, alliNDelegate : AlliNDelegate?, clickNotification: @escaping () -> Void) {
        self.alliNDelegate = alliNDelegate;
        self.clickNotification = clickNotification;
        
        let idSend = userInfo.object(forKey: NotificationConstant.ID_SEND) ?? 1;
        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: Date(timeInterval: 61.0, since: Date()).dateComponents, repeats: false);
        
        let body = userInfo.object(forKey: NotificationConstant.BODY) as! String;
        let title = userInfo.object(forKey: NotificationConstant.TITLE) as! String;
        
        var actions: [UNNotificationAction] = [];
        
        if let actionsList = userInfo.object(forKey: NotificationConstant.ACTION) as? [NSDictionary] {
            actions = self.addActions("\(idSend)", actions: actionsList);
        }
        
        let notificationContent = UNMutableNotificationContent();
        notificationContent.title = title;
        notificationContent.body = body;
        notificationContent.sound = UNNotificationSound.default();
        notificationContent.categoryIdentifier = "\(idSend)-\(NotificationConstant.ALLIN_CATEGORY)";
        notificationContent.badge = 1;
        
        if let attachmentsNotification = attachments {
            notificationContent.attachments = attachmentsNotification;
        }
        
        let notificationCategory = UNNotificationCategory(identifier: "\(idSend)-\(NotificationConstant.ALLIN_CATEGORY)", actions: actions, intentIdentifiers: [], options: []);
        let notificationRequest = UNNotificationRequest(identifier: "\(idSend)-\(NotificationConstant.ALLIN_REQUEST)", content: notificationContent, trigger: notificationTrigger);
        
        self.notificationCenter.setNotificationCategories([notificationCategory]);
        self.notificationCenter.add(notificationRequest);
    }
    
    private func addActions(_ idSend: String, actions: [NSDictionary]?) -> [UNNotificationAction] {
        var notificationActions: [UNNotificationAction] = [];
        
        if let actionsArray = actions {
            for action in actionsArray {
                let identifier = action[ActionConstant.ACTION] as! String;
                let title = action[ActionConstant.TEXT] as! String;
                
                notificationActions.append(UNNotificationAction(identifier: "\(idSend)-\(identifier)", title: title, options: []))
                
                self.keys.append(identifier);
            }
        }
        
        return notificationActions;
    }
    
    public func notificationClick(_ actionIdentifier: String) {
        if (self.keys.contains(actionIdentifier)) {
            let dotIndex = actionIdentifier.range(of: ".", options: .literal)?.lowerBound;
            let strLastCharacter = actionIdentifier.endIndex;
            let action = actionIdentifier[dotIndex!..<strLastCharacter];
            
            self.alliNDelegate?.onAction(action: String(action), fromServer: false);
        } else {
            clickNotification?();
        }
    }
}
