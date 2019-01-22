//
//  MessageEntity.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 05/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
public class MessageEntity : NSObject, NSCoding {
    private static let ID_MESSAGE = "id";
    private static let READ = "read";
    
    var messageId: Int = 0;
    var idSend: String = "";
    var subject: String = "";
    var desc: String = "";
    var idCampaign: String = "";
    var idLogin: String = "";
    var urlScheme: String = "";
    var action: String = "";
    var date: String = "";
    var urlTransactional: String = "";
    var urlCampaign: String = "";
    var read: Bool = false;
    
    public override init() {
    }
    
    public init(userInfo: NSDictionary) {
        self.messageId = 0;
        self.idSend = MessageEntity.getValue(key: NotificationConstant.ID_SEND, userInfo: userInfo);
        self.subject = MessageEntity.getValue(key: NotificationConstant.SUBJECT, userInfo: userInfo);
        self.desc = MessageEntity.getValue(key: NotificationConstant.DESCRIPTION, userInfo: userInfo);
        self.idCampaign = MessageEntity.getValue(key: NotificationConstant.ID_CAMPAIGN, userInfo: userInfo);
        self.idLogin = MessageEntity.getValue(key: NotificationConstant.ID_LOGIN, userInfo: userInfo);
        self.urlScheme = MessageEntity.getValue(key: NotificationConstant.URL_SCHEME, userInfo: userInfo);
        self.action = MessageEntity.getValue(key: NotificationConstant.ACTION, userInfo: userInfo);
        self.date = MessageEntity.getValue(key: NotificationConstant.DATE_NOTIFICATION, userInfo: userInfo);
        self.urlTransactional = MessageEntity.getValue(key: NotificationConstant.URL_TRANSACTIONAL, userInfo: userInfo);
        self.urlCampaign = MessageEntity.getValue(key: NotificationConstant.URL_CAMPAIGN, userInfo: userInfo);
        self.read = false;
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.messageId =  aDecoder.decodeInteger(forKey: MessageEntity.ID_MESSAGE);
        self.idSend =  aDecoder.decodeObject(forKey: NotificationConstant.ID_SEND) as! String;
        self.subject =  aDecoder.decodeObject(forKey: NotificationConstant.SUBJECT) as! String;
        self.desc =  aDecoder.decodeObject(forKey: NotificationConstant.DESCRIPTION) as! String;
        self.idCampaign =  aDecoder.decodeObject(forKey: NotificationConstant.ID_CAMPAIGN) as! String;
        self.idLogin =  aDecoder.decodeObject(forKey: NotificationConstant.ID_LOGIN) as! String;
        self.urlScheme =  aDecoder.decodeObject(forKey: NotificationConstant.URL_SCHEME) as! String;
        self.action =  aDecoder.decodeObject(forKey: NotificationConstant.ACTION) as! String;
        self.date =  aDecoder.decodeObject(forKey: NotificationConstant.DATE_NOTIFICATION) as! String;
        self.urlTransactional =  aDecoder.decodeObject(forKey: NotificationConstant.URL_TRANSACTIONAL) as! String;
        self.urlCampaign =  aDecoder.decodeObject(forKey: NotificationConstant.URL_CAMPAIGN) as! String;
        self.read =  aDecoder.decodeBool(forKey: MessageEntity.READ);
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.messageId, forKey: MessageEntity.ID_MESSAGE);
        aCoder.encode(self.idSend, forKey: NotificationConstant.ID_SEND);
        aCoder.encode(self.subject, forKey: NotificationConstant.SUBJECT);
        aCoder.encode(self.desc, forKey: NotificationConstant.DESCRIPTION);
        aCoder.encode(self.idCampaign, forKey: NotificationConstant.ID_CAMPAIGN);
        aCoder.encode(self.idLogin, forKey: NotificationConstant.ID_LOGIN);
        aCoder.encode(self.urlScheme, forKey: NotificationConstant.URL_SCHEME);
        aCoder.encode(self.action, forKey: NotificationConstant.ACTION);
        aCoder.encode(self.date, forKey: NotificationConstant.DATE_NOTIFICATION);
        aCoder.encode(self.urlTransactional, forKey: NotificationConstant.URL_TRANSACTIONAL);
        aCoder.encode(self.urlCampaign, forKey: NotificationConstant.URL_CAMPAIGN);
        aCoder.encode(self.read, forKey: MessageEntity.READ);
    }
    
    public static func getValue(key: String, userInfo: NSDictionary) -> String {
        if let value = userInfo.object(forKey: key) {
            return "\(value)";
        }
        
        return "";
    }
}
