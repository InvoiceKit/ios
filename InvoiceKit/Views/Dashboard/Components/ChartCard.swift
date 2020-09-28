//
//  ChartCard.swift
//  InvoiceKit
//
//  Created by Victor Lourme on 28/09/2020.
//

import SwiftUI
import SwiftUICharts

struct ChartCard: View {
    @State public var title: String
    @State public var icon: String
    @State public var color: Color
    @Binding public var points: [DataPoint]
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                    .padding(.trailing, 5)
                
                Text(title)
                    .bold()
                    .font(.title2)
                
                Spacer()
            }
            
            BarChartView(dataPoints: points, showLegends: false)
        }
        .padding()
        .frame(maxHeight: 225)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(15)
        .padding([.leading, .bottom, .trailing])
    }
}

struct ChartCard_Previews: PreviewProvider {
    static var previews: some View {
        ChartCard(title: "Example", icon: "doc.text.fill", color: .red, points: .constant([]))
    }
}
