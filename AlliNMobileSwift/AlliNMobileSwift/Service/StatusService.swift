//
//  StatusService.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 07/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
class StatusService {
    func enable(_ completion: @escaping (Any?, HttpRequestError?) -> Void) {
        toggleAsync(enable: true, completion: completion);
    }
    
    func disable(_ completion: @escaping (Any?, HttpRequestError?) -> Void) {
        toggleAsync(enable: false, completion: completion);
    }
    
    private func toggleAsync(enable: Bool, completion: @escaping (Any?, HttpRequestError?) -> Void) {
        guard let data = Data.transform(array: [(key: BodyConstant.DEVICE_TOKEN, value: Application.alliNToken)]) else {
            completion(nil, .InvalidParameters);
            
            return;
        }
        
        HttpRequest.post(action: enable ? RouteConstant.DEVICE_ENABLE : RouteConstant.DEVICE_DISABLE, data: data) { (responseEntity, httpRequestError) in
            completion(responseEntity?.message, httpRequestError);
        }
    }
 
    func deviceIsEnable(_ completion: @escaping (Any?, HttpRequestError?) -> Void) {
        HttpRequest.get(action: RouteConstant.DEVICE_STATUS, completion: { (responseEntity, httpRequestError) in
            completion(responseEntity?.message, httpRequestError);
        });
    }
}
