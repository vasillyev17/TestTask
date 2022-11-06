//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by ihor on 03.11.2022.
//

import Foundation
import RxSwift
import RxDataSources

class NewsViewModel {
    var users = BehaviorSubject(value: [SectionModel(model: "", items: [Article]())])
    
    func fetchNews() {
        guard let url = URL(string: "https://gnews.io/api/v4/search?q=example&token=25333cb5b66001b683002cd8e04d3003") else { return }
        let task = URLSession.shared.dataTask(with: url) { (data,response, error) in
            DispatchQueue.main.async {
                guard let data = data else { return }
                do {
                    let responseData = try? JSONDecoder().decode(News.self, from: data)
                    let sectionOffline = SectionModel(model: "First", items: [Article(title: "First", description: "description description description description description description description description description description", content: "content", url: "url", image: "image", publishedAt: "date", source: Source(name: "name", url: "url"))])
                    let secondSection = SectionModel(model: "News", items: responseData?.articles ?? [])
                    
                    self.users.on(.next([secondSection]))
                }
            }
        }
        task.resume()
    }
}
