//
//  MessageService.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 12/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
class MessageService {
    private var messageDAO : MessageDAO;
    
    init() {
        self.messageDAO = MessageDAO();
    }
    
    func add(messageEntity: MessageEntity) {
        self.messageDAO.insert(messageEntity)
    }
    
    func delete(id: Int) {
        self.messageDAO.delete(idMessage: id);
    }
    
    func get() -> [MessageEntity]? {
        return self.messageDAO.get();
    }
}
