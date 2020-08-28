//
//  MovieRequest.swift
//  TheMovieDataBase
//
//  Created by Durga Prasad, Sidde (623-Extern) on 26/08/20.
//  Copyright © 2020 SDP. All rights reserved.
//

import Foundation

// MARK: - TrendingMovies
struct TrendingMovies: Codable {
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let video: Bool
    let voteCount: Int
    let voteAverage: Double
    let title, releaseDate: String
    let originalLanguage: OriginalLanguage
    let originalTitle: String
    let genreIDS: [Int]
    let backdropPath: String
    let adult: Bool
    let overview, posterPath: String
    let popularity: Double
    let mediaType: MediaType

    enum CodingKeys: String, CodingKey {
        case id, video
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case title
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult, overview
        case posterPath = "poster_path"
        case popularity
        case mediaType = "media_type"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
    case person = "person"
    case all = "all"
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case es = "es"
    case ko = "ko"
}
