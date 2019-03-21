//
//  AlliNPush.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 09/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
//import CoreLocation;
import UserNotifications;

public class AlliNPush {
//    private static var locationManager: CLLocationManager? = nil;
    private static var alliNPush: AlliNPush? = nil;

    public static func getInstance() -> AlliNPush {
        AlliNPush.registerForPushNotifications();
        
        if (AlliNPush.alliNPush == nil) {
            AlliNPush.alliNPush = AlliNPush();
        }
        
        return AlliNPush.alliNPush!;
    }
    
    public static func registerForPushNotifications() {
//        if (AlliNPush.locationManager == nil) {
//            AlliNPush.locationManager = CLLocationManager();
//        }
        
        if #available(iOS 10, *) {
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in };
        } else {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil));
        }
        
        UIApplication.shared.registerForRemoteNotifications();
        
//        AlliNPush.locationManager?.requestWhenInUseAuthorization();
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
    
    public var email : String {
        return DeviceService().email;
    }
    
    public var deviceToken : String {
        return DeviceService().deviceToken;
    }
    
    public func setDeviceToken(_ deviceToken: String) {
        let sharedPreferences = PreferencesManager();
        
        sharedPreferences.store(deviceToken, key: PreferencesConstant.KEY_DEVICE_ID);
    }
    
    public var identifier : String {
        return DeviceService().identifier;
    }
    
    public func sendList(name: String, columnsAndValues: NSDictionary) {
        DeviceService().sendList(nameList: name, columnsAndValues: columnsAndValues);
    }
    
    public func logout(completion: ((Any?, HttpRequestError?) -> Void)? = nil) {
        DeviceService().logout(completion);
    }
    
    public func receiveNotification(_ alliNDelegate: AlliNDelegate?, userInfo: NSDictionary) {
        PushService().receiveNotification(alliNDelegate, userInfo: userInfo);
    }
    
//    public func getLocationManager() -> CLLocationManager {
//        return AlliNPush.locationManager!;
//    }

    public func configure(_ configuration: ConfigurationEntity, completion: ((Any?, HttpRequestError?) -> Void)? = nil) {
        ConfigurationService().configure(configuration, completion: completion);
    }
}
