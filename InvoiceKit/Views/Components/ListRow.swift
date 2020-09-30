//
//  ListRow.swift
//  InvoiceKit
//
//  Created by Victor Lourme on 30/09/2020.
//

import SwiftUI

struct ListRow: View {
    var key: String = ""
    var value: Text = Text("")
    var isBold: Bool = false
    
    init(_ key: String, with value: Text, bold: Bool = false) {
        self.key = key
        self.value = value
        self.isBold = bold
    }
    
    var body: some View {
        HStack {
            Text(key)
            
            Spacer()
            
            if isBold {
                value
                    .bold()
            } else {
                value
            }
        }
    }
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRow("Example key", with: Text("Hello world"))
    }
}
