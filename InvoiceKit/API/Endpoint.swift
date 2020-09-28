//
//  Endpoint.swift
//  InvoiceKit
//
//  Created by Victor Lourme on 24/09/2020.
//

import Foundation

///
/// Endpoints
///
enum Endpoint {
    ///
    /// Login to user account
    /// - parameters:
    ///     - username: String
    ///     - password: String
    ///
    case login(username: String, password: String)
    
    ///
    /// Get userdata
    ///
    case getUser
    
    ///
    /// Get charts
    ///
    case getCharts
    
    ///
    /// Get customers
    ///
    case getCustomers
    
    ///
    /// Get a single customer
    ///
    case getCustomer(id: UUID)
    
    ///
    /// Get invoices
    ///
    case getInvoices
    
    ///
    /// Get a single invoice
    ///
    case getInvoice(id: UUID)
}
