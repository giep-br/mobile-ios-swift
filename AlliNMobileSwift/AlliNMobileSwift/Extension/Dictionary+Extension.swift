//
//  Dictionary+Extension.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 18/07/19.
//  Copyright © 2019 Lucas Rodrigues. All rights reserved.
//

import Foundation

extension NSDictionary {
    func toString() -> NSString? {
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted);
            
            return NSString.init(data: data, encoding: String.Encoding.utf8.rawValue);
        } catch {
            return nil;
        }
    }
}
