//
//  LocationDelegate.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 06/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
protocol LocationDelegate {
    func locationFound(latitude: CGFloat, longitude: CGFloat);
    
    func locationNotFount();
}
