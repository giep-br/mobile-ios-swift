//
//  DeviceService.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 12/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
class DeviceService : BaseService {
    func sendDevice(_ deviceEntity: DeviceEntity) {
        guard let data = Data.transform(array: [
                (key: BodyConstant.DEVICE_TOKEN, value: deviceEntity.deviceToken),
                (key: BodyConstant.PLATFORM, value: ParameterConstant.IOS)
            ]) else {
                return;
        }
        
        if (!deviceEntity.deviceToken.isNullOrEmpty && deviceEntity.renew) {
            HttpRequest.post(RouteConstant.DEVICE, data: data, params: [RouteConstant.UPDATE, AlliNPush.getInstance().deviceToken]) { (responseEntity, httpRequestError) in
                self.sendListVerify(deviceEntity, responseEntity: responseEntity, httpRequestError, sendOnlyError: true);
            }
        } else {
            HttpRequest.post(RouteConstant.DEVICE, data: data) { (response, httpRequestError) in
                let sharedPreferences = PreferencesManager();
                sharedPreferences.store(deviceEntity.deviceToken, key: PreferencesConstant.KEY_DEVICE_ID);
                
                self.sendListVerify(deviceEntity, responseEntity: response, httpRequestError, sendOnlyError: true);
            }
        }
    }
    
    private func sendListVerify(_ deviceEntity: DeviceEntity, responseEntity: ResponseEntity?, _ httpRequestError: HttpRequestError?, sendOnlyError: Bool = false) {
        if let response = responseEntity {
            if (!response.error) {
                let sharedPreferencesManager = PreferencesManager();
                sharedPreferencesManager.store(deviceEntity.deviceToken, key: PreferencesConstant.KEY_DEVICE_ID);
                
                let dictionary : NSDictionary = [
                    DefaultListConstant.ID_PUSH : AlliNPush.getInstance().deviceToken.md5,
                    DefaultListConstant.PUSH_ID : deviceEntity.deviceToken,
                    DefaultListConstant.PLATAFORMA : ParameterConstant.IOS
                ];
                
                self.sendList(nameList: DefaultListConstant.LISTA_PADRAO, columnsAndValues: dictionary);
            }
        }
    }
    
    func sendList(nameList: String, columnsAndValues: NSDictionary) {
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
            fields = String(fields[..<fields.index(before: fields.endIndex)]);
        }
        
        if (values.hasSuffix(";")) {
            values = String(values[..<values.index(before: values.endIndex)]);
        }
        
        guard let data = Data.transform(array: [
                (key: BodyConstant.NAME_LIST, value: nameList),
                (key: BodyConstant.CAMPOS, value: fields),
                (key: BodyConstant.VALOR, value: values)
            ]) else {
                return;
        }
        
        HttpRequest.post(RouteConstant.ADD_LIST, data: data);
    }
    
    func logout(_ completion: ((Any?, HttpRequestError?) -> Void)?) {
        guard let data = Data.transform(array: [
            (key: BodyConstant.DEVICE_TOKEN, value: AlliNPush.getInstance().deviceToken),
            (key: BodyConstant.USER_EMAIL, value: AlliNPush.getInstance().email)
            ]) else {
                completion?(nil, .InvalidParameters);
                
                return;
        }
        
        HttpRequest.post(RouteConstant.DEVICE_LOGOUT, data: data) { (responseEntity, httpRequestError) in
            self.sendCallback(responseEntity, httpRequestError, completion: completion);
        }
    }
    
    func registerEmail(_ email: String) {
        guard let data = Data.transform(array: [
                (key: BodyConstant.DEVICE_TOKEN, value: AlliNPush.getInstance().deviceToken),
                (key: BodyConstant.PLATFORM, value: ParameterConstant.IOS),
                (key: BodyConstant.USER_EMAIL, value: email)
            ]) else {
                return;
        }
        
        HttpRequest.post(RouteConstant.EMAIL, data: data) { (responseEntity, httpRequestError) in
            if let response = responseEntity {
                if (!response.error) {
                    let sharedPreferencesManager = PreferencesManager();
                    sharedPreferencesManager.store(email, key: PreferencesConstant.KEY_USER_EMAIL);
                }
            }
        }
    }
    
    var deviceToken: String {
        let sharedPreferencesManager = PreferencesManager();
        
        if let deviceToken = sharedPreferencesManager.get(PreferencesConstant.KEY_DEVICE_ID, type: .String) as? String {
            return deviceToken;
        }
        
        return "";
    }
    
    var email: String {
        let sharedPreferencesManager = PreferencesManager();
        
        if let email = sharedPreferencesManager.get(PreferencesConstant.KEY_USER_EMAIL, type: .String) as? String {
            return email;
        }
        
        return "";
    }
    
    var identifier: String {
        let sharedPreferencesManager = PreferencesManager();
        
        if let identifier = sharedPreferencesManager.get(PreferencesConstant.KEY_IDENTIFIER, type: .String) as? String {
            return identifier;
        }
        
        let identifier = UUID().uuidString.md5;
        
        sharedPreferencesManager.store(identifier, key: PreferencesConstant.KEY_IDENTIFIER);
        
        return identifier;
    }
    
    func showAlertHTML(_ show: Bool) {
        let sharedPreferencesManager = PreferencesManager();
        sharedPreferencesManager.store(show, key: PreferencesConstant.SHOW_ALERT_HTML);
    }
    
    var showAlertHTML: Bool {
        let sharedPreferencesManager = PreferencesManager();
        
        if let show = sharedPreferencesManager.get(PreferencesConstant.SHOW_ALERT_HTML, type: .Bool) as? Bool {
            return show;
        }
        
        return false;
    }
    
    func showAlertScheme(_ show: Bool) {
        let sharedPreferencesManager = PreferencesManager();
        sharedPreferencesManager.store(show, key: PreferencesConstant.SHOW_ALERT_SCHEME);
    }
    
    var showAlertScheme: Bool {
        let sharedPreferencesManager = PreferencesManager();
        
        if let show = sharedPreferencesManager.get(PreferencesConstant.SHOW_ALERT_SCHEME, type: .Bool) as? Bool {
            return show;
        }
        
        return false;
    }
    
    func barButtonColor(_ hexColor: String) {
        let sharedPreferencesManager = PreferencesManager();
        sharedPreferencesManager.store(hexColor, key: PreferencesConstant.BAR_BUTTON_COLOR);
    }
    
    var barButtonColor: String {
        let sharedPreferencesManager = PreferencesManager();
        
        if let barButtonColor = sharedPreferencesManager.get(PreferencesConstant.BAR_BUTTON_COLOR, type: .String) as? String {
            return barButtonColor;
        }
        
        return "";
    }
}
