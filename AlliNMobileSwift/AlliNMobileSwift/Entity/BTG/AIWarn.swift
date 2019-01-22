//
//  AIWarn.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 22/01/19.
//  Copyright © 2019 Lucas Rodrigues. All rights reserved.
//

import Foundation

public class AIWarn {
    private var productId: String;
    private var active: Bool;
    
    public init(productId: String, active: Bool) {
        self.productId = productId;
        self.active = active;
    }
}
