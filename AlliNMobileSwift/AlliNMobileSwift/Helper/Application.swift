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
        if let alliNToken = Application.getPlist(resource: "Info")["all_in_token"] {
            return alliNToken as! String;
        }
        
        if let alliNToken = Application.getPlist(resource: "Strings")["all_in_token"] {
            return alliNToken as! String;
        }
        
        if let alliNToken = Application.getPlist(resource: "strings")["all_in_token"] {
            return alliNToken as! String;
        }
        
        return "";
    }
    
    private static func getPlist(resource: String) -> NSDictionary {
        let path: String = Bundle.main.path(forResource: resource, ofType: "plist")!;
        
        return  NSDictionary(contentsOfFile: path)!;
    }
}
