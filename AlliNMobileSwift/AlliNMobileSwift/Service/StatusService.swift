//
//  StatusService.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 07/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
class StatusService: BaseService {
    func enable(_ completion: ((Any?, HttpRequestError?) -> Void)? = nil) {
        toggleAsync(enable: true, completion: completion);
    }
    
    func disable(_ completion: ((Any?, HttpRequestError?) -> Void)? = nil) {
        toggleAsync(enable: false, completion: completion);
    }
    
    private func toggleAsync(enable: Bool, completion: ((Any?, HttpRequestError?) -> Void)? = nil) {
        guard let data = Data.transform(array: [
            (key: BodyConstant.DEVICE_TOKEN, value: AlliNPush.getInstance().deviceToken),
            (key: BodyConstant.PLATFORM, value: ParameterConstant.IOS)
        ]) else {
            completion?(nil, .InvalidParameters);
            
            return;
        }
        
        HttpRequest.post(action: enable ? RouteConstant.DEVICE_ENABLE : RouteConstant.DEVICE_DISABLE, data: data) { (responseEntity, httpRequestError) in
            self.sendCallback(responseEntity, httpRequestError, completion: completion);
        }
    }
 
    func deviceIsEnable(_ completion: ((Any?, HttpRequestError?) -> Void)? = nil) {
        HttpRequest.get(action: RouteConstant.DEVICE_STATUS, params: [AlliNPush.getInstance().deviceToken]) { (responseEntity, httpRequestError) in
            responseEntity?.message = responseEntity?.message as? String == BodyConstant.ENABLED;
            
            self.sendCallback(responseEntity, httpRequestError, completion: completion);
        };
    }
}
