//
//  PostServiceProtocol.swift
//  SimpleFeed
//
//  Created by Caio Vasconcelos Ortu on 15/02/2024.
//

import Foundation

protocol PostServiceProtocol {
    func getPosts() async throws -> [Post]
    func getPost(id: String) async throws -> Post
    func getPostComments(postId: String) async throws -> [Comment]
}
