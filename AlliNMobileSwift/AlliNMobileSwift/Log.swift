//
//  Log.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 06/07/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//

import Foundation

public class Log {
    public static func printLog() {
        print(Log.get().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines));
    }
    
    private static func get() -> String {
        let userDefaults = UserDefaults.standard;
        
        if let log = userDefaults.string(forKey: "LOG") {
            return log;
        }
        
        return "";
    }
    
    public static func add(_ value: String) {
        let userDefaults = UserDefaults.standard;
        let log = Log.get() + "\n\(value)";
        
        userDefaults.set(log, forKey: "LOG");
        userDefaults.synchronize();
    }
    
    public static func clear() {
        let userDefaults = UserDefaults.standard;
        userDefaults.removeObject(forKey: "LOG");
        userDefaults.synchronize();
    }
}
