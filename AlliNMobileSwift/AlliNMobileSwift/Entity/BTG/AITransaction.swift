//
//  AITransaction.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 22/01/19.
//  Copyright © 2019 Lucas Rodrigues. All rights reserved.
//

import Foundation

public class AITransaction {
    private var productId: String;
    private var transactionId: String;
    
    public init(productId: String, transactionId: String) {
        self.productId = productId;
        self.transactionId = transactionId;
    }
}
