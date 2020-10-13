//
//  Customer.swift
//  InvoiceKit
//
//  Created by Victor Lourme on 28/09/2020.
//

import Foundation

struct Customer: Codable, Identifiable {
    var id: UUID?
    var addresses: [Address]? = []
    var invoices: [Invoice]? = []
    var contracts: [Contract]? = []
    var firstName: String?
    var lastName: String?
    var company: String?
    var phone: String?
    var email: String?
    
    func getName() -> String {
        if company?.isEmpty ?? true {
            return "\(firstName ?? "") \(lastName ?? "")"
        } else {
            return company ?? ""
        }
    }
}
