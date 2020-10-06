//
//  BTG360.swift
//  AlliNMobileSwift
//
//  Created by Lucas Rodrigues on 21/05/2018.
//  Copyright © 2018 Lucas Rodrigues. All rights reserved.
//

import Foundation

public class BTG360 {    
    public static func setDeviceToken(deviceToken: String) {
        AlliNPush.init().setDeviceToken(deviceToken);
    }
    
    public static func addProduct(account: String, product: AIProduct) {
        BTG360.addProducts(account: account, products: [product]);
    }
    
    public static func addProducts(account: String, products: [AIProduct]) {
        ProductService(account: account, products: products).send();
    }
    
    public static func addCart(account: String, cart: AICart) {
        BTG360.addCarts(account: account, carts: [cart]);
    }
    
    public static func addCarts(account: String, carts: [AICart]) {
        CartService(account: account, carts: carts).send();
    }
    
    public static func addClient(account: String, client: AIClient) {
        BTG360.addClients(account: account, clients: [client])
    }
    
    public static func addClients(account: String, clients: [AIClient]) {
        ClientService(account: account, clients: clients).send();
    }
    
    public static func addTransaction(account: String, transaction: AITransaction) {
        BTG360.addTransactions(account: account, transactions: [transaction]);
    }
    
    public static func addTransactions(account: String, transactions: [AITransaction]) {
        TransactionService(account: account, transactions: transactions).send();
    }
    
    public static func addSearch(account: String, search: AISearch) {
        BTG360.addSearchs(account: account, searchs: [search]);
    }
    
    public static func addSearchs(account: String, searchs: [AISearch]) {
        SearchService(account: account, searchs: searchs).send();
    }
    
    public static func addWish(account: String, wish: AIWish) {
        BTG360.addWishes(account: account, wishes: [wish]);
    }
    
    public static func addWishes(account: String, wishes: [AIWish]) {
        WishService(account: account, wishes: wishes).send();
    }
    
    public static func addWarn(account: String, warn: AIWarn) {
        BTG360.addWarns(account: account, warns: [warn])
    }
    
    public static func addWarns(account: String, warns: [AIWarn]) {
        WarnService(account: account, warns: warns).send();
    }
}
