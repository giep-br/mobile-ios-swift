//
//  ProductService.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 22/01/19.
//  Copyright © 2019 Lucas Rodrigues. All rights reserved.
//

import Foundation

class ProductService : BTGBase {
    init(account: String, products: [AIProduct]) {
        super.init(account: account, event: "product", items: products);
    }
}
