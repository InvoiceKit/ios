//
//  Optionals.swift
//  InvoiceKit
//
//  Created by Victor Lourme on 28/09/2020.
//

import Foundation

extension Optional where Wrapped == String {
    var safe: String {
        if self?.isEmpty ?? true {
            return "N/A"
        }
        
        if let value = self {
            return value
        } else {
            return "N/A"
        }
    }
    
    var date: String {
        guard let date = self else {
            return "N/A"
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
        
        if let result = formatter.date(from: date) {
            // Reformat
            formatter.dateFormat = "dd/MM/yyyy"
            
            return formatter.string(from: result)
        } else {
            return "N/A"
        }
    }
    
    func ifEmpty(_ str: String) -> String {
        if (self ?? "").isEmpty {
            return str
        } else {
            return self ?? "N/A"
        }
    }
}
