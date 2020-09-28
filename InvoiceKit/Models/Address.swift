//
//  Address.swift
//  InvoiceKit
//
//  Created by Victor Lourme on 28/09/2020.
//

import Foundation

struct Address: Codable {
    var id: UUID?
    var line: String?
    var zip: String?
    var city: String?
}
