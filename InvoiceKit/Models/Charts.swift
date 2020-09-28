//
//  Charts.swift
//  InvoiceKit
//
//  Created by Victor Lourme on 25/09/2020.
//

import Foundation

struct Charts: Codable {
    var customers: Int = 0
    var invoices: ChartsInvoice = ChartsInvoice()
    
    // Daily invoices
    var daily: [String: Int] = [:]
        
    // Daily contracts
    var contracts: [String: Int] = [:]
    
    init() {
        
    }
}

struct ChartsInvoice: Codable {
    var total: Int = 0
    var paid: Int = 0
    var waiting: Int = 0
    var canceled: Int = 0
}


struct ChartsPrices: Codable {
    // Money waiting
    var waiting = ChartsPriceContent()
    
    // Money paid
    var paid = ChartsPriceContent()
    
    // Money not paid from canceled invoices
    var canceled = ChartsPriceContent()
}

struct ChartsPriceContent: Codable {
    var value: Double = 0
    var total: Double = 0
    var tax: Double = 0
}

