//
//  PostRequest.swift
//  SimpleFeed
//
//  Created by Caio Vasconcelos Ortu on 15/02/2024.
//

import Foundation

enum PostRequest: Request {
    
    case posts
    case post(id: String)
    case comments(postId: String)
    
    var path: String {
        let baseUrl = "https://jsonplaceholder.typicode.com/posts"
        switch self {
        case .posts:
            return baseUrl
        case .post(let id):
            return "\(baseUrl)/\(id)"
        case .comments(let postId):
            return "\(baseUrl)/\(postId)/comments"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: RequestParameters? {
        return nil
    }
    
    var headers: [String : Any]? {
        return nil
    }
}
