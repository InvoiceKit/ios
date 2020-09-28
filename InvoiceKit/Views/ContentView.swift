//
//  ContentView.swift
//  InvoiceKit
//
//  Created by Victor Lourme on 22/09/2020.
//

import SwiftUI
import KeychainSwift

struct ContentView: View {
    let client = Client<Team>()
    let log = Client<TokenResponse>()
    let keychain = KeychainSwift()
    @State var isLogged: Bool = true
    
    var body: some View {
        Group {
            if isLogged {
                Layout()
            } else {
                Authenticate(isLogged: $isLogged)
            }
        }
        .onReceive(client.error) { result in
            print("[ContentView] triggered: client.error")
            
            // Try to relog
            if let username = keychain.get("username") {
                if let password = keychain.get("password") {
                    print("[ContentView] Trying to re-log using username and password.")
                    return log.execute(endpoint: .login(username: username, password: password))
                }
            }
            
            // Ask for login
            isLogged = false
        }
        .onReceive(log.success) { model in
            print("[ContentView] triggered: log.success")
            
            // Set token
            keychain.set(model.token, forKey: "token")
        }
        .onReceive(log.error) { _ in
            print("[ContentView] triggered: log.error")
            
            // Set as not logged
            isLogged = false
        }
        .onChange(of: isLogged) { value in
            // Request userdata
            client.execute(endpoint: .getUser)
        }
        .onAppear {
            print("[ContentView] triggered: onAppear")
            
            // Check for token
            guard keychain.get("token") != nil else {
                return isLogged = false
            }
            
            // Request userdata
            client.execute(endpoint: .getUser)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
