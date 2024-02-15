//
//  URLSessionHTTPClient.swift
//  SimpleFeed
//
//  Created by Caio Vasconcelos Ortu on 15/02/2024.
//

import Foundation

class URLSessionHTTPClient: HTTPClient {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    enum Error: Swift.Error {
        case invalidUrl
        case invalidParameters
        case invalidData
        case badRequest
        case serverError
        case connectivity
        case unsupported
        case unexpected
    }
    
    func send<ResponseType: Codable>(_ request: Request) async throws -> ResponseType {
        let urlRequest = try makeUrlRequest(request)
        let (data, response) = try await session.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw Error.unexpected
        }
        
        return try map(data, from: httpResponse)
    }
    
    private func makeUrlRequest(_ request: Request) throws -> URLRequest {
        guard let url = URL(string: request.path) else {
            throw Error.invalidUrl
        }
        return try handleParameters(request.parameters, for: url, method: request.method)
    }
    
    private func handleParameters(_ parameters: RequestParameters?, for url: URL, method: HTTPMethod) throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        switch method {
        case .get:
            urlRequest.url = try components(for: url, parameters: parameters)?.url
        default:
            urlRequest.httpBody = try bodyData(for: parameters)
        }
        
        return urlRequest
    }
    
    private func components(for url: URL, parameters: RequestParameters?) throws -> URLComponents? {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        switch parameters {
        case .query(let items):
            components?.queryItems = items.map { URLQueryItem(name: $0, value: $1) }
        default:
            throw Error.invalidParameters
        }
        
        return components
    }
    
    private func bodyData(for parameters: RequestParameters?) throws -> Data? {
        switch parameters {
        case .body:
            parameters?.rawData
        default:
            throw Error.invalidParameters
        }
    }
    
    private func map<ResponseType: Codable>(_ data: Data, from response: HTTPURLResponse) throws -> ResponseType {
        switch response.statusCode {
        case 200:
            do {
                return try JSONDecoder().decode(ResponseType.self, from: data)
            } catch {
                throw Error.invalidData
            }
        case 400...499:
            throw Error.badRequest
        case 500...599:
            throw Error.serverError
        default:
            throw Error.unsupported
        }
    }
}
