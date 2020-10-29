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
        let date = Date.currentDate(format: "yyyy-MM-dd")
        let json = columnsAndValues.toString()!
        let complete = "List: \(nameList) Json: \(json) Date: \(date)"
            
        return complete.md5
    }
}
