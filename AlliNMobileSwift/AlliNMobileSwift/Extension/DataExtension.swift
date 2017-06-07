//
//  DataExtension.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 07/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
extension Data {
    public static func transform(array: [(key: String, value: Any)]) -> Data? {
        var dictionary = Dictionary<String, Any>();
        
        for a in array {
            dictionary[a.key] = a.value;
        }
        
        do {
            return try JSONSerialization.data(withJSONObject: dictionary, options: []);
        } catch {
            return nil;
        }
    }
}
