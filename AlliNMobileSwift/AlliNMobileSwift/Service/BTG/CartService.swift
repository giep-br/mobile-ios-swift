//
//  CartService.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 22/01/19.
//  Copyright © 2019 Lucas Rodrigues. All rights reserved.
//

import Foundation

class CartService : BTGBase {
    init(account: String, carts: [AICart]) {
        super.init(account: account, event: "cart", items: carts);
    }
}
