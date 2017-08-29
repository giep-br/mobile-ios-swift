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
    func receiveNotification(_ alliNDelegate: AlliNDelegate?, userInfo: NSDictionary) {
        if let aps = userInfo.object(forKey: NotificationConstant.APS) as? NSDictionary {
            let contentAvailable = (aps.object(forKey: NotificationConstant.CONTENT_AVAILABLE) as? Int) == 1;
            
            if (contentAvailable) {                
                if let _ = userInfo.object(forKey: NotificationConstant.SHOW_NOTIFICATION) as? Bool {
                    if (UIApplication.shared.applicationState == .active) {
                        self.showAlert(userInfo);
                    } else {
                        if #available(iOS 10.0, *) {
                            if let pushFactory = PushFactory.getInstance() {
                                pushFactory.showNotification(userInfo: userInfo, alliNDelegate: alliNDelegate) {
                                    self.handleRemoteNotification(userInfo);
                                }
                            }
                        }
                    }
                } else {
                    if let delegate = alliNDelegate {
                        delegate.onAction(action: userInfo.object(forKey: NotificationConstant.ACTION) as? String ?? "", fromServer: true);
                    }
                }
            } else {
                if (UIApplication.shared.applicationState == .active) {
                    self.showAlert(userInfo);
                } else {
                    self.handleRemoteNotification(userInfo);
                }
                
                AlliNPush.getInstance().addMessage(MessageEntity(userInfo: userInfo));
            }
        }
    }
    
    private func showAlert(_ userInfo: NSDictionary) {
        if let aps = userInfo.object(forKey: NotificationConstant.APS) as? NSDictionary {
            let alert = aps.object(forKey: NotificationConstant.ALERT) as! NSDictionary;
            
            let body = alert.object(forKey: NotificationConstant.BODY) as! String;
            let title = alert.object(forKey: NotificationConstant.TITLE) as! String;
            
            let alertController = UIAlertController(title: title, message: body, preferredStyle: .alert);
            
            alertController.addAction(UIAlertAction(title: "Ocultar", style: .default, handler: nil));
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                alertController.dismiss(animated: true, completion: nil);
                
                self.handleRemoteNotification(userInfo, viewController: self.topViewController);
            }));
            
            self.topViewController.present(alertController, animated: true, completion: nil);
        }
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
        
        UIApplication.shared.applicationIconBadgeNumber = 0;
        
        if let date = userInfo.object(forKey: NotificationConstant.DATE_NOTIFICATION) as? String {
            if let idCampaign = userInfo.value(forKey: NotificationConstant.ID_CAMPAIGN) as? String {
                AlliNPush.getInstance().notificationCampaign(idCampaign: Int(idCampaign)!, date: date);
            } else if let idSend = userInfo.value(forKey: NotificationConstant.ID_SEND) as? String {
                AlliNPush.getInstance().notificationTransactional(idSend: Int(idSend)!, date: date);
            }
        }
        
        self.start(userInfo, viewController: viewController == nil ? self.topViewController : viewController!, scheme: userInfo.object(forKey: NotificationConstant.URL_SCHEME) as? String != nil)
    }
    
    private func start(_ userInfo: NSDictionary, viewController: UIViewController, scheme: Bool) {
        if (scheme) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: userInfo.object(forKey: NotificationConstant.URL_SCHEME) as! String)!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(URL(string: userInfo.object(forKey: NotificationConstant.URL_SCHEME) as! String)!);
            }
        } else {
            let viewController = AlliNWebViewController();
            
            viewController.userInfo = userInfo;
            
            self.showViewController(viewController: viewController);
        }
    }
    
    private func showViewController(viewController: UIViewController) {
        let navigationController = UINavigationController(rootViewController: viewController);
        
        self.topViewController.present(navigationController, animated: true, completion: nil);
    }
}
