//
//  WishListService.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 22/01/19.
//  Copyright © 2019 Lucas Rodrigues. All rights reserved.
//

import Foundation

class WishService : BTGBase {
    init(account: String, wishes: [AIWish]) {
        super.init(account: account, event: "wishlist", items: wishes);
    }
}
