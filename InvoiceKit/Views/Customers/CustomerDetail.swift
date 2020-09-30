//
//  CustomerDetail.swift
//  InvoiceKit
//
//  Created by Victor Lourme on 28/09/2020.
//

import SwiftUI

struct CustomerDetail: View {
    private let client = Client<Customer>()
    
    @State public var id: UUID
    @State private var customer: Customer = Customer()
    
    var body: some View {
        Form {
            Section(header: Text("Informations")) {
                List {
                    ListRow("Entreprise", with: Text(customer.company.safe))
                    ListRow("Téléphone", with: Text(customer.phone.safe))
                    ListRow("Email", with: Text(customer.email.safe))
                }
            }
            
            
            Section(header: Text("Adresses")) {
                List {
                    ForEach(customer.addresses ?? [], id: \.id) { (address: Address) in
                        VStack(alignment: .leading) {
                            Text(address.line ?? "")
                            Text("\(address.zip ?? ""), \(address.city ?? "")")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            
            if customer.invoices?.count ?? 0 > 0 {
                Section(header: Text("Factures")) {
                    List {
                        ForEach(customer.invoices ?? [], id: \.id) { (invoice: Invoice) in
                            NavigationLink(destination: InvoiceDetail(id: invoice.id!)) {
                                VStack(alignment: .leading) {
                                    Text("\(invoice.number.ifEmpty("Non numérotée"))")
                                    Text("\(invoice.getType()) — \(invoice.getStatus())")
                                        .font(.footnote)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                }
            }
            
            if customer.contracts?.count ?? 0 > 0 {
                Section(header: Text("Contrats")) {
                    List {
                        ForEach(customer.contracts ?? [], id: \.id) { (contract: Contract) in
                            VStack(alignment: .leading) {
                                Text("\(contract.serial.ifEmpty("Aucun numéro de série"))")
                                Text("\(contract.type.ifEmpty("Aucun type")) — \(contract.getStatus())")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(customer.getName())
        .onReceive(client.error) { error in
            print(error)
        }
        .onReceive(client.success) { customer in
            self.customer = customer
        }
        .onAppear {
            print("[CustomerDetail] triggered: onAppear")
            print("[CustomerDetail] loading ID: \(id)")
            client.execute(endpoint: .getCustomer(id: id))
        }
    }
}

struct CustomerDetail_Previews: PreviewProvider {
    static var previews: some View {
        CustomerDetail(id: UUID())
    }
}
