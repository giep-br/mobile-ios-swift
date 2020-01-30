//
//  ListPersistence.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 30/01/20.
//  Copyright © 2020 Lucas Rodrigues. All rights reserved.
//

import Foundation

class ListPersistence {
    public static func getMD5(nameList: String, columnsAndValues: NSDictionary) -> String{
        let json = columnsAndValues.toString()!
        let complete = "List: \(nameList) Json: \(json)"
            
        return complete.md5
    }
}
