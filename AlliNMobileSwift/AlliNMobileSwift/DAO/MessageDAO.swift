//
//  MessageDAO.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 13/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
class MessageDAO : BaseDAO {
    private static let MESSAGE = "ALLIN_MESSAGE";
    
    func insert(_ messageEntity: MessageEntity) {
        let messageEntity = MessageEntity();
        var messages = NSMutableArray();
        
        if let messageList = self.get() {
            messages = messageList;
            
            if (messageList.count > 0) {
                messageEntity.messageId = (messageList.object(at: messageList.count - 1) as! MessageEntity).messageId;
            } else {
                messageEntity.messageId = 1;
            }
        } else {
            messageEntity.messageId = 1;
        }
        
        messages.add(messageEntity);
        
        sharedPreferences.storeArray(messages, key: MessageDAO.MESSAGE);
    }
    
    func delete(idMessage: Int) {
        if let messages = self.get() {
            for index in 0..<messages.count {
                let messageEntity = messages.object(at: index) as! MessageEntity;
                
                if (messageEntity.messageId == idMessage) {
                    messages.removeObject(at: index);
                }
            }
        }
    }
    
    func get() -> NSMutableArray? {
        return self.sharedPreferences.get(MessageDAO.MESSAGE, type: .Array) as? NSMutableArray;
    }
}
