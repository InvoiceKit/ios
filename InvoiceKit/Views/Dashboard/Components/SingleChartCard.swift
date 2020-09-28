//
//  SingleChartCard.swift
//  InvoiceKit
//
//  Created by Victor Lourme on 28/09/2020.
//

import SwiftUI

struct SingleChartCard: View {
    @State public var title: String
    @Binding public var value: Int
    @State public var icon: String
    @State public var color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .padding(.trailing)
                .frame(width: 50)
            
            VStack(alignment: .leading) {
                Text(String(value))
                    .bold()
                    .font(.title)
                
                Text(title)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(15)
        .padding([.leading, .bottom, .trailing])
    }
}

struct SingleChartCard_Previews: PreviewProvider {
    static var previews: some View {
        SingleChartCard(title: "Example", value: .constant(0), icon: "doc.text.fill", color: .blue)
    }
}
