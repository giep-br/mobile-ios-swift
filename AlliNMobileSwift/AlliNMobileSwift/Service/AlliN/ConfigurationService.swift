//
//  ConfigurationService.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 13/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
class ConfigurationService {
    func configure(_ configurationEntity: ConfigurationEntity, completion: ((Any?, HttpRequestError?) -> Void)? = nil) {
        CacheService().sync();
        
        let deviceToken = AlliNPush.getInstance().deviceToken;
        let device = DeviceEntity(deviceToken: configurationEntity.deviceToken, renew: deviceToken == configurationEntity.deviceToken);
        
        DeviceService().sendDevice(device);
    }
}
