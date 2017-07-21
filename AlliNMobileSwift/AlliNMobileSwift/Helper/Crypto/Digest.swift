//
//  Digest.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 21/07/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
public struct Digest {
    
    /// Calculate MD5 Digest
    /// - parameter bytes: input message
    /// - returns: Digest bytes
    public static func md5(_ bytes: Array<UInt8>) -> Array<UInt8> {
        return MD5().calculate(for: bytes)
    }
}
