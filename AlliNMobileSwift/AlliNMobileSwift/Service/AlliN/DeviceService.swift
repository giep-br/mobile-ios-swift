//
//  DeviceService.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 12/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
class DeviceService : BaseService {
    func logout(_ email: String, completion: ((Any?, HttpRequestError?) -> Void)?) {
        guard let data = Data.transform(array: [
            (key: BodyConstant.DEVICE_TOKEN, value: AlliNPush.getInstance().deviceToken),
            (key: BodyConstant.USER_EMAIL, value: email)
            ]) else {
                completion?(nil, .InvalidParameters);
                
                return;
        }
        
        HttpRequest.post(RouteConstant.DEVICE_LOGOUT, data: data) { (response, httpRequestError) in
            self.sendCallback(response, httpRequestError, completion: completion);
        }
    }
    
    func sendDevice(_ device: DeviceEntity) {
        guard let data = Data.transform(array: [
                (key: BodyConstant.DEVICE_TOKEN, value: device.deviceToken),
                (key: BodyConstant.PLATFORM, value: ParameterConstant.IOS)
            ]) else {
                return;
        }
        
        if (!device.deviceToken.isNullOrEmpty && device.renew) {
            HttpRequest.post(RouteConstant.DEVICE, data: data, params: [RouteConstant.UPDATE, AlliNPush.getInstance().deviceToken]) { (response, httpRequestError) in
                self.sendListVerify(device, error: response?.error ?? true)
            }
        } else {
            self.sendListVerify(device, error: false)
        }
    }
    
    private func sendListVerify(_ device: DeviceEntity, error: Bool) {
        if (!error) {
            let sharedPreferencesManager = PreferencesManager()
            sharedPreferencesManager.store(device.deviceToken, key: PreferencesConstant.KEY_DEVICE_ID)
            
            self.sendList(nameList: DefaultListConstant.LISTA_PADRAO, columnsAndValues: NSDictionary())
        }
    }
    
    func sendList(nameList: String, columnsAndValues: NSDictionary) {
        let mutable = columnsAndValues.mutableCopy() as! NSMutableDictionary
        var fields: String = "";
        var values: String = "";
        
        if mutable[DefaultListConstant.PUSH_ID] == nil {
            mutable[DefaultListConstant.PUSH_ID] = PreferencesManager().get(PreferencesConstant.KEY_DEVICE_ID, type: .String)
        }
        
        if mutable[DefaultListConstant.PLATAFORMA] == nil {
           mutable[DefaultListConstant.PLATAFORMA] = ParameterConstant.IOS
        }
        
        for (keyAny, valueAny) in mutable {
            let key = keyAny as! String;
            let value = valueAny as! String;
            
            if (!values.isNullOrEmpty) {
                values.append(";")
            }

            if (!fields.isNullOrEmpty) {
                fields.append(";")
            }
            
            fields.append(key)
            values.append(value)
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
    
    var deviceToken: String {
        let sharedPreferencesManager = PreferencesManager();
        
        if let deviceToken = sharedPreferencesManager.get(PreferencesConstant.KEY_DEVICE_ID, type: .String) as? String {
            return deviceToken;
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
