//
//  GetPostsUseCase.swift
//  SimpleFeed
//
//  Created by Caio Vasconcelos Ortu on 15/02/2024.
//

import Foundation

protocol GetPostsUseCaseProtocol {
    func execute() async throws -> [Post]
}

class GetPostsUseCase {
    
    private let service: PostServiceProtocol
    
    init(service: PostServiceProtocol) {
        self.service = service
    }
}

extension GetPostsUseCase: GetPostsUseCaseProtocol {
    func execute() async throws -> [Post] {
        return try await service.getPosts()
    }
}
