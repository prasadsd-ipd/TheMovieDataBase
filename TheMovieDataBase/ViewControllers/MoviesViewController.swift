//
//  MoviesViewController.swift
//  TheMovieDataBase
//
//  Created by Durga Prasad, Sidde (623-Extern) on 26/08/20.
//  Copyright © 2020 SDP. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    //MARK:- Types
    private enum Alerts {
        case noDataAvailable
    }
    
    //MARK:- Properties
    var viewModel: MoviesViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            setupViewModel(with: viewModel)
        }
    }
    
    //MARK:- 
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func setupViewModel(with viewModel: MoviesViewModel) {
        viewModel.didFetchDataCompletion = { [weak self] (moviesData, error) in
            if error != nil {
                self?.showAlert(of: .noDataAvailable)
            } else if let moviesData = moviesData {
                for movie in moviesData.results {
                    print("\(movie.title) released on \(movie.releaseDate) has \(movie.popularity)")
                }
            } else {
                self?.showAlert(of: .noDataAvailable)
            }
        }
    }
    
    private func showAlert(of type: Alerts) {
        let title: String
        let message: String
        
        switch type {
        case .noDataAvailable:
            title = "Unable to fetch data"
            message = "The application is unable to fetch data. Please check your network connection."
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true)
    }
}
