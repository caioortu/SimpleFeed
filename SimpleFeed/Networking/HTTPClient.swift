//
//  HTTPClient.swift
//  SimpleFeed
//
//  Created by Caio Vasconcelos Ortu on 15/02/2024.
//

import Foundation

protocol HTTPClient {
    func send<ResponseType: Codable>(_ request: Request) async throws -> ResponseType
}
