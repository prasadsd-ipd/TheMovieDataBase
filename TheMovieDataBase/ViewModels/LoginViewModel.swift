//
//  LoginViewModel.swift
//  TheMovieDataBase
//
//  Created by Durga Prasad, Sidde (623-Extern) on 27/08/20.
//  Copyright © 2020 SDP. All rights reserved.
//

import Foundation

class LoginViewModel {
    
    //MARK:-
    var requestToken: String?
    
    //MARK:- Initialization
    init() {
        initiateLoginProcess()
    }
    
    private func initiateLoginProcess() {
        
        URLSession.shared.dataTask(with: MovieServices.getRequestToken()) { [weak self] (data, response, error) in
            
            if let error = error {
                debugPrint("Token error \(error.localizedDescription)")
            } else if let data = data {
                debugPrint("token response \(data.count)")
                
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(TokenResponse.self, from: data)
                    self?.requestToken = response.requestToken
                    self?.createNewSession()
                } catch {
                    debugPrint("token parsing error \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    private func createNewSession() {
        
        let session = URLSession.shared
        var request = URLRequest(url: MovieServices.getNewSession())
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let sessionRequest = SessionRequestParameter(requestToken: MovieServices.getToken())
        do {
            let jsonData = try JSONEncoder().encode(sessionRequest)
            session.uploadTask(with: request, from: jsonData) { (data, response, error) in
                if let error = error {
                    debugPrint("session error \(error.localizedDescription)")
                } else if let data = data {
                    let json = try! JSONDecoder().decode(SessionResponse.self, from: data)
                    debugPrint("session response \(json)")
                }
            }.resume()
        } catch {
            debugPrint("token encoder error \(error.localizedDescription)")
        }
    }
}
