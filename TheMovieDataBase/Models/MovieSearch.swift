//
//  MovieSearch.swift
//  TheMovieDataBase
//
//  Created by Durga Prasad, Sidde (623-Extern) on 29/08/20.
//  Copyright © 2020 SDP. All rights reserved.
//

import Foundation

// MARK: - MovieSearch
struct MovieSearch: Codable {
    let page, totalResults, totalPages: Int
    let results: [Result]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
