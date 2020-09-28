//
//  Invoices.swift
//  InvoiceKit
//
//  Created by Victor Lourme on 28/09/2020.
//

import SwiftUI

struct Invoices: View {
    private let client = Client<Pagination<Invoice>>()
    @State private var invoices: [Invoice] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(invoices, id: \.id) { (invoice: Invoice) in
                    NavigationLink(destination: InvoiceDetail(id: invoice.id!)) {
                        VStack(alignment: .leading) {
                            Text(invoice.customer?.getName() ?? "N/A")
                            Text("\(invoice.getType()) \(invoice.number ?? "") — \(invoice.getStatus())")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            
            .navigationBarTitle("Factures")
        }
        .onReceive(client.error) { error in
            print(error)
        }
        .onReceive(client.success) { page in
            invoices = page.items
        }
        .onAppear {
            client.execute(endpoint: .getInvoices)
        }
    }
}

struct Invoices_Preview: PreviewProvider {
    static var previews: some View {
        Customers()
    }
}
