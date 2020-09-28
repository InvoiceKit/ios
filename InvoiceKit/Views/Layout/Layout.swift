//
//  Layout.swift
//  InvoiceKit
//
//  Created by Victor Lourme on 25/09/2020.
//

import SwiftUI

struct Layout: View {
    var body: some View {
        TabView {
            Dashboard()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Tableau de bord")
                }
            
            Customers()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Clients")
                }
            
            Invoices()
                .tabItem {
                    Image(systemName: "tray.full.fill")
                    Text("Factures")
                }
        }
    }
}

struct Layout_Previews: PreviewProvider {
    static var previews: some View {
        Layout()
    }
}
