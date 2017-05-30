//
//  StringExtension.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 30/05/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
extension String {
    var isNullOrEmpty: Bool {
        let value: String = self;
        
        if (value.isEmpty || value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).characters.count == 0) {
            return true;
        }
        
        return false;
    }
    
//    var md5: String {
//        let messageData = self.data(using:.utf8)!
//        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
//        
//        _ = digestData.withUnsafeMutableBytes {digestBytes in
//            messageData.withUnsafeBytes {messageBytes in
//                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
//            }
//        }
//        
//        return digestData;
//    }
}
