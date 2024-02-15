//
//  GetPostCommentsUseCase.swift
//  SimpleFeed
//
//  Created by Caio Vasconcelos Ortu on 15/02/2024.
//

import Foundation

protocol GetPostCommentsUseCaseProtocol {
    func execute(postId: String) async throws -> [Comment]
}

final class GetPostCommentsUseCase {
    
    private let service: PostServiceProtocol
    
    init(service: PostServiceProtocol) {
        self.service = service
    }
}

extension GetPostCommentsUseCase: GetPostCommentsUseCaseProtocol {
    func execute(postId: String) async throws -> [Comment] {
        return try await service.getPostComments(postId: postId)
    }
}
