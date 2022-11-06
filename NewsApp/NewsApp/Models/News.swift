//
//  News.swift
//  NewsApp
//
//  Created by ihor on 03.11.2022.
//

import Foundation

struct News: Codable {
    let totalArticles: Int
    var articles: [Article]
}

struct Article: Codable {
    let title: String
    let description: String
    let content: String
    let url: String
    let image: String
    let publishedAt: String
    let source: Source
}

struct Source: Codable {
    let name: String
    let url: String
}

extension News: Sequence {
    public func makeIterator() -> CountableRange<Int>.Iterator {
        return (0..<totalArticles).makeIterator()
    }
}
