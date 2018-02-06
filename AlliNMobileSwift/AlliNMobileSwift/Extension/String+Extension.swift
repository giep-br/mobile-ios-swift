//
//  StringExtension.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 30/05/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
public extension String {
    var isNullOrEmpty: Bool {
        let value: String = self;
        
        if (value.isEmpty || value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0) {
            return true;
        }
        
        return false;
    }
    
    var md5: String {
        return self.utf8.lazy.map({ $0 as UInt8 }).md5().toHexString();
    }
}
