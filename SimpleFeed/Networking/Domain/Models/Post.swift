//
//  Post.swift
//  SimpleFeed
//
//  Created by Caio Vasconcelos Ortu on 15/02/2024.
//

import Foundation

struct Post: Codable, Identifiable {
    let id: UUID
    let userId: Int
    let title: String
    let body: String
}
