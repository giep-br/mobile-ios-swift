//
//  DateExtension.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 30/05/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
extension Date {
    static func currentDate(format: String) -> String {
        let date = Date();
        
        return Date.formattedDate(date: date, format: format);
    }
    
    func formattedDate(format: String) -> String {
        return Date.formattedDate(date: self, format: format);
    }
    
    static func formattedDate(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = format;
        
        return dateFormatter.string(from: date);
    }
    
    var dateComponents : DateComponents {
        let calendar = Calendar(identifier: .gregorian);
        let components = calendar.dateComponents(in: .current, from: self);
        
        return DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute);
    }
}
