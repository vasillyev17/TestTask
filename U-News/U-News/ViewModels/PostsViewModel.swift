//
//  PostsViewModel.swift
//  U-News
//
//  Created by ihor on 22.09.2022.
//

import Foundation

class PostsViewModel {
    @Published private(set) var posts: [Post] = []
    
    func loadPosts() {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=ua&apiKey=bcdc6e8dce7646b5a9219c49e16b8e06") else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let data = data {
                print(data)
                if let posts = try? JSONDecoder().decode(Posts.self, from: data) {
                    DispatchQueue.main.async {
                        self?.posts = posts.articles
                    }
                } else {
                    print("Invalid Response")
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
            
        }
        task.resume()
    }
}

extension PostsViewModel: ObservableObject {}
