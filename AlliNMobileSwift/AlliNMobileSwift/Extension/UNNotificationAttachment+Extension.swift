//
//  UNNotificationAttachmentExtension.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 18/07/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
import Foundation;
import UserNotifications;

@available(iOS 10.0, *)
extension UNNotificationAttachment {
    static func image(userInfo: NSDictionary) -> [UNNotificationAttachment]? {
        guard let image = userInfo.object(forKey: NotificationConstant.IMAGE) as? String,
            let url = URL(string: image), let imageData = NSData(contentsOf: url) else {
            return nil
        }
        
        var attachments : [UNNotificationAttachment] = []
        let dotIndex = image.range(of: ".", options: .backwards)?.lowerBound
        let strLastCharacter = image.endIndex
        let imageExtension = image[dotIndex!..<strLastCharacter]
        
        if let attachment = UNNotificationAttachment.create(imageFileIdentifier: "\(image.md5)\(imageExtension)", data: imageData, options: nil) {
            attachments.append(attachment)
        }
        
        return attachments
    }
    
    static func create(imageFileIdentifier: String, data: NSData, options: [NSObject : AnyObject]?) -> UNNotificationAttachment? {
        let fileManager = FileManager.default;
        let tmpSubFolderName = ProcessInfo().globallyUniqueString;
        let tmpSubFolderURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(tmpSubFolderName, isDirectory: true)
        
        do {
            try fileManager.createDirectory(at: tmpSubFolderURL, withIntermediateDirectories: true, attributes: nil)
            let fileURL = tmpSubFolderURL.appendingPathComponent(imageFileIdentifier)
            try data.write(to: fileURL, options: [])
            
            return try UNNotificationAttachment(identifier: imageFileIdentifier, url: fileURL, options: options);
        } catch let error {
            print("error \(error)")
        }
        
        return nil
    }
}
