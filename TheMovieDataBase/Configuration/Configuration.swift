//
//  Configuration.swift
//  TheMovieDataBase
//
//  Created by Durga Prasad, Sidde (623-Extern) on 26/08/20.
//  Copyright © 2020 SDP. All rights reserved.
//

import Foundation

enum MovieServices {
    private static let apiKey = "552b2948e65db67e9f5053ea36973232"
    private static let baseURL = URL(string: "https://api.themoviedb.org/3/")!
    private static let authenticateAPI = "authentication"
    private static let tokenRequestAPI = "token/new"
    private static let trendingAPI = "trending/movie/day"
    
    private static var queryItems: [URLQueryItem] {
        return [URLQueryItem(name: "api_key", value: apiKey)]
    }
    
    private static var authURL: URL {
        return baseURL.appendingPathComponent(authenticateAPI)
    }
    
    static var requestToken: URL {
        var urlComponent = URLComponents(url: authURL.appendingPathComponent(tokenRequestAPI), resolvingAgainstBaseURL: true)
        urlComponent?.queryItems = queryItems
        
        return (urlComponent?.url)!
    }
    
    static var trendingMovies: URL {
        var urlComponent = URLComponents(url: baseURL.appendingPathComponent(trendingAPI), resolvingAgainstBaseURL: true)
        urlComponent?.queryItems = queryItems
        
        return (urlComponent?.url)!
    }
    
    static let imageBaseURL = "http://image.tmdb.org/t/p/"
}
