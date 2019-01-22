//
//  DeviceEntity.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 05/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
public class DeviceEntity {
    var deviceToken: String;
    var renew: Bool;
    
    public init(deviceToken: String, renew: Bool) {
        self.deviceToken = deviceToken;
        self.renew = renew;
    }
}
