//
//  Application.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 31/05/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
class Application {    
    static var appVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String;
    }
    
    static var alliNToken: String {        
        if let alliNToken = Application.getPlist(resource: "Info") {
            return alliNToken;
        }
        
        if let alliNToken = Application.getPlist(resource: "Strings") {
            return alliNToken;
        }
        
        if let alliNToken = Application.getPlist(resource: "strings") {
            return alliNToken;
        }
        
        return "";
    }
    
    private static func getPlist(resource: String) -> String? {
        if let path = Bundle.main.path(forResource: resource, ofType: "plist"),
            let dictionary = NSDictionary(contentsOfFile: path),
            let token = dictionary["all_in_token"] as? String {
            return  token;
        }
        
        return nil;
    }
}
