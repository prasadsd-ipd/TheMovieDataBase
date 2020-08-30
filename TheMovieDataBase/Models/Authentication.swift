//
//  Authentication.swift
//  TheMovieDataBase
//
//  Created by Durga Prasad, Sidde (623-Extern) on 27/08/20.
//  Copyright © 2020 SDP. All rights reserved.
//

import Foundation

//MARK:- TokenResponse
struct TokenResponse: Decodable {
    let success: Bool
    let expiresAt, requestToken: String

    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}

//MARK:- SessionRequest
struct SessionRequestParameter: Encodable {
    let requestToken: String
    
    enum CodingKeys: String, CodingKey {
        case requestToken = "request_token"
    }
}

//MARK:- SessionResponse
struct SessionResponse: Decodable {
    let success: Bool
    let sessionID: String?
    let statusMessage: String?

    enum CodingKeys: String, CodingKey {
        case success
        case sessionID = "session_id"
        case statusMessage = "status_message"
    }
}

// MARK: - LoginRequest
struct LoginRequest: Encodable {
    let username, password, requestToken: String

    enum CodingKeys: String, CodingKey {
        case username, password
        case requestToken = "request_token"
    }
}

// MARK: - LoginResponse
struct LoginResponse: Decodable {
    let success: Bool
    let expiresAt, requestToken: String

    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}
