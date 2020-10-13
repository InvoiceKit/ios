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
    @ObservedObject private var searchBar = SearchBar()
    
    var body: some View {
        NavigationView {
            List(invoices.filter {
                searchBar.text.isEmpty ||
                ($0.customer?.getName() ?? "").localizedStandardContains(searchBar.text)
            }) { (invoice: Invoice) in
                NavigationLink(destination: InvoiceDetail(id: invoice.id!)) {
                    VStack(alignment: .leading) {
                        Text(invoice.customer?.getName() ?? "N/A")
                        Text("\(invoice.getType()) \(invoice.number ?? "") — \(invoice.getStatus())")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationBarTitle("Factures")
            .add(searchBar)
            
            Text("Séléctionnez une facture")
        }
        .navigationViewStyle(StackNavigationViewStyle())
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
