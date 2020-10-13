//
//  Customers.swift
//  InvoiceKit
//
//  Created by Victor Lourme on 28/09/2020.
//

import SwiftUI

struct Customers: View {
    private let client = Client<Pagination<Customer>>()
    @State private var customers: [Customer] = []
    @ObservedObject private var searchBar = SearchBar()
    
    var body: some View {
        NavigationView {
            List(customers.filter {
                searchBar.text.isEmpty ||
                $0.getName().localizedStandardContains(searchBar.text)
            }) { (customer: Customer) in
                    NavigationLink(destination: CustomerDetail(id: customer.id!)) {
                        Text(customer.getName())
                    }
            }
            .navigationBarTitle("Clients")
            .add(searchBar)
            
            Text("Séléctionnez un client")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onReceive(client.error) { error in
            print(error)
        }
        .onReceive(client.success) { page in
            customers = page.items.sorted {
                ($0.lastName ?? "").lowercased() < ($1.lastName ?? "").lowercased()
            }
        }
        .onAppear {
            client.execute(endpoint: .getCustomers)
        }
    }
}

struct Customers_Previews: PreviewProvider {
    static var previews: some View {
        Customers()
    }
}
