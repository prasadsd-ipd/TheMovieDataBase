//
//  MoviesViewModelTests.swift
//  TheMovieDataBaseTests
//
//  Created by Durga Prasad, Sidde (623-Extern) on 30/08/20.
//  Copyright © 2020 SDP. All rights reserved.
//

import XCTest
@testable import TheMovieDataBase

class MoviewViewModelTests: XCTestCase {

    // MARK: - Properties
    let viewModel = MoviesViewModel()

    override func setUp() {
        super.setUp()
        
        // Load Stub
        let data = loadStub(name: "PopularMovies.json", extension: "")
        
        // Initialize JSON Decoder
        let decoder = JSONDecoder()

        // Initialize  Response
        let propularMovies = try! decoder.decode(PopularMovies.self, from: data)

        viewModel.moviesList = propularMovies.results

    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Tests for Number of movies

    func testNumberOfMovies() {
        XCTAssertEqual(viewModel.totalMovies, 20)
    }

    func testViewModelForIndex() {
        let movieCellViewModel = viewModel.cellViewModel(for: 3)
        
        XCTAssertEqual(movieCellViewModel.title, "The Boy Next Door")
        XCTAssertEqual(movieCellViewModel.releaseDate, "2015-01-23")
    }
}
