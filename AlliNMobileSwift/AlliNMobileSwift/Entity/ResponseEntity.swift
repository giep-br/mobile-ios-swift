//
//  ResponseEntity.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 05/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
public class ResponseEntity {
    var success: Bool;
    var message: String;
    
    public init() {
        self.success = false;
        self.message = "";
    }
    
    public init(success: Bool, message: String) {
        self.success = success;
        self.message = message;
    }
}
