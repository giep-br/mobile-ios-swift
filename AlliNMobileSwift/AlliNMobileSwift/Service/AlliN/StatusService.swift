//
//  StatusService.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 07/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
class StatusService: BaseService {
    func enable() {
        toggleAsync(enable: true);
    }
    
    func disable() {
        toggleAsync(enable: false);
    }
    
    private func toggleAsync(enable: Bool, completion: ((Any?, HttpRequestError?) -> Void)? = nil) {
        guard let data = Data.transform(array: [
            (key: BodyConstant.DEVICE_TOKEN, value: AlliNPush.getInstance().deviceToken),
            (key: BodyConstant.PLATFORM, value: ParameterConstant.IOS)
        ]) else {
            return;
        }
        
        HttpRequest.post(enable ? RouteConstant.DEVICE_ENABLE : RouteConstant.DEVICE_DISABLE, data: data);
    }
 
    func deviceIsEnable(_ completion: ((Any?, HttpRequestError?) -> Void)? = nil) {
        HttpRequest.get(RouteConstant.DEVICE_STATUS, params: [AlliNPush.getInstance().deviceToken]) { (responseEntity, httpRequestError) in
            responseEntity?.message = responseEntity?.message as? String == BodyConstant.ENABLED;
            
            self.sendCallback(responseEntity, httpRequestError, completion: completion);
        };
    }
}
