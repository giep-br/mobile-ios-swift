//
//  HttpRequest.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 06/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
class HttpRequest {
    static func post(action: String, data: Data, params: [String]? = nil, cache: Bool = false, completion: @escaping (ResponseEntity?, HttpRequestError?) -> Void) {
        DispatchQueue.global().async {
            self.makeRequest(action: action, requestType: .POST, data: data, params: params, cache: cache, completion: completion);
        }
    }
    
    static func get(action: String, params: [String]? = nil, cache: Bool = false, completion: @escaping (ResponseEntity?, HttpRequestError?) -> Void) {
        DispatchQueue.global().async {
            self.makeRequest(action: action, requestType: .GET, params: params, cache: cache, completion: completion);
        }
    }
    
    static func makeRequest(action: String, requestType: RequestTypeEnum, data: Data? = nil, params parameters: [String]?, cache: Bool, completion: @escaping (ResponseEntity?, HttpRequestError?) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
        
        var url = HttpConstant.SERVER_URL + action;
        
        if let params = parameters {
            for param in params {
                url += "/";
                url += param;
            }
        }
        
        self.makeRequestURL(url, requestType: requestType, data: data, cache: cache, completion: completion);
    }
    
    static func makeRequestURL(_ urlString: String, requestType: RequestTypeEnum, data dataParam: Data?, cache: Bool, completion: ((ResponseEntity?, HttpRequestError?) -> Void)?) {
        if (cache && !Connection.isInternetAvailable()) {
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false;
                
                if let _ = completion {
                    completion!(nil, .ConnectionError);
                }
            }
        }
        
        var urlRequest = URLRequest(url: URL(string: urlString)!);
        
        if let data = dataParam, requestType == .POST {
            urlRequest.httpBody = data;
        }
        
        urlRequest.httpMethod = requestType.rawValue;
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept");
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type");
        urlRequest.setValue(Application.alliNToken, forHTTPHeaderField: "Authorization");
        urlRequest.timeoutInterval = TimeInterval(HttpConstant.DEFAULT_REQUEST_TIMEOUT);
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (dataResponse, response, errorResponse) in
            if let _ = errorResponse {
                if (cache) {
                    self.saveCache(url: urlString, dataParam: dataParam);
                }
                
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false;
                    
                    if let _ = completion {
                        completion!(nil, .UnknownError);
                    }
                }
            }
            
            if let urlResponse = response as? HTTPURLResponse {
                if (urlResponse.statusCode == 200) {
                    do {
                        let responseEntity = ResponseEntity();
                        
                        if let data = dataResponse {
                            let responseValues = try JSONSerialization.jsonObject(with: data, options: .mutableContainers);
                            
                            if let values = responseValues as? NSDictionary {
                                responseEntity.success = (values.object(forKey: "error") as? Bool)!;
                                responseEntity.message = (values.object(forKey: "message") as? String)!;
                            }
                
                            DispatchQueue.main.async {
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false;
                                
                                if let _ = completion {
                                    if (responseEntity.success) {
                                        completion!(responseEntity, nil);
                                    } else {
                                        completion!(responseEntity, .UnknownError);
                                    }
                                }
                            }
                        }
                    } catch {
                        DispatchQueue.main.async {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false;
                            
                            if let _ = completion {
                                completion!(nil, .InvalidJson);
                            }
                        }
                    }
                } else {
                    if (urlResponse.statusCode == 401) {
                        DispatchQueue.main.async {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false;
                            
                            if let _ = completion {
                                completion!(nil, .InvalidToken);
                            }
                        }
                    } else {
                        if (cache) {
                            self.saveCache(url: urlString, dataParam: dataParam);
                        }
                        
                        DispatchQueue.main.async {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false;
                            
                            if let _ = completion {
                                completion!(nil, .RequestError);
                            }
                        }
                    }
                }
            }
        });
        
        dataTask.resume();
    }
    
    private static func saveCache(url: String, dataParam: Data?) {
        var json = "";
        
        if let data = dataParam {
            json = String(data: data, encoding: .utf8)!;
        }
        
        CacheService().insert(url: url, json: json);
    }
}
