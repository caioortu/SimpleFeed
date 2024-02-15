//
//  GetPostUseCase.swift
//  SimpleFeed
//
//  Created by Caio Vasconcelos Ortu on 15/02/2024.
//

import Foundation

protocol GetPostUseCaseProtocol {
    func execute(id: String) async throws -> Post
}

final class GetPostUseCase {
    
    private let service: PostServiceProtocol
    
    init(service: PostServiceProtocol) {
        self.service = service
    }
}

extension GetPostUseCase: GetPostUseCaseProtocol {
    func execute(id: String) async throws -> Post {
        return try await service.getPost(id: id)
    }
}
