//
//  DeviceService.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 12/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
class DeviceService : BaseService {
    func sendDevice(_ deviceEntity: DeviceEntity, completion: @escaping (Any?, HttpRequestError?) -> Void) {
        guard let data = Data.transform(array: [
            (key: BodyConstant.DEVICE_TOKEN, value: AlliNPush.deviceToken),
            (key: BodyConstant.PLATFORM, value: ParameterConstant.IOS)
            ]) else {
                completion(nil, .InvalidParameters);
                
                return;
        }
        
        if (!deviceEntity.deviceToken.isNullOrEmpty && deviceEntity.renew) {
            HttpRequest.post(action: RouteConstant.DEVICE, data: data, params: [RouteConstant.UPDATE, AlliNPush.deviceToken]) { (responseEntity, httpRequestError) in
                self.sendListVerify(deviceEntity, responseEntity: responseEntity, httpRequestError, sendOnlyError: true, completion: completion);
            }
        } else {
            HttpRequest.post(action: RouteConstant.DEVICE, data: data) { (responseEntity, httpRequestError) in
                self.sendListVerify(deviceEntity, responseEntity: responseEntity, httpRequestError, sendOnlyError: true, completion: completion);
            }
        }
    }
    
    private func sendListVerify(_ deviceEntity: DeviceEntity, responseEntity: ResponseEntity?, _ httpRequestError: HttpRequestError?, sendOnlyError: Bool = false, completion: @escaping (Any?, HttpRequestError?) -> Void) {
        self.sendCallback(responseEntity, httpRequestError, sendOnlyError: true, completion: completion);
        
        if (responseEntity?.success)! {
            let sharedPreferencesManager = SharedPreferencesManager();
            sharedPreferencesManager.store(deviceEntity.deviceToken, key: PreferencesConstant.KEY_DEVICE_ID);
        }
    }
    
    func logout(_ completion: @escaping (Any?, HttpRequestError?) -> Void) {
        guard let data = Data.transform(array: [
            (key: BodyConstant.DEVICE_TOKEN, value: AlliNPush.deviceToken),
            (key: BodyConstant.USER_EMAIL, value: AlliNPush.userEmail)
            ]) else {
                completion(nil, .InvalidParameters);
                
                return;
        }
        
        HttpRequest.post(action: RouteConstant.DEVICE_LOGOUT, data: data) { (responseEntity, httpRequestError) in
            self.sendCallback(responseEntity, httpRequestError, completion: completion);
        }
    }
}
