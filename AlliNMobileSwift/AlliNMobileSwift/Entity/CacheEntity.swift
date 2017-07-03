//
//  CacheEntity.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 05/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
public class CacheEntity : NSCoding {
    var cacheId: Int = 0;
    var url: String = "";
    var json: String = "";
    
    init() {
    }
    
    init(cacheId: Int = 0, url: String, json: String) {
        self.cacheId = cacheId;
        self.url = url;
        self.json = json;
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.cacheId, forKey: "cacheId");
        aCoder.encode(self.url, forKey: "url");
        aCoder.encode(self.json, forKey: "json");
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.cacheId = aDecoder.decodeObject(forKey: "cacheId") as! Int;
        self.url = aDecoder.decodeObject(forKey: "url") as! String;
        self.json = aDecoder.decodeObject(forKey: "json") as! String;
    }
}
