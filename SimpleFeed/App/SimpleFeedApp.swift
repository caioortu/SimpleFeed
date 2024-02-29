//
//  SimpleFeedApp.swift
//  SimpleFeed
//
//  Created by Caio Vasconcelos Ortu on 15/02/2024.
//

import SwiftUI

@main
struct SimpleFeedApp: App {
    
    @StateObject var viewModel: FeedViewModel = {
        let client = URLSessionHTTPClient()
        let service = PostService(client: client)
        let useCase = GetPostsUseCase(service: service)
        
        return FeedViewModel(useCase: useCase)
    }()
    
    var body: some Scene {
        WindowGroup {
            FeedView(viewModel: viewModel)
        }
    }
}
