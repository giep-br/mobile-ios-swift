//
//  MessageDAO.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 13/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
class MessagesDAO : BaseDAO {
    private static let MESSAGE = "ALLIN_MESSAGE";
    
    func insert(messageEntity: MessageEntity) {
        if var messageList = self.get() {
            let messageEntity = MessageEntity();
            
            if (messageList.count > 0) {
                messageEntity.messageId = (messageList.object(at: messageList.count - 1) as! MessageEntity).messageId;
            } else {
                
            }
        }
        
    }
    
    func get() -> NSMutableArray? {
        return self.sharedPreferences.getArray(key: MessagesDAO.MESSAGE);
    }
}
