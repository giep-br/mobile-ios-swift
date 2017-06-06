//
//  RequestDelegate.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 06/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
protocol RequestDelegate {
    func success(value: Any?);
    
    func error(value: Any?);
}
