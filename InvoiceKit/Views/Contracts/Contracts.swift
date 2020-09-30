//
//  Contracts.swift
//  InvoiceKit
//
//  Created by Victor Lourme on 30/09/2020.
//

import SwiftUI

struct Contracts: View {
    private let client = Client<Pagination<Contract>>()
    @State private var contracts: [Contract] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(contracts, id: \.id) { (contract: Contract) in
                    NavigationLink(destination: ContractDetail(id: contract.id!)) {
                        VStack(alignment: .leading) {
                            Text(contract.customer?.getName() ?? "N/A")
                            Text("\(contract.type.ifEmpty("Aucun type")) — \(contract.getStatus())")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Contrats")
            
            Text("Séléctionnez un contrat")
        }
        .onReceive(client.error) { error in
            print(error)
        }
        .onReceive(client.success) { page in
            contracts = page.items
        }
        .onAppear {
            client.execute(endpoint: .getContracts)
        }
    }
}

struct Contracts_Previews: PreviewProvider {
    static var previews: some View {
        Contracts()
    }
}
