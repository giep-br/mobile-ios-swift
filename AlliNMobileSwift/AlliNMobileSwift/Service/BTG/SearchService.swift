//
//  SearchService.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 22/01/19.
//  Copyright © 2019 Lucas Rodrigues. All rights reserved.
//

import Foundation

class SearchService : BTGBase {
    init(account: String, searchs: [AISearch]) {
        super.init(account: account, event: "search", items: searchs);
    }
}
