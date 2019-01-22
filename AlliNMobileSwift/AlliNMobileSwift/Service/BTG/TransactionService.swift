//
//  TransactionService.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 22/01/19.
//  Copyright © 2019 Lucas Rodrigues. All rights reserved.
//

import Foundation

class TransactionService : BTGBase {
    init(account: String, transactions: [AITransaction]) {
        super.init(account: account, event: "transaction", items: transactions);
    }
}
