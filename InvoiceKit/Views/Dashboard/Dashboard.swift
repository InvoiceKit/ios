//
//  Dashboard.swift
//  InvoiceKit
//
//  Created by Victor Lourme on 24/09/2020.
//

import SwiftUI
import SwiftUICharts

struct Dashboard: View {
    private let client = Client<Charts>()
    
    @State private var charts = Charts()
    @State private var InvoicesPoints: [DataPoint] = []
    @State private var ContractsPoints: [DataPoint] = []
    
    var body: some View {
        ScrollView {
            HStack {
                Text("Tableau de bord")
                    .font(.title)
                    .bold()
                
                Spacer()
            }
            .padding()
            
            ChartCard(
                title: "Dernières factures",
                icon: "doc.plaintext.fill",
                color: .green,
                points: $InvoicesPoints
            )
            
            ChartCard(
                title: "Derniers contrats",
                icon: "doc.text.below.ecg.fill",
                color: .blue,
                points: $ContractsPoints
            )
            
            SingleChartCard(
                title: "Chiffre d'affaire",
                value: .constant(Int(charts.prices.paid.value + charts.prices.waiting.value)),
                icon: "arrow.down.circle.fill",
                color: .purple,
                euro: true
            ).padding([.leading, .trailing, .bottom])
            
            HStack {
                SingleChartCard(
                    title: "Clients",
                    value: $charts.customers,
                    icon: "person.3.fill",
                    color: .red
                )
                
                SingleChartCard(
                    title: "Factures",
                    value: $charts.invoices.total,
                    icon: "folder.fill",
                    color: .orange
                )
            }
            .padding([.leading, .trailing, .bottom])
        }
        .onReceive(client.error) { error in
            print(error)
        }
        .onReceive(client.success) { model in
            // Assign model
            charts = model
            
            // Reset invoices
            InvoicesPoints.removeAll()
            ContractsPoints.removeAll()
            
            // Date formatter
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            
            // Sort dates
            let invoices = charts.daily.sorted {
                guard let a = dateFormatter.date(from: $0.key),
                      let b = dateFormatter.date(from: $1.key) else {
                    return false
                }
                
                return a.compare(b) == .orderedAscending
            }
            
            let contracts = charts.contracts.sorted {
                guard let a = dateFormatter.date(from: $0.key),
                      let b = dateFormatter.date(from: $1.key) else {
                    return false
                }
                
                return a.compare(b) == .orderedAscending
            }
            
            let invoice = Legend(color: .green, label: "Factures", order: 0)
            let contract = Legend(color: .blue, label: "Contrats", order: 1)
            
            for (key, value) in invoices {
                InvoicesPoints.append(.init(value: Double(value), label: LocalizedStringKey(key), legend: invoice))
            }
            
            for (key, value) in contracts {
                ContractsPoints.append(.init(value: Double(value), label: LocalizedStringKey(key), legend: contract))
            }
        }
        .onAppear {
            // Get charts
            client.execute(endpoint: .getCharts)
        }
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}
