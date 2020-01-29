//
//  UNNotificationAttachmentExtension.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 18/07/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
import Foundation
import UserNotifications
import MobileCoreServices

@available(iOS 10.0, *)
extension UNNotificationAttachment {
    static func image(_ userInfo: NSDictionary, callback: @escaping ([UNNotificationAttachment]?) -> Void) {
        if let attachmentString = userInfo.object(forKey: NotificationConstant.IMAGE) as? String, let attachmentUrl = URL(string: attachmentString) {
            let dotIndex = attachmentString.range(of: ".", options: .backwards)?.lowerBound
            let strLastCharacter = attachmentString.endIndex
            let fileExtension = attachmentString[dotIndex!..<strLastCharacter]
            
            let session = URLSession(configuration: .default)
            let downloadTask = session.downloadTask(with: attachmentUrl) { (url, _, error) in
                if error != nil {
                    callback(nil)
                } else if let url = url {
                    var options: [String: CFString] = [:]
                    
                    if (fileExtension == ".jpg" || fileExtension == ".jpeg") {
                        options = [UNNotificationAttachmentOptionsTypeHintKey: kUTTypeJPEG]
                    } else if (fileExtension == ".png") {
                        options = [UNNotificationAttachmentOptionsTypeHintKey: kUTTypePNG]
                    } else if (fileExtension == ".bmp") {
                        options = [UNNotificationAttachmentOptionsTypeHintKey: kUTTypeBMP]
                    } else if (fileExtension == ".gif") {
                        options = [UNNotificationAttachmentOptionsTypeHintKey: kUTTypeGIF]
                    }
                    
                    let attachment = try! UNNotificationAttachment(identifier: attachmentString, url: url, options: options)
                    
                    callback([attachment])
                }
            }
            
            downloadTask.resume()
        } else {
            callback(nil)
        }
    }
}
