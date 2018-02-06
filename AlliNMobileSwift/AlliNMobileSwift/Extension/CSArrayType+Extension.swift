//
//  CSArrayType.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 21/07/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//

public protocol CSArrayType: Collection {
    func cs_arrayValue() -> [Iterator.Element]
}

extension Array: CSArrayType {
    public func cs_arrayValue() -> [Iterator.Element] {
        return self
    }
}

public extension CSArrayType where Iterator.Element == UInt8 {
    public func toHexString() -> String {
        return self.lazy.reduce("") {
            var s = String($1, radix: 16)
            if s.count == 1 {
                s = "0" + s
            }
            return $0 + s
        }
    }
    
    public func md5() -> [Iterator.Element] {
        return Digest.md5(cs_arrayValue())
    }
}
