//
//  UNNotificationAttachmentExtension.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 18/07/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
import Foundation;
import UserNotifications;

extension UNNotificationAttachment {
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
