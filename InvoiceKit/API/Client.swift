//
//  Client.swift
//  InvoiceKit
//
//  Created by Victor Lourme on 24/09/2020.
//

import Foundation
import Moya
import Combine
import KeychainSwift

struct Client<Model: Codable> {
    ///
    /// Token
    ///
    var token: String? {
        // Get keychain
        let keychain = KeychainSwift()
        
        // Check in keychain
        if let token = keychain.get("token") {
            return token
        }
        
        return nil
    }
    
    ///
    /// Moya Provider
    ///
    var provider: MoyaProvider<Endpoint> {
        // Get plugins
        var plugins: [PluginType] = []
        
        // Assign token
        if let token = token {
            plugins.append(AccessTokenPlugin { _ in
                token
            })
        }
        
        // Return
        return MoyaProvider<Endpoint>(plugins: plugins)
    }
    
    ///
    /// Publisher for success codes
    ///
    var success = PassthroughSubject<Model, Never>()
    
    ///
    /// Publisher for errors
    ///
    var error = PassthroughSubject<Error, Never>()
    
    ///
    /// Execute
    /// - parameters:
    ///     - endpoint: Endpoint
    ///
    func execute(endpoint: Endpoint) {
        // Execute
        provider.request(endpoint) { result in
            switch result {
            case .success(let response):
                do {
                    // Filter success
                    let resp = try response.filterSuccessfulStatusCodes()
                    
                    // Get model
                    let model = try resp.map(Model.self)
                    
                    // Send to publisher
                    success.send(model)
                } catch let err {
                    error.send(err)
                }
            case .failure(let err):
                error.send(err)
            }
        }
    }
}
