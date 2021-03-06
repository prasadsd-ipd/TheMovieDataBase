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
    private static let requestToken = "027eb84b92ffe18c49e2da69b7a8918811dd5991"
    private static let scheme = "https"
    private static let host = "api.themoviedb.org"
    
    private static let baseURL = URL(string: "https://api.themoviedb.org/3/")!
    private static let authenticateAPI = "authentication"
    private static let tokenRequestAPI = "token/new"
    private static let popular = "movie/popular"
    static let imageBaseURL = URL(string: "https://image.tmdb.org/t/p/w185")

    private static var queryItems: [URLQueryItem] {
        return [URLQueryItem(name: "api_key", value: apiKey)]
    }
    
    private static var authURL: URL {
        return baseURL.appendingPathComponent(authenticateAPI)
    }
    
//    static var requestToken: URL {
//        var urlComponent = URLComponents(url: authURL.appendingPathComponent(tokenRequestAPI), resolvingAgainstBaseURL: true)
//        urlComponent?.queryItems = queryItems
//
//        return (urlComponent?.url)!
//    }
    
    //MARK:- Login Process methods
    static func getRequestToken() -> URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = "/3/authentication/token/new"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
        ]
        return components.url!
    }
    
    static func getToken() -> String {
        return requestToken
    }
    
    static func getNewSession() -> URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = "/3/authentication/session/new"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
        ]
        return components.url!
    }
    
    //MARK:- Get Popular Movies
    static func findPopularMovies(pageNo: Int) -> URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = "/3/movie/popular"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "page", value: "\(pageNo)")
        ]
        return components.url!
    }
    
    //MARK:- Search Movies
    static func searchMovies(with key:String, pageNo: Int) -> URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = "/3/search/movie"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "query", value: key),
            URLQueryItem(name: "page", value: "\(pageNo)")
        ]
        return components.url!
    }
}
