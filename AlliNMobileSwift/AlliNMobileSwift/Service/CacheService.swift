//
//  CacheService.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 07/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
class CacheService {
    private var cacheDAO : CacheDAO;
    
    init() {
        self.cacheDAO = CacheDAO();
    }
    
    func sync() {
        DispatchQueue.global().async {
            if let caches = self.cacheDAO.get() {
                for cache in caches {
                    self.sync(cacheEntity: cache as! CacheEntity);
                }
            }
        }
    }
    
    func sync(cacheEntity: CacheEntity) {
        HttpRequest.makeRequestURL(cacheEntity.url, requestType: .POST, data: cacheEntity.json.data(using: .utf8), cache: false, completion: nil);
        
        self.cacheDAO.delete(idCache: cacheEntity.cacheId);
    }
    
    func insert(url: String, json: String) {
        self.cacheDAO.insert(CacheEntity(url: url, json: json));
    }
}
