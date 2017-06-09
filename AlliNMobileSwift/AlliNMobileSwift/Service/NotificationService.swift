//
//  NotificationService.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 09/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
class NotificationService {
    func transactional(idSend: Int, date: String, completion: @escaping (Any?, HttpRequestError?) -> Void) {
        guard let data = Data.transform(array: [
            (key: BodyConstant.ID, value: "\(idSend)"),
            (key: BodyConstant.DATE, value: date),
            (key: BodyConstant.DATE_OPENING, value: Date.currentDate(format: "yyyy-MM-dd HH:mm:ss"))
            ]) else {
                completion(nil, .InvalidParameters);
                
                return;
        }
        
        HttpRequest.post(action: RouteConstant.NOTIFICATION_TRANSACTIONAL, data: data) { (responseEntity, httpRequestError) in
            guard let response = responseEntity else {
                completion(nil, httpRequestError);
                
                return;
            }
            
            if (response.success) {
                completion(response.message, nil);
            } else {
                completion(response.message, HttpRequestError.WebServiceError);
            }
        }
    }
}
