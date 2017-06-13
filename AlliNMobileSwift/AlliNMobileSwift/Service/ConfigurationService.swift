//
//  ConfigurationService.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 13/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
class ConfigurationService {
    func configure(configurationEntity: ConfigurationEntity, completion: @escaping (Any?, HttpRequestError?) -> Void) {
        CacheService().sync();
        
        let deviceToken = AlliNPush.deviceToken;
        let deviceEntity = DeviceEntity(deviceToken: configurationEntity.deviceToken, renew: deviceToken == configurationEntity.deviceToken);
        
        AlliNPush.getInstance().sendDeviceInfo(deviceEntity: deviceEntity, completion: completion);
    }
}
