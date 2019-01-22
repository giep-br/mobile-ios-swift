//
//  ResponseEntity.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 05/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
public class ResponseEntity {
    var error: Bool;
    var message: Any;
    
    public init() {
        self.error = false;
        self.message = "";
    }
    
    public init(error: Bool, message: Any) {
        self.error = error;
        self.message = message;
    }
}
