//
//  MoviesViewModel.swift
//  TheMovieDataBase
//
//  Created by Durga Prasad, Sidde (623-Extern) on 27/08/20.
//  Copyright © 2020 SDP. All rights reserved.
//

import Foundation

class MoviesViewModel {
    
    //MARK:- Types
    enum MoviesDataError {
        case noMoviesData
    }
    
    typealias DidFetchDataCompletion = (TrendingMovies?, MoviesDataError?) -> Void
    
    var didFetchDataCompletion: DidFetchDataCompletion?
    
    //MARK:- Initialization
    init() {
        fetchMoviesData()
    }
    
    //MARK:- 
    private func fetchMoviesData() {

        URLSession.shared.dataTask(with: MovieServices.trendingMovies) { [weak self] (data, response, error) in
            if let error = error {
                print("request failed with error \(error.localizedDescription)")
                self?.didFetchDataCompletion?(nil, .noMoviesData)
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let trendingMovies = try decoder.decode(TrendingMovies.self, from: data)
                    self?.didFetchDataCompletion?(trendingMovies, nil)
                } catch {
                    print("error in decoding \(error.localizedDescription)")
                    self?.didFetchDataCompletion?(nil, .noMoviesData    )
                }
            }
        }.resume()
    }

}
