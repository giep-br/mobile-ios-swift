//
//  UNNotificationAttachment.swift
//  AllInMobileSwift
//
//  Created by Lucas Barbosa on 14/07/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//

import Foundation;
import UserNotifications;

extension UNNotificationAttachment {
    static func create(imageFileIdentifier: String, data: Data, options: [NSObject : AnyObject]?) -> UNNotificationAttachment? {
        let fileManager = FileManager.default;
        let tmpSubFolderName = ProcessInfo.processInfo.globallyUniqueString;
        let tmpSubFolderURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(tmpSubFolderName, isDirectory: true);
        
        do {
            try fileManager.createDirectory(at: tmpSubFolderURL, withIntermediateDirectories: true, attributes: nil);
            let fileURL = tmpSubFolderURL.appendingPathComponent(imageFileIdentifier);
            try data.write(to: fileURL, options: []);
            let imageAttachment = try UNNotificationAttachment(identifier: imageFileIdentifier, url: fileURL, options: options);
            
            return imageAttachment;
        } catch let error {
            print("error \(error)");
        }
        
        return nil;
    }
}
