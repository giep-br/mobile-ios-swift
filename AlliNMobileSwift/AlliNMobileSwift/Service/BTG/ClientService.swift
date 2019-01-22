//
//  ClientService.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 22/01/19.
//  Copyright © 2019 Lucas Rodrigues. All rights reserved.
//

import Foundation

class ClientService : BTGBase {
    init(account: String, clients: [AIClient]) {
        super.init(account: account, event: "client", items: clients);
    }
}
