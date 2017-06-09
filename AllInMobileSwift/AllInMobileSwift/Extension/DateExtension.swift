//
//  DateExtension.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 30/05/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
extension Date {
    static func currentDate(format: String) -> String {
        return formattedDate(date: Date(), format: format);
    }
    
    func formattedDate(format: String) -> String {
        return formattedDate(date: self, format: format);
    }
    
    func formattedDate(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = format;
        
        return dateFormatter.string(from: date);
    }
}
