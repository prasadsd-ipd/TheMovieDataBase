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
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    private var searchController: UISearchController!
    
    private var shouldShowSearchResults = false
        
    private var currentPage = 1
    
    private let refreshControl = UIRefreshControl()
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController()
        moviesTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshMovieData(_:)), for: .valueChanged)
    }
    
    //MARK:- Custom Methods
    private func setupViewModel(with viewModel: MoviesViewModel) {
        viewModel.didFetchDataCompletion = { [weak self] (error) in
            if error != nil {
                self?.showAlert(of: .noDataAvailable)
            } else {
                self?.moviesTableView.reloadData()
            }
        }
        if self.refreshControl.isRefreshing {
            self.refreshControl.endRefreshing()
        }
    }
    
    @objc private func refreshMovieData(_ sender: Any) {
        self.viewModel?.fetchMoviesData()
    }
    
    ///Helper mehtod to show alerts
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

//MARK:- UITableViewDataSource & UITableViewDelegate
extension MoviesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.totalMovies ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.reuseIdentifier, for: indexPath) as? MovieTableViewCell else {
            fatalError("Unable to DequeueTable View Cell")
        }

        guard let viewModel = viewModel else {
            fatalError("No View Model Present")
        }
        
        // Configure Cell
        cell.configure(with: viewModel.cellViewModel(for: indexPath.row))
        
//        if indexPath.row == viewModel.totalMovies - 1 {
//            self.currentPage += 1
//            self.viewModel?.fetchMoviesData(forPage: self.currentPage)
//        }
        return cell
    }
    
    /// To load next available data
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let viewModel = viewModel else {
            fatalError("No View Model Present")
        }
        
        // Will load new content when scrolled to last cell
        if indexPath.row == viewModel.totalMovies - 1 {
            self.currentPage += 1
            // Fetchs next page data
            if shouldShowSearchResults {
                self.viewModel?.doSearch(for: searchController.searchBar.text!, inPage: self.currentPage, onCompletion: { [weak self] (results, error) in
                    DispatchQueue.main.async {
                        if error != nil {
                            debugPrint("Error while searching: \(String(describing: error?.localizedDescription))")
                            self?.showAlert(of: .noDataAvailable)
                        } else if results != nil {
                            self?.moviesTableView.reloadData()
                        }
                    }
                })
            }
            self.viewModel?.fetchMoviesData(forPage: self.currentPage)
        }
    }
}

extension MoviesViewController: UISearchBarDelegate, UISearchResultsUpdating {
        
    private func configureSearchController() {
        // Initialize and perform a minimum configuration to the search controller.
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for movies here..."
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        
        // Placeing the search bar to the tableview headerview.
        moviesTableView.tableHeaderView = searchController.searchBar
    }

    //MARK:- UISearchBarDelegate methods
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        print("begin editing")
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        print("cancel clicked")
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            moviesTableView.reloadData()
        }
        print("begin editing")
        searchController.searchBar.resignFirstResponder()
    }
    
    //MARK:- UISearchResultsUpdating methods
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchString = searchController.searchBar.text else {
            return
        }
        self.viewModel?.doSearch(for: searchString, onCompletion: { [weak self] (results, error) in
            DispatchQueue.main.async {
                if error != nil {
                    debugPrint("Error while searching: \(String(describing: error?.localizedDescription))")
                    self?.showAlert(of: .noDataAvailable)
                } else if results != nil {
                    self?.viewModel?.moviesList = results!
                    self?.moviesTableView.reloadData()
                }
            }
        })
    }
}
