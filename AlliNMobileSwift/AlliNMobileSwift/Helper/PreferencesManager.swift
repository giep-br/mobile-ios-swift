//
//  SharedPreferencesManager.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 30/05/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//

class PreferencesManager {
    private let userDefaults: UserDefaults;
    
    init() {
        self.userDefaults = UserDefaults.standard;
    }
    
    func store(_ value: Any?, key: String) {
        self.userDefaults.set(value, forKey: key);
        self.userDefaults.synchronize();
    }
    
    func storeArray(_ value: [Any], key: String) {
        let data: Data = NSKeyedArchiver.archivedData(withRootObject: value);
        
        self.store(data, key: key);
    }
    
    func get(_ key: String, type: SharedTypeEnum) -> Any? {
        switch type {
        case .Array:
            if let data: Data = self.userDefaults.object(forKey: key) as? Data {
                return NSKeyedUnarchiver.unarchiveObject(with: data) as? NSMutableArray;
            } else {
                return NSMutableArray();
            }
        case .Bool:
            return self.userDefaults.bool(forKey: key);
            
        case .Double:
            return self.userDefaults.double(forKey: key);
            
        case .Float:
            return self.userDefaults.float(forKey: key);
            
        case .Integer:
            return self.userDefaults.integer(forKey: key);
            
        case .String:
            return self.userDefaults.string(forKey: key);
        }
    }
    
    func remove(key: String) {
        self.userDefaults.removeObject(forKey: key);
    }
    
    func clear() {
        if let appDomain = Bundle.main.bundleIdentifier {
            self.userDefaults.removePersistentDomain(forName: appDomain);
        }
    }
}
