//
//  Post.swift
//  U-News
//
//  Created by ihor on 22.09.2022.
//

import SwiftUI

struct Posts: Codable {
    var articles: [Post]
    let status: String
    let totalResults: Int
}

struct Post: Codable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct Source: Codable {
    let name: String
}
