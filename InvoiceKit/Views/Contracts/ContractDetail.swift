//
//  ContractDetail.swift
//  InvoiceKit
//
//  Created by Victor Lourme on 28/09/2020.
//

import SwiftUI

struct ContractDetail: View {
    private let client = Client<Contract>()
    
    @State public var id: UUID
    @State private var contract: Contract = Contract()
    
    var body: some View {
        Form {
            Section(header: Text("Informations")) {
                List {
                    ListRow("Statut", with: Text(contract.getStatus()), bold: true)
                    ListRow("Type de chaudière", with: Text(contract.type.safe))
                    ListRow("Numéro de série", with: Text(contract.serial.safe))
                    ListRow("Date de signature", with: Text(contract.date.date))
                    ListRow("Date de création", with: Text(contract.createdAt.date))
                    ListRow("Dernière modification", with: Text(contract.updatedAt.date))
                }
            }
            
            Section(header: Text("Client")) {
                List {
                    ListRow("Client", with: Text("\(contract.customer?.getName() ?? "N/A")"))
                    
                    HStack {
                        Text("Adresse")
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("\(contract.address?.line ?? "N/A")")
                            Text("\(contract.address?.zip ?? "N/A"), \(contract.address?.city ?? "N/A")")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            
            if contract.changes?.count ?? 0 > 0 {
                Section(header: Text("Changements")) {
                    ForEach(contract.changes ?? [], id: \.description) { (change: Contract.Change) in
                        VStack(alignment: .leading) {
                            Text(change.description)
                            Text(change.date)
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .navigationTitle("Contrat d'entretien")
        .onReceive(client.error) { error in
            print(error)
        }
        .onReceive(client.success) { contract in
            self.contract = contract
        }
        .onAppear {
            print("[ContractDetail] triggered: onAppear")
            print("[ContractDetail] loading ID: \(id)")
            client.execute(endpoint: .getContract(id: id))
        }
    }
}

struct ContractDetail_Previews: PreviewProvider {
    static var previews: some View {
        CustomerDetail(id: UUID())
    }
}
