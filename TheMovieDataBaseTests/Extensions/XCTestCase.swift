//
//  XCTestCase.swift
//  TheMovieDataBaseTests
//
//  Created by Durga Prasad, Sidde (623-Extern) on 30/08/20.
//  Copyright © 2020 SDP. All rights reserved.
//

import XCTest

extension XCTestCase {

    func loadStub(name: String, extension: String) -> Data {
        let bundle = Bundle(for: classForCoder)
        let url = bundle.url(forResource: name, withExtension: `extension`)
        
        return try! Data(contentsOf: url!)
    }
}
