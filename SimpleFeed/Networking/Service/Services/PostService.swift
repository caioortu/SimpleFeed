//
//  PostService.swift
//  SimpleFeed
//
//  Created by Caio Vasconcelos Ortu on 15/02/2024.
//

import Foundation

final class PostService {
    
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
}

extension PostService: PostServiceProtocol {
    func getPosts() async throws -> [Post] {
        let request = PostRequest.posts
        return try await client.send(request)
    }
    
    func getPost(id: String) async throws -> Post {
        let request = PostRequest.post(id: id)
        return try await client.send(request)
    }
    
    func getPostComments(postId: String) async throws -> [Comment] {
        let request = PostRequest.comments(postId: postId)
        return try await client.send(request)
    }
}
