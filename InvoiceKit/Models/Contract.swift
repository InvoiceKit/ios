//
//  Contract.swift
//  InvoiceKit
//
//  Created by Victor Lourme on 28/09/2020.
//

import Foundation

struct Contract: Codable {
    var id: UUID?
    var customer: Customer
    var address: Address
    var createdAt: Date?
    var updatedAt: Date?
    var type: String
    var serial: String
    var status: String
    var changes: [ContractChange]?
    var date: String?
    
    // MARK: - Fields
    struct ContractChange: Codable {
        var date: String
        var description: String
    }
}
