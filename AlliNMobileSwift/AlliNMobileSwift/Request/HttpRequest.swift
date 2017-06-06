//
//  HttpRequest.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 06/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//

import Foundation

class HttpRequest {
    func post(action: String, data: NSData, params: [String], cache: Bool = false) -> ResponseEntity? {
        return self.makeRequest(action: action, requestType: .POST, data: data, params: params, cache: cache);
    }
    
    func get(action: String, params: [String], cache: Bool = false) -> ResponseEntity? {
        return self.makeRequest(action: action, requestType: .GET, params: params, cache: cache);
    }
    
    func makeRequest(action: String, requestType: RequestTypeEnum, data: NSData? = nil, params: [String], cache: Bool) -> ResponseEntity? {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
        
        var url = HttpConstant.SERVER_URL + action;
        
        for param in params {
            url += "/";
            url += param;
        }
        
        return self.makeRequestURL(url, requestType: requestType, data: data, cache: cache);
    }
    
    func makeRequestURL(_ url: String, requestType: RequestTypeEnum, data: NSData?, cache: Bool) -> ResponseEntity? {
        if (cache && !Connection.isInternetAvailable()) {
            
        }
        
        return nil;
    }
}
