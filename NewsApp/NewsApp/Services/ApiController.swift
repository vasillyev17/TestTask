//
//  ApiController.swift
//  NewsApp
//
//  Created by ihor on 06.11.2022.
//

import RxSwift
import RxCocoa
import UIKit

class ApiController {
  static var shared = ApiController()

  func urlString(searchText: String) -> URL {
    guard let encodedText = searchText.addingPercentEncoding(withAllowedCharacters:
                                                                CharacterSet.urlQueryAllowed) else { return URL(fileURLWithPath: "") }
    
    let urlString = String(format:"https://gnews.io/api/v4/search?q=\(encodedText)&token=25333cb5b66001b683002cd8e04d3003")
      let url = URL(string: urlString)
      return url ?? URL(fileURLWithPath: "")
  }

  func parse(data: Data) -> [Article] {
    do {
        let decoder = JSONDecoder()
        let result = try decoder.decode(News.self, from:data)
        return result.articles
    } catch {
        print("Error: \(error)")
        return [Article(title: "", description: "", content: "", url: "", image: "", publishedAt: "", source: Source(name: "", url: ""))]
    }
  }

  func search(search term: String) -> Observable<[Article]> {
    let url = urlString(searchText: term)
    let request = URLRequest(url: url)
    let session = URLSession.shared
    return session.rx.data(request: request).map { self.parse(data: $0) }
  }
}
