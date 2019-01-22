//
//  BTGBase.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 22/01/19.
//  Copyright © 2019 Lucas Rodrigues. All rights reserved.
//

import Foundation

class BTGBase {
    private var account: String;
    private var event: String;
    private var data: Data;
    
    init(account: String, event: String, items: [Any]) {
        self.account = account;
        self.event = event;
        self.data = Data.transform(array: [
            (key: "account", value: self.account),
            (key: "event", value: self.event),
            (key: "deviceId", value: AlliNPush.getInstance().identifier),
            (key: "deviceToken", value: AlliNPush.getInstance().deviceToken),
            (key: "items", value: items),
            (key: "plataformId", value: 2)
        ])!;
    }
    
    public func send() {
        HttpRequest.post(HttpConstant.URL_BTG, data: data);
    }
}
