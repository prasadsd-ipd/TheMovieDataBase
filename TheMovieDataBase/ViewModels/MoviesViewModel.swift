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
        case noImageData
    }
    
    typealias DidFetchDataCompletion = (PopularMovies?, MoviesDataError?) -> Void
    typealias DidFetchImageDataCompletion = (Data?, MoviesDataError?) -> Void
    
    var didFetchDataCompletion: DidFetchDataCompletion?
    var didFetchImageDataCompletion: DidFetchImageDataCompletion?
    
    //MARK:- Initialization
    init() {
        fetchMoviesData()
    }
    
    //MARK:- Fetching Methods
    /// Fetches movies list
    func fetchMoviesData(forPage: Int = 1) {

        URLSession.shared.dataTask(with: MovieServices.findPopularMovies(pageNo: forPage)) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    debugPrint("request failed with error \(error.localizedDescription)")
                    self?.didFetchDataCompletion?(nil, .noMoviesData)
                } else if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let trendingMovies = try decoder.decode(PopularMovies.self, from: data)
                        self?.didFetchDataCompletion?(trendingMovies, nil)
                    } catch {
                        debugPrint("error in decoding \(error.localizedDescription)")
                        self?.didFetchDataCompletion?(nil, .noMoviesData)
                    }
                }
            }
        }.resume()
    }

    /// Fetch image from remote location
    func getImageData(with imageName: String, onCompletion: @escaping (Data?, Error?)->Void) {
        
        if let imageURL = MovieServices.imageBaseURL?.appendingPathComponent(imageName) {
            URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        debugPrint("No image data \(error)")
                        onCompletion(nil, error)
                    } else if let data = data {
                        onCompletion(data, nil)
                    }
                }
            }.resume()
        }
    }
    
    /// Fetch search result
    func doSearch(for searchString: String, inPage: Int = 1, onCompletion: @escaping ([Result]?, Error?)->Void) {
        
        URLSession.shared.dataTask(with: MovieServices.searchMovies(with: searchString, pageNo: inPage)) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    onCompletion(nil, error)
                } else if let data = data {
                    do {
                        let searchResult = try JSONDecoder().decode(MovieSearch.self, from: data)
                        debugPrint("Search Results: \(searchResult.results)")
                        onCompletion(searchResult.results,nil)
                    } catch {
                        onCompletion(nil, error)
                    }
                }
            }
        }.resume()
    }
    
    func dateFormatter(_ date: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        guard let requiredDate = dateFormatter.date(from: date) else { return date }
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: requiredDate)
    }
}
