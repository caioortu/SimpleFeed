//
//  Request.swift
//  SimpleFeed
//
//  Created by Caio Vasconcelos Ortu on 15/02/2024.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

enum RequestParameters {
    
    case body(_: [String: Any]?)
    case query(items: [(key: String, value: String)])
    
    var rawData: Data? {
        switch self {
        case .body(let body):
            guard let body = body else { return nil }
            return try? JSONSerialization.data(withJSONObject: body, options: [])
        default:
            return nil
        }
    }
}

protocol Request {
    var path: String { get }

    var method: HTTPMethod { get }

    var parameters: RequestParameters? { get }

    var headers: [String: Any]? { get }
}
