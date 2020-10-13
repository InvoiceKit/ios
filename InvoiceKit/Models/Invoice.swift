//
//  Invoice.swift
//  InvoiceKit
//
//  Created by Victor Lourme on 28/09/2020.
//

import Foundation

struct Invoice: Codable, Identifiable {
    var id: UUID?
    var team: Team?
    var customer: Customer?
    var address: Address?
    var createdAt: String?
    var updatedAt: String?
    var dueDate: String?
    var type: String?
    var status: String?
    var fields: [Field]?
    var number: String?
    var deposit: Double?
    var promotion: Int?
    var additional_text: String?
    var no_vat: Double?
    var vat: Double?
    var total: Double?
    var _promotion: Double?
    var final: Double?
    
    struct Field: Codable {
        var name: String
        var price: Double
        var vat: Double
    }
    
    func getStatus() -> String {
        switch status ?? "" {
        case "paid": return "Payé"
        case "canceled": return "Annulé"
        default:
            return "En attente"
        }
    }
    
    func getType() -> String {
        return type == "invoice" ? "Facture" : "Devis"
    }
}
