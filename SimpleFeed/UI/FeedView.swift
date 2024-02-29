//
//  FeedView.swift
//  SimpleFeed
//
//  Created by Caio Vasconcelos Ortu on 15/02/2024.
//

import SwiftUI

struct FeedView: View {
    
    @StateObject var viewModel: FeedViewModel
    
    var body: some View {
        content
            .task {
                await viewModel.fetchPosts()
            }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            Text("Loading!!")
        case .loaded:
            NavigationStack {
                List {
                    ForEach(viewModel.posts) { post in
                        Text(post.title)
                    }
                }
                .navigationTitle("Simple Feed")
            }
        case .error:
            Text("Oops")
        }
    }
}

#Preview {
    let client = URLSessionHTTPClient()
    let service = PostService(client: client)
    let useCase = GetPostsUseCase(service: service)
    let viewModel = FeedViewModel(useCase: useCase)
    
    return FeedView(viewModel: viewModel)
}
