//
//  HttpRequest.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 06/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
class HttpRequest {
    static func post(_ url: String, data: Data, params: [String]? = nil, cache: Bool = false, completion: ((ResponseEntity?, HttpRequestError?) -> Void)? = nil) {
        DispatchQueue.global().async {
            self.makeRequest(url, requestType: .POST, data: data, params: params, cache: cache, completion: completion);
        }
    }
    
    static func get(_ url: String, params: [String]? = nil, cache: Bool = false, completion: ((ResponseEntity?, HttpRequestError?) -> Void)? = nil) {
        DispatchQueue.global().async {
            self.makeRequest(url, requestType: .GET, params: params, cache: cache, completion: completion);
        }
    }
    
    static func makeRequest(_ url: String, requestType: RequestTypeEnum, data: Data? = nil, params parameters: [String]?, cache: Bool, completion: ((ResponseEntity?, HttpRequestError?) -> Void)? = nil) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
        
        var urlParams = "";
        
        if let params = parameters {
            for param in params {
                urlParams += "/";
                urlParams += param;
            }
        }
        
        self.makeRequestURL("\(url)\(urlParams)", requestType: requestType, data: data, cache: cache, completion: completion);
    }
    
    static func makeRequestURL(_ urlString: String, requestType: RequestTypeEnum, data dataParam: Data?, cache: Bool, completion: ((ResponseEntity?, HttpRequestError?) -> Void)? = nil) {
        if (cache && !Connection.isInternetAvailable()) {
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false;
                
                completion?(nil, .ConnectionError);
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
                    
                    completion?(nil, .UnknownError);
                }
            }
            
            if let urlResponse = response as? HTTPURLResponse {
                if (urlResponse.statusCode == 200) {
                    do {
                        let responseEntity = ResponseEntity();
                        
                        if let data = dataResponse {
                            let responseValues = try JSONSerialization.jsonObject(with: data, options: .mutableContainers);
                            
                            if let values = responseValues as? NSDictionary {
                                responseEntity.error = (values.object(forKey: "error") as? Bool)!;
                                responseEntity.message = (values.object(forKey: "message") as? String)!;
                            }
                
                            DispatchQueue.main.async {
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false;
                                
                                if (!responseEntity.error) {
                                    completion?(responseEntity, nil);
                                } else {
                                    completion?(responseEntity, .UnknownError);
                                }
                            }
                        }
                    } catch {
                        DispatchQueue.main.async {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false;
                            
                            completion?(nil, .InvalidJson);
                        }
                    }
                } else {
                    if (urlResponse.statusCode == 401) {
                        DispatchQueue.main.async {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false;
                            
                            completion?(nil, .InvalidToken);
                        }
                    } else {
                        if (cache) {
                            self.saveCache(url: urlString, dataParam: dataParam);
                        }
                        
                        DispatchQueue.main.async {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false;
                            
                            completion?(nil, .RequestError);
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
