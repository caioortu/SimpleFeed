//
//  FeedViewModel.swift
//  SimpleFeed
//
//  Created by Caio Vasconcelos Ortu on 15/02/2024.
//

import Foundation

final class FeedViewModel: ObservableObject {
    
    enum State {
        case loading
        case loaded
        case error
    }
    
    private let useCase: GetPostsUseCase
    
    @Published var posts = [Post]()
    @Published private(set) var state: State = .loaded
    
    init(useCase: GetPostsUseCase) {
        self.useCase = useCase
    }
    
    @MainActor
    func fetchPosts() async {
        state = .loading
        do {
            posts = try await useCase.execute()
            state = .loaded
        } catch {
            state = .error
        }
    }
}
