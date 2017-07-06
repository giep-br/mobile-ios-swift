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
        var messages = [MessageEntity]();
        
        if let messageList = self.get() {
            messages = messageList;
            
            if (messageList.count > 0) {
                messageEntity.messageId = messageList[messageList.count - 1].messageId;
            } else {
                messageEntity.messageId = 1;
            }
        } else {
            messageEntity.messageId = 1;
        }
        
        messages.append(messageEntity);
        
        sharedPreferences.storeArray(messages, key: MessageDAO.MESSAGE);
    }
    
    func delete(idMessage: Int) {
        if var messages = self.get() {
            for index in 0..<messages.count {
                let messageEntity = messages[index];
                
                if (messageEntity.messageId == idMessage) {
                    messages.remove(at: index);
                }
            }
            
            sharedPreferences.storeArray(messages, key: MessageDAO.MESSAGE);
        }
    }
    
    func get() -> [MessageEntity]? {
        return self.sharedPreferences.get(MessageDAO.MESSAGE, type: .Array) as? [MessageEntity];
    }
}
