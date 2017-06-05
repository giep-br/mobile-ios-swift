//
//  MessageEntity.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 05/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//

import Foundation

class MessageEntity {
    var messageId: Int;
    var idSend: String;
    var subject: String;
    var desc: String;
    var idCampaign: String;
    var idLogin: String;
    var urlScheme: String;
    var action: String;
    var date: String;
    var urlTransactional: String;
    var urlCampaign: String;
    var read: Bool;
    
    init(userInfo: NSDictionary) {
        self.date = self.getValue(key: <#T##String#>, userInfo: <#T##NSDictionary#>)
    }
    
    private func getValue(key: String, userInfo: NSDictionary) -> String {
        var value: String = userInfo.object(forKey: key) as! String;
        
        if (value.isNullOrEmpty) {
            value = "";
        }
        
        return value;
    }
}
