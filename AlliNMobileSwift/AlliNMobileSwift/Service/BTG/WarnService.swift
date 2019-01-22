//
//  WarnMeService.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 22/01/19.
//  Copyright © 2019 Lucas Rodrigues. All rights reserved.
//

import Foundation

class WarnService : BTGBase {
    init(account: String, warns: [AIWarn]) {
        super.init(account: account, event: "warnme", items: warns);
    }
}
