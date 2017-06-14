//
//  CacheDAO.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 13/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
class CacheDAO : BaseDAO {
    private static let CACHE = "ALLIN_CACHE";
    
    func insert(_ cacheEntity: CacheEntity) {
        let cacheEntity = CacheEntity();
        var caches = NSMutableArray();
        
        if let cacheList = self.get() {
            caches = cacheList;
            
            if (cacheList.count > 0) {
                cacheEntity.cacheId = (cacheList.object(at: cacheList.count - 1) as! CacheEntity).cacheId;
            } else {
                cacheEntity.cacheId = 1;
            }
        } else {
            cacheEntity.cacheId = 1;
        }
        
        caches.add(cacheEntity);
        
        sharedPreferences.storeArray(caches, key: CacheDAO.CACHE);
    }
    
    func delete(idCache: Int) {
        if let caches = self.get() {
            for index in 0..<caches.count {
                let cacheEntity = caches.object(at: index) as! CacheEntity;
                
                if (cacheEntity.cacheId == idCache) {
                    caches.removeObject(at: index);
                }
            }
        }
    }
    
    func get() -> NSMutableArray? {
        return self.sharedPreferences.getArray(key: CacheDAO.CACHE);
    }
}
