//
//  Authenticate.swift
//  InvoiceKit
//
//  Created by Victor Lourme on 24/09/2020.
//

import SwiftUI
import KeychainSwift

struct Authenticate: View {
    private let client = Client<TokenResponse>()
    private let keychain = KeychainSwift()
    
    @Binding var isLogged: Bool
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    ///
    /// Try to login
    ///
    private func login() {
        // Try to login
        client.execute(endpoint: .login(username: username, password: password))
    }
    
    var body: some View {
        VStack {
            Image("Icon")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .clipShape(Circle())
            
            Text("Connexion")
                .font(.title)
            
            Text("Connectez-vous à votre compte InvoiceKit")
                .font(.caption)
                .multilineTextAlignment(.center)
                .padding(.bottom)
            
            TextField("Nom d'utilisateur", text: $username)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(4)
                .padding([.leading, .trailing], 10)
            
            SecureField("Mot de passe", text: $password)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(4)
                .padding([.leading, .trailing], 10)
            
            HStack {
                Spacer()
                
                Text("Créer un compte")
                    .padding([.trailing])
                    .font(.footnote)
                    .foregroundColor(.gray)
            }.padding(.bottom)
            
            Button(action: login, label: {
                HStack {
                    Spacer()
                    
                    Text("Se connecter")
                        .bold()
                        .foregroundColor(.white)
                    
                    Spacer()
                }
            })
            .padding()
            .background(Color.green)
            .cornerRadius(4)
            .padding([.leading, .trailing], 10)
        }
        .onReceive(client.success) { model in
            // Store token and username
            keychain.set(model.token, forKey: "token")
            keychain.set(username, forKey: "username")
            keychain.set(password, forKey: "password")
            
            // Set as logged
            isLogged = true
        }
        .onReceive(client.error, perform: { error in
            // Display error
            
        })
    }
}

struct Authenticate_Previews: PreviewProvider {
    static var previews: some View {
        Authenticate(isLogged: .constant(false))
    }
}
