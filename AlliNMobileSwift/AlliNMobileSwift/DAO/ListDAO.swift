//
//  ListDAO.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 30/01/20.
//  Copyright © 2020 Lucas Rodrigues. All rights reserved.
//

import Foundation

class ListDAO: BaseDAO {
    private static let LIST = "ALLIN_LIST";
    
    func exist(md5: String) -> Int {
        return (self.get()?.contains(md5) ?? false) ? 1 : 0
    }
    
    func insert(md5: String) {
        var lists = [String]()
        
        if let sentLists = self.get() {
            lists = sentLists
        }
        
        lists.append(md5)
        
        sharedPreferences.storeArray(lists, key: ListDAO.LIST)
    }
    
    func get() -> [String]? {
        return self.sharedPreferences.get(ListDAO.LIST, type: .Array) as? [String]
    }
}
