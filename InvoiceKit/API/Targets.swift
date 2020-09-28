//
//  Targets.swift
//  InvoiceKit
//
//  Created by Victor Lourme on 24/09/2020.
//

import Foundation
import Moya

extension Endpoint: TargetType, AccessTokenAuthorizable {
    var baseURL: URL {
        URL(string: "https://invoicekit.herokuapp.com")!
    }
    
    var path: String {
        switch self {
        case .login:
            return "/teams/login"
        case .getUser:
            return "/teams/"
        case .getCharts:
            return "/charts"
        case .getCustomers:
            return "/customers"
        case let .getCustomer(id):
            return "/customers/\(id)"
        case .getInvoices:
            return "/invoices"
        case let .getInvoice(id):
            return "/invoices/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        Data()
    }
    
    var authorizationType: AuthorizationType? {
        switch self {
        case .login:
            return nil
            
        default:
            return .bearer
        }
    }
    
    var task: Task {
        switch self {
        case let .login(username, password):
            return .requestParameters(
                parameters: [
                    "username": username,
                    "password": password
                ],
                encoding: JSONEncoding.default
            )
        case .getCustomers:
            return .requestParameters(parameters: [
                                        "per": 10000000
            ], encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [
            "User-Agent": "InvoiceKit-iOS/1.0"
        ]
    }
}
