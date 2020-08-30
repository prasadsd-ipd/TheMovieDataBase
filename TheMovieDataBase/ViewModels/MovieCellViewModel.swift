//
//  MovieCellViewModel.swift
//  TheMovieDataBase
//
//  Created by Durga Prasad, Sidde (623-Extern) on 30/08/20.
//  Copyright © 2020 SDP. All rights reserved.
//

import UIKit

struct MovieCellViewModel {
    
    // MARK: - Properties
    
    let movieData: MovieRepresentable?
    
    // MARK: -
    var title: String {
        return movieData?.title ?? "Movie Title"
    }
    
    var releaseDate: String {
        return movieData?.releaseDate ?? "Movie Release Date"
    }
    
    var overview: String {
        return movieData?.overview ?? "Movie Description"
    }
    
    var posterPath: String {
        return movieData?.posterPath ?? "Movie Poster"
    }
    
}

extension MovieCellViewModel: MovieRepresentable {

}
