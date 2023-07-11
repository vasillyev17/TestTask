//
//  Lists.swift
//  NYTBooks
//
//  Created by ihor on 04.07.2023.
//

import Foundation
import CoreData

struct Lists: Codable {
    let status: String
    let copyright: String
    let num_results: Int
    let results: [ListResult]
}

struct ListResult: Codable {
    let list_name: String
    let display_name: String
    let list_name_encoded: String
    let oldest_published_date: String
    let newest_published_date: String
}
