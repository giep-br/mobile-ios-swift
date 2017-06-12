//
//  LocationService.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 12/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//

import Foundation
import CoreLocation;

class LocationService: NSObject, CLLocationManagerDelegate {
    var stopped = false;
    
    var completion: ((Double, Double, LocationError?) -> Void)? = nil;
    
    func start(_ completion: @escaping (Double, Double, LocationError?) -> Void) {
        self.completion = completion;
        
        let locationManager = AlliNPush.getLocationManager();
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.startUpdatingLocation();
        
        stopped = false;
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        AlliNPush.getLocationManager().stopUpdatingLocation();
        
        if (!stopped) {
            stopped = true;
            
            let latitude = locations[0].coordinate.latitude;
            let longitude = locations[0].coordinate.longitude;
            
            self.completion!(latitude, longitude, nil);
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        AlliNPush.getLocationManager().stopUpdatingLocation();
        
        if (!stopped) {
            stopped = true;
            
            self.completion!(0.0, 0.0, LocationError.LocationNotFound);
        }
    }
}
