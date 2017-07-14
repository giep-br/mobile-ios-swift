//
//  PushFactoryDelegate.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 13/07/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//

import Foundation;
import UserNotifications;

public class PushFactoryDelegate : NSObject, UNUserNotificationCenterDelegate {
    private var keys: [String]?;
    private var alliNDelegate: AlliNDelegate?;
    private var clickNotification: (() -> Void)?;
    
    public init(alliNDelegate: AlliNDelegate?) {
        self.alliNDelegate = alliNDelegate;
    }
    
    public func setCallback(_ clickNotification: (() -> Void)?) {
        self.clickNotification = clickNotification;
    }
    
    public func setKeys(_ keys: [String]) {
        self.keys = keys;
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        Log.add("didReceive");
        
        if let keys = self.keys {
            if (keys.contains(response.actionIdentifier)) {
                self.alliNDelegate?.onAction(action: response.actionIdentifier, fromServer: false);
            } else {
                self.clickNotification?();
            }
        }
        
        completionHandler();
    }
}
