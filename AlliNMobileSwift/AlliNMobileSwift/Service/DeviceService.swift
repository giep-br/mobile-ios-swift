//
//  DeviceService.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 12/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
class DeviceService : BaseService {
    func sendDevice(_ deviceEntity: DeviceEntity, completion: ((Any?, HttpRequestError?) -> Void)?) {
        guard let data = Data.transform(array: [
                (key: BodyConstant.DEVICE_TOKEN, value: deviceEntity.deviceToken),
                (key: BodyConstant.PLATFORM, value: ParameterConstant.IOS)
            ]) else {
                completion!(nil, .InvalidParameters);
                
                return;
        }
        
        if (!deviceEntity.deviceToken.isNullOrEmpty && deviceEntity.renew) {
            HttpRequest.post(action: RouteConstant.DEVICE, data: data, params: [RouteConstant.UPDATE, AlliNPush.getInstance().deviceToken]) { (responseEntity, httpRequestError) in
                self.sendListVerify(deviceEntity, responseEntity: responseEntity, httpRequestError, sendOnlyError: true, completion: completion);
            }
        } else {
            HttpRequest.post(action: RouteConstant.DEVICE, data: data) { (responseEntity, httpRequestError) in
                self.sendListVerify(deviceEntity, responseEntity: responseEntity, httpRequestError, sendOnlyError: true, completion: completion);
            }
        }
    }
    
    private func sendListVerify(_ deviceEntity: DeviceEntity, responseEntity: ResponseEntity?, _ httpRequestError: HttpRequestError?, sendOnlyError: Bool = false, completion: ((Any?, HttpRequestError?) -> Void)?) {
        self.sendCallback(responseEntity, httpRequestError, sendOnlyError: true, completion: completion);
    
        if let response = responseEntity {
            if (response.success) {
                let sharedPreferencesManager = SharedPreferencesManager();
                sharedPreferencesManager.store(deviceEntity.deviceToken, key: PreferencesConstant.KEY_DEVICE_ID);
                
                let dictionary : NSDictionary = [
                    DefaultListConstant.ID_PUSH : AlliNPush.getInstance().deviceToken.md5,
                    DefaultListConstant.PUSH_ID : deviceEntity.deviceToken,
                    DefaultListConstant.PLATAFORMA : ParameterConstant.IOS
                ];
                
                self.sendList(nameList: DefaultListConstant.LISTA_PADRAO, columnsAndValues: dictionary, completion: completion);
            }
        }
    }
    
    func sendList(nameList: String, columnsAndValues: NSDictionary, completion: ((Any?, HttpRequestError?) -> Void)?) {
        var fields: String = "";
        var values: String = "";
        
        for (keyAny, valueAny) in columnsAndValues {
            let key = keyAny as! String;
            let value = valueAny as! String;
            
            fields.append("\(key)");
            fields.append(";");
            
            if (!value.isNullOrEmpty) {
                values.append(value);
            }
            
            values.append(";");
        }
        
        if (fields.hasSuffix(";")) {
            fields = fields.substring(to: fields.index(before: fields.endIndex));
        }
        
        if (values.hasSuffix(";")) {
            values = values.substring(to: values.index(before: values.endIndex));
        }
        
        guard let data = Data.transform(array: [
                (key: BodyConstant.NAME_LIST, value: nameList),
                (key: BodyConstant.CAMPOS, value: fields),
                (key: BodyConstant.VALOR, value: values)
            ]) else {
                completion!(nil, .InvalidParameters);
                
                return;
        }
        
        HttpRequest.post(action: RouteConstant.ADD_LIST, data: data) { (responseEntity, httpRequestError) in
            self.sendCallback(responseEntity, httpRequestError, completion: completion);
        }
    }
    
    func logout(_ completion: ((Any?, HttpRequestError?) -> Void)?) {
        guard let data = Data.transform(array: [
            (key: BodyConstant.DEVICE_TOKEN, value: AlliNPush.getInstance().deviceToken),
            (key: BodyConstant.USER_EMAIL, value: AlliNPush.getInstance().userEmail)
            ]) else {
                completion!(nil, .InvalidParameters);
                
                return;
        }
        
        HttpRequest.post(action: RouteConstant.DEVICE_LOGOUT, data: data) { (responseEntity, httpRequestError) in
            self.sendCallback(responseEntity, httpRequestError, completion: completion);
        }
    }
    
    func saveEmail(_ email: String, completion: ((Any?, HttpRequestError?) -> Void)?) {
        guard let data = Data.transform(array: [
                (key: BodyConstant.DEVICE_TOKEN, value: AlliNPush.getInstance().deviceToken),
                (key: BodyConstant.PLATFORM, value: ParameterConstant.IOS),
                (key: BodyConstant.USER_EMAIL, value: AlliNPush.getInstance().userEmail)
            ]) else {
                completion!(nil, .InvalidParameters);
                
                return;
        }
        
        HttpRequest.post(action: RouteConstant.EMAIL, data: data) { (responseEntity, httpRequestError) in
            if let response = responseEntity {
                if (response.success) {
                    let sharedPreferencesManager = SharedPreferencesManager();
                    sharedPreferencesManager.store(email, key: PreferencesConstant.KEY_USER_EMAIL);
                }
            }
            
            self.sendCallback(responseEntity, httpRequestError, completion: completion);
        }
    }
    
    var deviceToken: String? {
        let sharedPreferencesManager = SharedPreferencesManager();
        
        return sharedPreferencesManager.get(PreferencesConstant.KEY_DEVICE_ID, defaultValue: nil) as? String;
    }
    
    var userEmail: String? {
        let sharedPreferencesManager = SharedPreferencesManager();
        
        return sharedPreferencesManager.get(PreferencesConstant.KEY_USER_EMAIL, defaultValue: nil) as? String;
    }
}
