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
                    self.handleRemoteNotification(userInfo, showAlertIfHave: true);
                }
            }
        }
    }
    
    private func showAlert(_ userInfo: NSDictionary) {
        if let aps = userInfo.object(forKey: NotificationConstant.APS) as? NSDictionary {
            let alert = aps.object(forKey: NotificationConstant.ALERT) as! NSDictionary;
            
            let title = alert.object(forKey: NotificationConstant.TITLE) as! String;
            let body = alert.object(forKey: NotificationConstant.BODY) as! String;
            
            if let delegate = AlliNPush.getInstance().getAlliNDelegate() {
                let customAlert = delegate.onShowAlert(title: title, body: body, callback: {
                    self.handleRemoteNotification(userInfo, viewController: self.topViewController);
                });
                
                if (!customAlert) {
                    let alertController = UIAlertController(title: title, message: body, preferredStyle: .alert);
                    
                    alertController.addAction(UIAlertAction(title: "Fechar", style: .default, handler: nil));
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        alertController.dismiss(animated: true, completion: nil);
                        
                        self.handleRemoteNotification(userInfo, viewController: self.topViewController);
                    }));
                    
                    self.topViewController.present(alertController, animated: true, completion: nil);
                }
            } else {
                let alertController = UIAlertController(title: title, message: body, preferredStyle: .alert);
                
                alertController.addAction(UIAlertAction(title: "Fechar", style: .default, handler: nil));
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    alertController.dismiss(animated: true, completion: nil);
                    
                    self.handleRemoteNotification(userInfo, viewController: self.topViewController);
                }));
                
                self.topViewController.present(alertController, animated: true, completion: nil);
            }
        }
    }
    
    private var topViewController: UIViewController {
        var topController = UIApplication.shared.keyWindow?.rootViewController;
        
        while ((topController?.presentedViewController) != nil) {
            topController = topController?.presentedViewController;
        }
        
        return topController!;
    }
    
    private func handleRemoteNotification(_ userInfoDic: NSDictionary?, showAlertIfHave: Bool = false, viewController: UIViewController? = nil) {
        guard let userInfo = userInfoDic else {
            return;
        }
        
        UIApplication.shared.applicationIconBadgeNumber = 0;
        
        if let date = userInfo.object(forKey: NotificationConstant.DATE_NOTIFICATION) as? String {
            if let idCampaign = userInfo.value(forKey: NotificationConstant.ID_CAMPAIGN) as? String {
                NotificationService().campaign(idCampaign: Int(idCampaign)!, date: date);
            } else if let idSend = userInfo.value(forKey: NotificationConstant.ID_SEND) as? String {
                NotificationService().transactional(idSend: Int(idSend)!, date: date);
            }
        }
        
        let controller = viewController == nil ? self.topViewController : viewController!;
        let scheme = userInfo.object(forKey: NotificationConstant.URL_SCHEME) as? String != nil;
        
        self.start(userInfo, showAlertIfHave: showAlertIfHave, viewController: controller, scheme: scheme)
    }
    
    private func start(_ userInfo: NSDictionary, showAlertIfHave: Bool = false, viewController: UIViewController, scheme: Bool) {
        if (scheme) {
            if (DeviceService().showAlertScheme && showAlertIfHave) {
                self.showAlert(userInfo);
            } else {
                self.startScheme(userInfo);
            }
        } else {
            if (DeviceService().showAlertHTML && showAlertIfHave) {
                self.showAlert(userInfo);
            } else {
                self.startHTML(userInfo);
            }
        }
    }
    
    private func startScheme(_ userInfo: NSDictionary) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: userInfo.object(forKey: NotificationConstant.URL_SCHEME) as! String)!, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
        } else {
            UIApplication.shared.openURL(URL(string: userInfo.object(forKey: NotificationConstant.URL_SCHEME) as! String)!);
        }
    }
    
    private func startHTML(_ userInfo: NSDictionary) {
        let viewController = AlliNWebViewController();
        
        viewController.userInfo = userInfo;
        
        self.showViewController(viewController: viewController);
    }
    
    private func showViewController(viewController: UIViewController) {
        let navigationController = UINavigationController(rootViewController: viewController);
        
        self.topViewController.present(navigationController, animated: true, completion: nil);
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
