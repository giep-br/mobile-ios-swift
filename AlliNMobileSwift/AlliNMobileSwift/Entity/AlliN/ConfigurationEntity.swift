//
//  ConfigurationEntity.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 31/05/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
public class ConfigurationEntity {
    var deviceToken: String = "";
    
    public init(deviceToken: Data?) throws {
        if let token = deviceToken {
            self.deviceToken = token.map { String(format: "%02.2hhx", arguments: [$0]); }.joined();
            
            if (self.deviceToken.isNullOrEmpty) {
                throw DeviceTokenError.Invalid;
            }
        }
    }
    
    public init(deviceToken: String) throws {
        if (deviceToken.isNullOrEmpty) {
            throw DeviceTokenError.Empty;
        }
        
        self.deviceToken = deviceToken;
    }
}
