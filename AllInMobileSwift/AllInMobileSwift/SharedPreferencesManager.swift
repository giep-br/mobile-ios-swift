//
//  SharedPreferencesManager.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 30/05/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
import CommonCrypto;

class SharedPreferencesManager {
    private let userDefaults: UserDefaults;
    
    init() {
        self.userDefaults = UserDefaults(suiteName: "")!;
    }
    
    func store(_ value: Any?, key: String) {
        self.userDefaults.set(value, forKey: key);
        self.userDefaults.synchronize();
    }
    
    func storeArray(_ value: NSMutableArray, key: String) {
        let data: Data = NSKeyedArchiver.archivedData(withRootObject: value);
        
        self.store(data, key: key);
    }
    
    func get(_ key: String, defaultValue: Any?) -> Any? {
        if (defaultValue is String) {
            return self.userDefaults.string(forKey: key);
        } else if (defaultValue is Int) {
            return self.userDefaults.integer(forKey: key);
        } else if (defaultValue is Float) {
            return self.userDefaults.float(forKey: key);
        } else if (defaultValue is Double) {
            return self.userDefaults.double(forKey: key);
        } else if (defaultValue is Bool) {
            return self.userDefaults.bool(forKey: key);
        }
        
        return nil;
    }
    
    func getArray(key: String) -> NSMutableArray? {
        let data: Data = self.userDefaults.object(forKey: key) as! Data;
        
        return NSKeyedUnarchiver.unarchiveObject(with: data) as? NSMutableArray;
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
