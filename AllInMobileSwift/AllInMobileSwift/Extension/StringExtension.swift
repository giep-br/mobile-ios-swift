//
//  StringExtension.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 30/05/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
import CommonCrypto;

extension String {
    var isNullOrEmpty: Bool {
        let value: String = self;
        
        if (value.isEmpty || value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).characters.count == 0) {
            return true;
        }
        
        return false;
    }
    
    var md5: String {
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH));
        
        if let data = self.data(using: String.Encoding.utf8) {
            data.withUnsafeBytes { (bytes: UnsafePointer<CChar>) -> Void in
                CC_MD5(bytes, CC_LONG(data.count), &digest);
            }
        }
        
        var digestHex = "";
        
        for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index]);
        }
        
        return digestHex;
    }
}
