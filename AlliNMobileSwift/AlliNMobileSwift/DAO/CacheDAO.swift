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
        var caches = [CacheEntity]();
        
        if let cacheList = self.get() {
            caches = cacheList;
            
            if (cacheList.count > 0) {
                cacheEntity.cacheId = cacheList[cacheList.count - 1].cacheId;
            } else {
                cacheEntity.cacheId = 1;
            }
        } else {
            cacheEntity.cacheId = 1;
        }
        
        caches.append(cacheEntity);
        
        sharedPreferences.storeArray(caches, key: CacheDAO.CACHE);
    }
    
    func delete(idCache: Int) {
        if var caches = self.get() {
            for index in 0..<caches.count {
                let cacheEntity = caches[index];
                
                if (cacheEntity.cacheId == idCache) {
                    caches.remove(at: index);
                }
            }
            
            sharedPreferences.storeArray(caches, key: CacheDAO.CACHE);
        }
    }
    
    func get() -> [CacheEntity]? {
        return self.sharedPreferences.get(CacheDAO.CACHE, type: .Array) as? [CacheEntity];
    }
}
