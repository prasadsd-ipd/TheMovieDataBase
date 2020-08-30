//
//  MovieCellViewModelTests.swift
//  TheMovieDataBaseTests
//
//  Created by Durga Prasad, Sidde (623-Extern) on 30/08/20.
//  Copyright © 2020 SDP. All rights reserved.
//

import XCTest
@testable import TheMovieDataBase

class MovieCellViewModelTests: XCTestCase {

    // MARK: - Properties
    var viewModel: MovieCellViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // Load Stub
        let data = loadStub(name: "PopularMovies.json", extension: "")
        
        // Initialize JSON Decoder
        let decoder = JSONDecoder()

        // Initialize  Response
        let propularMovies = try! decoder.decode(PopularMovies.self, from: data)

        viewModel = MovieCellViewModel(movieData: propularMovies.results[6])
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTitle() {
        XCTAssertEqual(viewModel.title, "Batman v Superman: Dawn of Justice")
    }
    
    func testReleaseDate() {
        XCTAssertEqual(viewModel.releaseDate, "2016-03-23")
    }

}
