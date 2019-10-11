//
//  AlliNDelegate.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 06/06/17.
//  Copyright © 2017 Lucas Rodrigues. All rights reserved.
//
public protocol AlliNDelegate {
    func onShowAlert(title: String, body: String, callback: @escaping () -> ()) -> Bool;
}
