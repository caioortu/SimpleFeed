//
//  Comment.swift
//  SimpleFeed
//
//  Created by Caio Vasconcelos Ortu on 15/02/2024.
//

import Foundation

struct Comment: Codable, Identifiable {
    let postId: Int
    let id: UUID
    let name: String
    let email: String
    let body: String
}
