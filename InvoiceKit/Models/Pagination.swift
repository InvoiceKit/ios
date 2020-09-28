//
//  Pagination.swift
//  InvoiceKit
//
//  Created by Victor Lourme on 28/09/2020.
//

import Foundation

struct Pagination<T: Codable>: Codable {
    var items: [T]
    var metadata: Metadata
    
    struct Metadata: Codable {
        var page: Int
        var per: Int
        var total: Int
    }
}
