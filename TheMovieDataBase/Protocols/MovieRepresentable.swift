//
//  MovieRepresentable.swift
//  TheMovieDataBase
//
//  Created by Durga Prasad, Sidde (623-Extern) on 30/08/20.
//  Copyright © 2020 SDP. All rights reserved.
//

import UIKit

protocol MovieRepresentable {
    
    var title: String { get }
    var releaseDate: String { get }
    var overview: String { get }
    var posterPath: String { get }
}
