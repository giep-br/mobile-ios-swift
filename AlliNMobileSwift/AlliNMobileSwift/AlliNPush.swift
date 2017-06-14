//
//  AlliNPush.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 09/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
import CoreLocation;
import UserNotifications;

class AlliNPush {
    private static var locationManager: CLLocationManager? = nil;
    private static var alliNPush: AlliNPush? = nil;
    
    var deviceToken : String {
        if let token = DeviceService().deviceToken {
            return token;
        }
        
        return "";
    }
    
    var userEmail : String {
        if let email = DeviceService().userEmail {
            return email;
        }
        
        return "";
    }
    
    static func getInstance() -> AlliNPush {
        if (AlliNPush.locationManager == nil) {
            AlliNPush.locationManager = CLLocationManager();
        }
        
        if #available(iOS 10, *) {
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in };
        } else {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil));
        }
        
        UIApplication.shared.registerForRemoteNotifications();
        
        AlliNPush.locationManager?.requestWhenInUseAuthorization();
        
        if (AlliNPush.alliNPush == nil) {
            AlliNPush.alliNPush = AlliNPush();
        }
        
        return AlliNPush.alliNPush!;
    }
    
    func receiveNotification(_ alliNDelegate: AlliNDelegate?, launchOptions: NSDictionary) {
    }
    
    func finishLaunching(_ delegate: UNUserNotificationCenterDelegate, launchOptions: NSDictionary) {
        UNUserNotificationCenter.current().delegate = delegate;
        
        PushService().finishLaunching(launchOptions: launchOptions)
    }
    
    func receiveNotification(_ alliNDelegate: AlliNDelegate?, userInfo: NSDictionary) {
        PushService().receiveNotification(alliNDelegate, userInfo: userInfo);
    }
    
    func getLocationManager() -> CLLocationManager {
        return AlliNPush.locationManager!;
    }

    func configure(_ configuration: ConfigurationEntity, completion: ((Any?, HttpRequestError?) -> Void)? = nil) {
        ConfigurationService().configure(configuration, completion: completion);
    }
    
    func disable(completion: ((Any?, HttpRequestError?) -> Void)? = nil) {
        StatusService().disable(completion);
    }
    
    func enable(completion: ((Any?, HttpRequestError?) -> Void)? = nil) {
        StatusService().enable(completion);
    }
    
    func isEnable(completion: ((Any?, HttpRequestError?) -> Void)? = nil) {
        StatusService().deviceIsEnable(completion);
    }
    
    func getCampaignHTML(id: Int, completion: ((Any?, HttpRequestError?) -> Void)? = nil) {
        CampaignService().getCampaignHTML(idCampaign: id, completion: completion);
    }
    
    func saveEmail(_ email: String, completion: ((Any?, HttpRequestError?) -> Void)? = nil) {
        DeviceService().saveEmail(email, completion: completion);
    }
    
    func sendDevice(_ device: DeviceEntity, completion: ((Any?, HttpRequestError?) -> Void)? = nil) {
        DeviceService().sendDevice(device, completion: completion);
    }
    
    func sendList(name: String, columnsAndValues: NSDictionary, completion: ((Any?, HttpRequestError?) -> Void)? = nil) {
        DeviceService().sendList(nameList: name, columnsAndValues: columnsAndValues, completion: completion);
    }

    func logout(completion: ((Any?, HttpRequestError?) -> Void)? = nil) {
        DeviceService().logout(completion);
    }
    
    func notificationCampaign(idCampaign: Int, date: String, completion: ((Any?, HttpRequestError?) -> Void)? = nil) {
        NotificationService().campaign(idCampaign: idCampaign, date: date, completion: completion);
    }
    
    func notificationTransactional(idSend: Int, date: String, completion: ((Any?, HttpRequestError?) -> Void)? = nil) {
        NotificationService().transactional(idSend: idSend, date: date, completion: completion);
    }
    
    func addMessage(_ message: MessageEntity) {
        MessageService().add(messageEntity: message);
    }
    
    func deleteMessage(_ idMessage: Int) {
        MessageService().delete(id: idMessage);
    }
    
    func getMessages() -> NSMutableArray? {
        return MessageService().get();
    }
}
