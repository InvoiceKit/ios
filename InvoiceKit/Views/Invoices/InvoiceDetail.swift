//
//  InvoiceDetail.swift
//  InvoiceKit
//
//  Created by Victor Lourme on 28/09/2020.
//

import SwiftUI
import BetterSafariView

struct InvoiceDetail: View {
    private let client = Client<Invoice>()
    @State public var id: UUID
    @State private var invoice = Invoice()
    @State private var isPresented = false
    
    var body: some View {
        Form {
            Section(header: Text("Informations")) {
                List {
                    HStack {
                        Text("Numéro")
                        Spacer()
                        Text(invoice.number.safe)
                    }
                    
                    HStack {
                        Text("Statut")
                        Spacer()
                        Text(invoice.getStatus())
                    }
                    
                    HStack {
                        Text("Date de création")
                        Spacer()
                        Text(invoice.createdAt.date)
                    }
                    
                    HStack {
                        Text("Dernière modification")
                        Spacer()
                        Text(invoice.updatedAt.date)
                    }
                }
            }
            
            Section(header: Text("Client")) {
                List {
                    HStack {
                        Text("Client")
                        Spacer()
                        Text("\(invoice.customer?.getName() ?? "N/A")")
                    }
                    
                    HStack {
                        Text("Adresse")
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("\(invoice.address?.line ?? "N/A")")
                            Text("\(invoice.address?.zip ?? "N/A"), \(invoice.address?.city ?? "N/A")")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            
            Section(header: Text("Prix")) {
                List {
                    PricingRow(title: "Total H.T.", value: $invoice.no_vat)
                    PricingRow(title: "T.V.A.", value: $invoice.vat)
                    
                    if invoice.promotion ?? 0 > 0 {
                        PricingRow(title: "Remise", value: $invoice._promotion, minus: true)
                    }
                    
                    if invoice.deposit ?? 0 > 0 {
                        PricingRow(title: "Acompte", value: $invoice.deposit, minus: true)
                    }
                    
                    PricingRow(title: "Total T.T.C.", value: $invoice.final)
                }
            }
            
            if invoice.fields?.count ?? 0 > 0 {
                Section(header: Text("Champs")) {
                    ForEach(invoice.fields ?? [], id: \.name) { (field: Invoice.Field) in
                        HStack {
                            Text(field.name)
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("\(field.price, specifier: "%2.f") €")
                                Text("+ \(field.vat, specifier: "%0.f") %")
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(invoice.getType().capitalized)
        .navigationBarItems(trailing: Button(action: {
            isPresented = true
        }) {
            Image(systemName: "printer")
        })
        .safariView(isPresented: $isPresented) {
            SafariView(url: URL(string: "https://invoicekit.herokuapp.com/invoices/\(id)/render")!)
        }
        .onReceive(client.success) { invoice in
            self.invoice = invoice
        }
        .onReceive(client.error) { error in
            print(error)
        }
        .onAppear {
            print("[InvoiceDetail] triggered: onAppear")
            print("[InvoiceDetail] loading ID: \(id)")
            client.execute(endpoint: .getInvoice(id: id))
        }
    }
}

struct InvoiceDetail_Previews: PreviewProvider {
    static var previews: some View {
        InvoiceDetail(id: UUID())
    }
}
