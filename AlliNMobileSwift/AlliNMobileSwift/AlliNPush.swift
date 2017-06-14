//
//  AlliNPush.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 09/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
import CoreLocation;

class AlliNPush {
    private static var locationManager: CLLocationManager? = nil;
    
    static func getInstance() -> AlliNPush {
        if (AlliNPush.locationManager == nil) {
            AlliNPush.locationManager = CLLocationManager();
        }
        
        AlliNPush.locationManager?.requestWhenInUseAuthorization();
        
        return AlliNPush();
    }
    
    static func getLocationManager() -> CLLocationManager {
        return AlliNPush.locationManager!;
    }
    
    static var deviceToken : String {
        return "";
    }
    
    static var userEmail : String {
        return "";
    }
    
    func sendDeviceInfo(deviceEntity: DeviceEntity, completion: @escaping (Any?, HttpRequestError?) -> Void) {
    }
}
