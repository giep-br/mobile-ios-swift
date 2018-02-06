//
//  AlliNPush.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 09/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
import CoreLocation;
import UserNotifications;

public class AlliNPush {
    private static var locationManager: CLLocationManager? = nil;
    private static var alliNPush: AlliNPush? = nil;
    
    public var deviceToken : String {
        if let token = DeviceService().deviceToken {
            return token;
        }
        
        return "";
    }
    
    public var userEmail : String {
        if let email = DeviceService().userEmail {
            return email;
        }
        
        return "";
    }
    
    public static func initInstance() {
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
    }

    public static func getInstance() -> AlliNPush {
        AlliNPush.initInstance();
        
        if (AlliNPush.alliNPush == nil) {
            AlliNPush.alliNPush = AlliNPush();
        }
        
        return AlliNPush.alliNPush!;
    }
    
    public func receiveNotification(_ alliNDelegate: AlliNDelegate?, userInfo: NSDictionary) {
        PushService().receiveNotification(alliNDelegate, userInfo: userInfo);
    }
    
    public func getLocationManager() -> CLLocationManager {
        return AlliNPush.locationManager!;
    }

    public func configure(_ configuration: ConfigurationEntity, completion: ((Any?, HttpRequestError?) -> Void)? = nil) {
        ConfigurationService().configure(configuration, completion: completion);
    }
    
    public func disable() {
        StatusService().disable();
    }
    
    public func enable() {
        StatusService().enable();
    }
    
    public func isEnable(completion: ((Any?, HttpRequestError?) -> Void)? = nil) {
        StatusService().deviceIsEnable(completion);
    }
    
    public func registerEmail(_ email: String) {
        DeviceService().registerEmail(email);
    }
    
    public func sendList(name: String, columnsAndValues: NSDictionary) {
        DeviceService().sendList(nameList: name, columnsAndValues: columnsAndValues);
    }

    public func logout(completion: ((Any?, HttpRequestError?) -> Void)? = nil) {
        DeviceService().logout(completion);
    }
    
    public func addMessage(_ message: MessageEntity) {
        MessageService().add(messageEntity: message);
    }
    
    public func deleteMessage(_ idMessage: Int) {
        MessageService().delete(id: idMessage);
    }
    
    public func getMessages() -> [MessageEntity]? {
        return MessageService().get();
    }
}
