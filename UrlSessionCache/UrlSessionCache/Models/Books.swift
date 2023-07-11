//
//  Books.swift
//  UrlSessionCache
//
//  Created by ihor on 10.07.2023.
//

import Foundation

struct Books: Codable {
    let status: String
    let copyright: String
    let num_results: Int
    let last_modified: String
    var results: BookResult
}

struct BookResult: Codable {
    let list_name: String
    let list_name_encoded: String
    let bestsellers_date: String
    let published_date: String
    let published_date_description: String
    let next_published_date: String
    let previous_published_date: String
    let display_name: String
    let normal_list_ends_at: Int
    var books: [Book]
}

struct Book: Codable {
    let rank: Int
    let rank_last_week: Int
    let weeks_on_list: Int
    let asterisk: Int
    let dagger: Int
    let primary_isbn10: String
    let primary_isbn13: String
    let publisher: String
    let description: String
    let price: String
    let title: String
    let author: String
    let contributor: String
    let contributor_note: String
    let book_image: String
    let book_image_width: Int
    let book_image_height: Int
    let amazon_product_url: String
    let age_group: String
    let book_review_link: String
    let first_chapter_link: String
    let sunday_review_link: String
    let article_chapter_link: String
    let book_uri: String
}

struct Link: Codable {
    let name: String
    let url: String
}
