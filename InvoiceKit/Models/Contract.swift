//
//  Contract.swift
//  InvoiceKit
//
//  Created by Victor Lourme on 28/09/2020.
//

import Foundation

struct Contract: Codable, Identifiable {
    var id: UUID?
    var customer: Customer?
    var address: Address?
    var createdAt: String?
    var updatedAt: String?
    var type: String?
    var serial: String?
    var status: String?
    var changes: [Change]?
    var date: String?
    
    func getStatus() -> String {
        switch status ?? "" {
        case "ongoing": return "En cours"
        default:
            return "Annulé"
        }
    }
    
    // MARK: - Fields
    struct Change: Codable {
        var date: String
        var description: String
    }
}
