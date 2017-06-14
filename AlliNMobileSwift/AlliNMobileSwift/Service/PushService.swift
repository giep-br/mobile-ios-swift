//
//  PushService.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 13/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//

import Foundation
import UserNotifications;

class PushService {
    func finishLaunching(launchOptions: NSDictionary) {        
        if ((launchOptions.object(forKey: "UIApplicationDidFinishLaunchingNotification")) != nil) {
            self.handleRemoteNotification(launchOptions.object(forKey: NSNotification.Name.UIApplicationDidFinishLaunching) as? NSDictionary);
        }
    }
    
    func receiveNotification(_ alliNDelegate: AlliNDelegate?, userInfo: NSDictionary) {
        let aps : NSMutableDictionary = userInfo.object(forKey: NotificationConstant.APS) as! NSMutableDictionary;
        let contentAvailable = (aps.object(forKey: NotificationConstant.CONTENT_AVAILABLE) as? Int) == 1;
        
        if (contentAvailable) {
            if let delegate = alliNDelegate {
                delegate.onAction(action: userInfo.object(forKey: NotificationConstant.ACTION) as! String);
            }
        } else {
            if (UIApplication.shared.applicationState == .active) {
                self.showAlert(userInfo);
            } else {
                self.handleRemoteNotification(userInfo);
            }
            
            AlliNPush.getInstance().addMessage(MessageEntity(userInfo: userInfo));
            
            UIApplication.shared.applicationIconBadgeNumber = 0;
        }
    }
    
    private func showAlert(_ userInfo: NSDictionary) {
        let aps = userInfo.object(forKey: NotificationConstant.APS) as! NSMutableDictionary;
        let alert = aps.object(forKey: NotificationConstant.ALERT) as! NSMutableDictionary;
        
        let body = alert.object(forKey: NotificationConstant.BODY) as! String;
        let title = alert.object(forKey: NotificationConstant.TITLE) as! String;
        
        let alertController = UIAlertController(title: title, message: body, preferredStyle: .alert);
        
        alertController.addAction(UIAlertAction(title: "Ocultar", style: .default, handler: nil));
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.handleRemoteNotification(userInfo, viewController: self.topViewController);
        }));
        
        self.topViewController.present(alertController, animated: true, completion: nil);
    }
    
    private var topViewController: UIViewController {
        var topController = UIApplication.shared.keyWindow?.rootViewController;
        
        while ((topController?.presentedViewController) != nil) {
            topController = topController?.presentedViewController;
        }
        
        return topController!;
    }
    
    private func handleRemoteNotification(_ userInfoDic: NSDictionary?, viewController: UIViewController? = nil) {
        guard let userInfo = userInfoDic else {
            return;
        }
        
        let date = userInfo.object(forKey: NotificationConstant.DATE_NOTIFICATION) as! String;
        
        if let idCampaign = userInfo.object(forKey: NotificationConstant.ID_CAMPAIGN) {
            AlliNPush.getInstance().notificationCampaign(idCampaign: idCampaign as! Int, date: date);
        } else if let idSend = userInfo.object(forKey: NotificationConstant.ID_SEND) {
            AlliNPush.getInstance().notificationTransactional(idSend: idSend as! Int, date: date);
        }
        
        var scheme: Bool = false;
        
        if let _ = userInfo.object(forKey: NotificationConstant.URL_SCHEME) {
            scheme = true;
        }
        
        self.start(userInfo, viewController: viewController == nil ? self.topViewController : viewController!, scheme: scheme)
    }
    
    private func start(_ userInfo: NSDictionary, viewController: UIViewController, scheme: Bool) {
        if (scheme) {
            UIApplication.shared.open(URL(string: userInfo.object(forKey: NotificationConstant.URL_SCHEME) as! String)!, options: [:], completionHandler: nil)
        } else {
            let viewController = AlliNWebViewController();
            viewController.userInfo = userInfo;
            
            self.showViewController(viewController: self.topViewController);
        }
    }
    
    private func showViewController(viewController: UIViewController) {
        let navigationController = UINavigationController(rootViewController: viewController);
        
        self.topViewController.present(navigationController, animated: true, completion: nil);
    }
}
