//
//  PricingRow.swift
//  InvoiceKit
//
//  Created by Victor Lourme on 28/09/2020.
//

import SwiftUI

struct PricingRow: View {
    @State public var title: String
    @Binding public var value: Double?
    @State public var minus: Bool = false
    
    var body: some View {
        HStack {
            Text(title)
            
            Spacer()
            
            Text(minus ? "- " : "") + 
            Text("\(value ?? 0, specifier: "%2.f") €")
                .bold()
        }
    }
}

struct PricingRow_Previews: PreviewProvider {
    static var previews: some View {
        PricingRow(title: "Example", value: .constant(0))
    }
}
