//
//  MoviesViewModel.swift
//  TheMovieDataBase
//
//  Created by Durga Prasad, Sidde (623-Extern) on 27/08/20.
//  Copyright © 2020 SDP. All rights reserved.
//

import Foundation
import Reachability

let reachability = try! Reachability()

class MoviesViewModel {
    
    //MARK:- Types
    
    enum MoviesDataError {
        case noMoviesData
        case noImageData
    }
    
    typealias DidFetchDataCompletion = (MoviesDataError?) -> Void

    //MARK:- Properties
    
    var didFetchDataCompletion: DidFetchDataCompletion?
    
    var moviesList: [MovieRepresentable]?
    
    var totalMovies: Int {
        return moviesList?.count ?? 0
    }
    
    //MARK:- Initialization
    
    init() {
        fetchMoviesData()
    }
    
    func cellViewModel(for index: Int) -> MovieCellViewModel {
        return MovieCellViewModel(movieData: moviesList?[index])
    }
    
    //MARK:- Helper Methods
    /// Fetches movies list
    func fetchMoviesData(forPage: Int = 1) {

        //Initialising Request
        let fetchMoviesRequest = MovieServices.findPopularMovies(pageNo: forPage)
        
        //Create data task
        URLSession.shared.dataTask(with: fetchMoviesRequest) { [weak self] (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    debugPrint("request failed with error \(error.localizedDescription)")
                    self?.didFetchDataCompletion?(.noMoviesData)
                } else if let data = data {
                    //Initialising Json Decoder
                    let decoder = JSONDecoder()
                    
                    do {
                        let trendingMovies = try decoder.decode(PopularMovies.self, from: data)
                        self?.moviesList = trendingMovies.results
                        self?.didFetchDataCompletion?(nil)
                    } catch {
                        debugPrint("error in decoding \(error)")
                        self?.didFetchDataCompletion?(.noMoviesData)
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
