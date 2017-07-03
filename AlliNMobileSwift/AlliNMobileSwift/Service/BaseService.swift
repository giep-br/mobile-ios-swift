//
//  BaseService.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 12/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
class BaseService {
    func sendCallback(_ responseEntity: ResponseEntity?, _ httpRequestError: HttpRequestError?, sendOnlyError: Bool = false, completion: ((Any?, HttpRequestError?) -> Void)?) {
        guard let response = responseEntity else {
            if let _ = completion {
                completion!(nil, httpRequestError);
            }
            
            return;
        }
        
        if let _ = completion {
            if (response.success) {
                if (!sendOnlyError) {
                    completion!(response.message, nil);
                }
            } else {
                completion!(response.message, HttpRequestError.WebServiceError);
            }
        }
    }
}
