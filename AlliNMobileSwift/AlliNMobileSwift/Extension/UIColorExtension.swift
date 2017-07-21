//
//  UIColorExtension.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 30/05/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//

extension UIColor {
    static func createColor(fromHex: String) -> UIColor {
        var cString:String = fromHex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased();
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex);
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray;
        }
        
        var rgbValue:UInt32 = 0;
        
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        );
    }
}
