//
//  BaseDAO.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 13/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
class BaseDAO {
    var sharedPreferences: PreferencesManager;
    
    init() {
        sharedPreferences = PreferencesManager();
    }
}
